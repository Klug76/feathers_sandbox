package
{
	import feathers.core.FeathersControl;
	import feathers.layout.ILayout;
	import feathers.layout.LayoutBoundsResult;
	import feathers.layout.ViewPortBounds;
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.utils.MathUtil;

	[Event(name = "change", type = "starling.events.Event")]

	public class PercentLayout extends EventDispatcher implements ILayout
	{
		protected var clip_by_parent_: Boolean;

		public function PercentLayout()
		{}

		public function get requiresLayoutOnScroll(): Boolean
		{
			return false;
		}

		public function get clip_by_parent(): Boolean
		{
			return clip_by_parent_;
		}

		public function set clip_by_parent(value: Boolean): void
		{
			if (clip_by_parent_ == value)
				return;
			clip_by_parent_ = value;
			dispatchEventWith(Event.CHANGE);
		}

		public function layout(items: Vector.<DisplayObject>, viewPortBounds: ViewPortBounds = null, result: LayoutBoundsResult = null): LayoutBoundsResult
		{
			var boundsX: Number			= viewPortBounds ? viewPortBounds.x : 0;
			var boundsY: Number			= viewPortBounds ? viewPortBounds.y : 0;
			var minWidth: Number		= viewPortBounds ? viewPortBounds.minWidth : 0;
			var minHeight: Number		= viewPortBounds ? viewPortBounds.minHeight : 0;
			//var maxWidth: Number		= viewPortBounds ? viewPortBounds.maxWidth : Number.POSITIVE_INFINITY;
			//var maxHeight: Number		= viewPortBounds ? viewPortBounds.maxHeight : Number.POSITIVE_INFINITY;
			var explicitWidth: Number	= viewPortBounds ? viewPortBounds.explicitWidth : NaN;
			var explicitHeight: Number	= viewPortBounds ? viewPortBounds.explicitHeight : NaN;

			var viewPortWidth: Number = explicitWidth;
			var viewPortHeight: Number = explicitHeight;

			var needsWidth: Boolean = explicitWidth !== explicitWidth; //isNaN
			var needsHeight: Boolean = explicitHeight !== explicitHeight; //isNaN
			//:children can not resize parent
			if(needsWidth)
				viewPortWidth = minWidth;
			if(needsHeight)
				viewPortHeight = minHeight;

			this.place_Items(items, boundsX, boundsY, viewPortWidth, viewPortHeight);

			if(!result)
				result = new LayoutBoundsResult();
			result.contentWidth		= viewPortWidth;
			result.contentHeight	= viewPortHeight;
			result.viewPortWidth	= viewPortWidth;
			result.viewPortHeight	= viewPortHeight;
			return result;
		}

		protected function place_Items(items: Vector.<DisplayObject>, boundsX: Number, boundsY: Number, viewPortWidth: Number, viewPortHeight: Number): void
		{
			//trace("place_Items ", viewPortWidth, "x", viewPortHeight);
			var itemCount: int = items.length;
			var percent1width: Number = viewPortWidth * 0.01;
			var percent1height: Number = viewPortHeight * 0.01;
			for (var i: int = 0; i < itemCount; ++i)
			{
				var fc: FeathersControl = items[i] as FeathersControl;
				if (!fc)
					continue;//:support for FeathersControls only
				if(!fc.includeInLayout)
					continue;
				var layoutData: PercentLayoutData = fc.layoutData as PercentLayoutData;
				if(!layoutData)
					continue;
				var nx: Number	= percent1width * layoutData.perc_x + layoutData.pix_x;
				var nx2: Number	= percent1width * layoutData.perc_x2 - layoutData.pix_x2;
				var ny: Number	= percent1height * layoutData.perc_y + layoutData.pix_y;
				var ny2: Number	= percent1height * layoutData.perc_y2 - layoutData.pix_y2;
				if (clip_by_parent_)
				{
					nx = MathUtil.clamp(nx, 0, viewPortWidth);
					ny = MathUtil.clamp(ny, 0, viewPortHeight);
					nx2 = MathUtil.clamp(nx2, 0, viewPortWidth);
					ny2 = MathUtil.clamp(ny2, 0, viewPortHeight);
				}
				nx += boundsX;
				ny += boundsY;
				nx2 += boundsX;
				ny2 += boundsY;
				fc.move(nx, ny);
				fc.setSize(nx2 - nx, ny2 - ny);
			}
		}

		public function getScrollPositionForIndex(index: int, items: Vector.<DisplayObject>, x: Number, y: Number, width: Number, height: Number, result: Point = null): Point
		{//:no scroll
			if(!result)
				result = new Point();
			result.x = 0;
			result.y = 0;
			return result;
		}

		public function getNearestScrollPositionForIndex(index: int, scrollX: Number, scrollY: Number, items: Vector.<DisplayObject>, x: Number, y: Number, width: Number, height: Number, result: Point = null): Point
		{
			return this.getScrollPositionForIndex(index, items, x, y, width, height, result);
		}
	}
}