package
{
	import feathers.core.FeathersControl;
	import feathers.layout.ILayout;
	import feathers.layout.LayoutBoundsResult;
	import feathers.layout.ViewPortBounds;
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	import starling.utils.MathUtil;

	public class PercentLayout extends EventDispatcher implements ILayout
	{

		public function PercentLayout()
		{}

		public function get requiresLayoutOnScroll(): Boolean
		{
			return false;
		}

		public function layout(items: Vector.<DisplayObject>, viewPortBounds: ViewPortBounds = null, result: LayoutBoundsResult = null): LayoutBoundsResult
		{
			var boundsX: Number			= viewPortBounds ? viewPortBounds.x : 0;
			var boundsY: Number			= viewPortBounds ? viewPortBounds.y : 0;
			var minWidth: Number		= viewPortBounds ? viewPortBounds.minWidth : 0;
			var minHeight: Number		= viewPortBounds ? viewPortBounds.minHeight : 0;
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
			var percent1width: Number	= viewPortWidth * 0.01;
			var percent1height: Number	= viewPortHeight * 0.01;
			for (var i: int = 0; i < itemCount; ++i)
			{
				var fc: FeathersControl = items[i] as FeathersControl;
				if (!fc)
					continue;
				if(!fc.includeInLayout)
					continue;
				var layoutData: PercentLayoutData = fc.layoutData as PercentLayoutData;
				if(null == layoutData)
					continue;
				var px1: Number	= layoutData.perc_x;
				var px2: Number	= layoutData.perc_x2;
				var py1: Number	= layoutData.perc_y;
				var py2: Number	= layoutData.perc_y2;
				px1 *= percent1width;
				px2 *= percent1width;
				py1 *= percent1height;
				py2 *= percent1height;
				var nx1: Number	= layoutData.pix_x;
				var nx2: Number	= layoutData.pix_x2;
				var ny1: Number	= layoutData.pix_y;
				var ny2: Number	= layoutData.pix_y2;
				nx1 += px1;
				nx2 += px2;
				ny1 += py1;
				ny2 += py2;

				if ((nx1 !== nx1) || (ny1 !== ny1))//:no left || no top
				{
					fc.validate();//:need for size
					if ((nx1 !== nx1) && (nx2 !== nx2))//:no left & right
					{
						if (px1 === px1)//:has left percent (& right pixel) to support h-center
							nx1 = layoutData.pix_x2 + px1 - fc.width * .5;
					}
					if ((ny1 !== ny1) && (ny2 !== ny2))//:no top & bottom
					{
						if (py1 === py1)//:has top percent (& bottom pixel) to support v-center
							ny1 = layoutData.pix_y2 + py1 - fc.height * .5;
					}
				}

				if (layoutData.clamp_by_parent)
				{
					nx1	= MathUtil.clamp(nx1, 0, viewPortWidth);
					nx2	= MathUtil.clamp(nx2, 0, viewPortWidth);
					ny1	= MathUtil.clamp(ny1, 0, viewPortHeight);
					ny2	= MathUtil.clamp(ny2, 0, viewPortHeight);
				}
				nx1	+= boundsX;
				nx2	+= boundsX;
				ny1	+= boundsY;
				ny2	+= boundsY;

				if (nx1 === nx1)
				{//:has left
					fc.x = nx1;
					//:if (nx2 === nx2)//:has right
						fc.width = nx2 - nx1;
					//else
						//fc.width = NaN;
				}
				else
				{//:no left
					if (nx2 === nx2)//:has right
						fc.x = nx2 - fc.width;
				}
				if (ny1 === ny1)
				{//:has top
					fc.y = ny1;
					//:if (ny2 === ny2)//:has bottom
						fc.height = ny2 - ny1;
					//else
						//fc.height = NaN;
				}
				else
				{//:no top
					if (ny2 === ny2)//:has bottom
						fc.y = ny2 - fc.height;
				}
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