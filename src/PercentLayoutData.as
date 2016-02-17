package
{
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
		private var movesize_function_: Function;

		public function PercentLayoutData(percX: Number = 0, percY: Number = 0, percX2: Number = 0, percY2: Number = 0,
			pixX: Number = 0, pixY: Number = 0, pixX2: Number = NaN, pixY2: Number = NaN,
			clampByParent: Boolean = false,
			fmovesize: Function = null)
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
			movesize_function_	= fmovesize;
		}

		public function get perc_x(): Number
		{
			return perc_x_;
		}

		public function set perc_x(value: Number): void
		{
			if (perc_x_ == value)
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
			if (perc_y_ == value)
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
			if (perc_x2_ == value)
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
			if (perc_y2_ == value)
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
			if (pix_x_ == value)
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
			if (pix_y_ == value)
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
			if (pix_x2_ == value)
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
			if (pix_y2_ == value)
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

		public function get movesize_function(): Function
		{
			return movesize_function_;
		}

		public function set movesize_function(value: Function): void
		{
			if (movesize_function_ == value)
				return;
			movesize_function_ = value;
			this.dispatchEventWith(Event.CHANGE);
		}

		public function set_Percent_Rect(x, y, x2, y2: Number): PercentLayoutData
		{
			if ((perc_x_ != x) || (perc_y_ != y) || (perc_x2_ != x2) || (perc_y2_ != y2))
			{
				perc_x_ = x;
				perc_y_ = y;
				perc_x2_ = x2;
				perc_y2_ = y2;
				this.dispatchEventWith(Event.CHANGE);
			}
			return this;
		}

		public function set_Pixel_Rect(x, y, x2, y2: Number): void
		{
			if ((pix_x_ != x) || (pix_y_ != y) || (pix_x2_ != x2) || (pix_y2_ != y2))
			{
				pix_x_ = x;
				pix_y_ = y;
				pix_x2_ = x2;
				pix_y2_ = y2;
				this.dispatchEventWith(Event.CHANGE);
			}
		}
	}

}