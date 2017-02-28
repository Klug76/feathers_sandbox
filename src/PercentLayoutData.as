package
{
	import feathers.core.FeathersControl;
	import feathers.layout.ILayoutData;
	import starling.events.Event;
	import starling.events.EventDispatcher;

	[Event(name="change",type="starling.events.Event")]

	public class PercentLayoutData extends EventDispatcher implements ILayoutData
	{
		//:percent base
		private var perc_x_		: Number;
		private var perc_y_		: Number;
		private var perc_x2_	: Number;
		private var perc_y2_	: Number;
		//:pixel offset
		private var pix_x_		: Number;
		private var pix_y_		: Number;
		private var pix_x2_		: Number;
		private var pix_y2_		: Number;

		private var clamp_by_parent_: Boolean;

		public function PercentLayoutData(percX: Number = 0, percY: Number = 0, percX2: Number = 0, percY2: Number = 0,
			pixX: Number = 0, pixY: Number = 0, pixX2: Number = NaN, pixY2: Number = NaN,
			clampByParent: Boolean = false)
		{
			perc_x_				= percX;
			perc_y_				= percY;
			perc_x2_			= percX2;
			perc_y2_			= percY2;
			pix_x_				= pixX;
			pix_y_				= pixY;
			pix_x2_				= pixX2;
			pix_y2_				= pixY2;
			clamp_by_parent_	= clampByParent;
		}

		public function get perc_x(): Number
		{
			return perc_x_;
		}

		public function set perc_x(value: Number): void
		{
			if (equal_Number(perc_x_, value))
				return;
			perc_x_ = value;
			this.dispatchEventWith(Event.CHANGE);
		}

		public function get perc_y(): Number
		{
			return perc_y_;
		}

		public function set perc_y(value: Number): void
		{
			if (equal_Number(perc_y_, value))
				return;
			perc_y_ = value;
			this.dispatchEventWith(Event.CHANGE);
		}

		public function get perc_x2(): Number
		{
			return perc_x2_;
		}

		public function set perc_x2(value: Number): void
		{
			if (equal_Number(perc_x2_, value))
				return;
			perc_x2_ = value;
			this.dispatchEventWith(Event.CHANGE);
		}

		public function get perc_y2(): Number
		{
			return perc_y2_;
		}

		public function set perc_y2(value: Number): void
		{
			if (equal_Number(perc_y2_, value))
				return;
			perc_y2_ = value;
			this.dispatchEventWith(Event.CHANGE);
		}

		public function get pix_x(): Number
		{
			return pix_x_;
		}

		public function set pix_x(value: Number): void
		{
			if (equal_Number(pix_x_, value))
				return;
			pix_x_ = value;
			this.dispatchEventWith(Event.CHANGE);
		}

		public function get pix_y(): Number
		{
			return pix_y_;
		}

		public function set pix_y(value: Number): void
		{
			if (equal_Number(pix_y_, value))
				return;
			pix_y_ = value;
			this.dispatchEventWith(Event.CHANGE);
		}

		public function get pix_x2(): Number
		{
			return pix_x2_;
		}

		public function set pix_x2(value: Number): void
		{
			if (equal_Number(pix_x2_, value))
				return;
			pix_x2_ = value;
			this.dispatchEventWith(Event.CHANGE);
		}

		public function get pix_y2(): Number
		{
			return pix_y2_;
		}

		public function set pix_y2(value: Number): void
		{
			if (equal_Number(pix_y2_, value))
				return;
			pix_y2_ = value;
			this.dispatchEventWith(Event.CHANGE);
		}

		public function get clamp_by_parent(): Boolean
		{
			return clamp_by_parent_;
		}

		public function set clamp_by_parent(value: Boolean): void
		{
			if (clamp_by_parent_ == value)
				return;
			clamp_by_parent_ = value;
			dispatchEventWith(Event.CHANGE);
		}

		public function set_Percent_Rect(x, y, x2, y2: Number): PercentLayoutData
		{
			if (equal_Number(perc_x_, x) && equal_Number(perc_y_, y) && equal_Number(perc_x2_, x2) && equal_Number(perc_y2_, y2))
				return this;
			perc_x_ = x;
			perc_y_ = y;
			perc_x2_ = x2;
			perc_y2_ = y2;
			this.dispatchEventWith(Event.CHANGE);
			return this;
		}

		public function set_Pixel_Rect(x, y, x2, y2: Number): void
		{
			if (equal_Number(pix_x_, x) && equal_Number(pix_y_, y) && equal_Number(pix_x2_, x2) && equal_Number(pix_y2_, y2))
				return;
			pix_x_ = x;
			pix_y_ = y;
			pix_x2_ = x2;
			pix_y2_ = y2;
			this.dispatchEventWith(Event.CHANGE);
		}

		[Inline]
		static private function equal_Number(a: Number, b: Number): Boolean
		{
			if (b !== b)//:IsNaN
				return a !== a;//:IsNaN
			return a == b;
		}

		public function visit(obj: Object): void
		{
			var percentx: Number = 0;
			var percenty: Number = 0;
			var percentx2: Number = 0;
			var percenty2: Number = 0;
			var percent_rect: Object = obj["percent_rect"];
			if (percent_rect != null)
			{
				percentx = percent_rect.x;
				percenty = percent_rect.y;
				percentx2 = percent_rect.x2;
				percenty2 = percent_rect.y2;
			}
			set_Percent_Rect(percentx, percenty, percentx2, percenty2);

			var pixelx: Number = 0;
			var pixely: Number = 0;
			var pixelx2: Number = NaN;//:auto size
			var pixely2: Number = NaN;
			var pixel_rect: Object = obj["pixel_rect"];
			if (pixel_rect != null)
			{
				pixelx = pixel_rect.x;
				pixely = pixel_rect.y;
				pixelx2 = pixel_rect.x2;
				pixely2 = pixel_rect.y2;
			}
			set_Pixel_Rect(pixelx, pixely, pixelx2, pixely2);

			clamp_by_parent = obj["clamp_by_parent"];
		}

	}

}