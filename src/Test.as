package
{
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.themes.MetalWorksDesktopTheme;
	import starling.core.Starling;
	import starling.events.Event;

	public class Test extends LayoutGroup
	{
		public function Test()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

			autoSizeMode = LayoutGroup.AUTO_SIZE_MODE_STAGE;

			//test1();
			test2();
		}


		private function test1(): void
		{
			new MetalWorksDesktopTheme();
			layout = new AnchorLayout();

			var btn: Button = new Button();
			btn.label = "Click me";
			var data: AnchorLayoutData = new AnchorLayoutData(100, NaN, NaN, 120);
			var nw: Number = 6;
			var nh: Number = 3;
			data.percentWidth = nw;
			data.percentHeight = nh;
			btn.layoutData = data;

			addChild(btn);
			btn.addEventListener(Event.TRIGGERED, function(e: Event): void
			{
				nw = 100 - nw;
				nh = 100 - nh;
				Starling.juggler.tween(data, 0.6, { percentWidth: nw, percentHeight: nh } );
			});
		}

		private function test2(): void
		{
			new MetalWorksDesktopTheme();
			layout = new PercentLayout();

			var btn: Button = new Button();
			btn.label = "Click me";
			var nw: Number = 240;
			var nh: Number = 22;
			var data: PercentLayoutData = new PercentLayoutData(0, 0, 0, 0, 120, 10, nw, nh);
			btn.layoutData = data;

			addChild(btn);
			btn.addEventListener(Event.TRIGGERED, function(e: Event): void
			{
				nw = 600 - nw;
				nh = 200 - nh;
				Starling.juggler.tween(data, 0.6, { pix_x2: nw, pix_y2: nh } );
			});
		}

	}
}