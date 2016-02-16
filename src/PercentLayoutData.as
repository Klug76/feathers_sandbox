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

		public function PercentLayoutData(percx: Number = 0, percy: Number = 0, percx2: Number = 0, percy2: Number = 0,
			pixx: Number = 0, pixy: Number = 0, pixx2: Number = NaN, pixy2: Number = NaN)
		{
			perc_x_		= percx;
			perc_y_		= percy;
			perc_x2_	= percx2;
			perc_y2_	= percy2;
			pix_x_		= pixx;
			pix_y_		= pixy;
			pix_x2_		= pixx2;
			pix_y2_		= pixy2;
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