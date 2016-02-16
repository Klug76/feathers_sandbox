package
{
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import starling.core.Starling;
	import starling.display.Quad;
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

			test1();
		}


		private function test1(): void
		{
			var panel: LayoutGroup = new LayoutGroup();
			panel.backgroundSkin = new Quad(1, 1, 0x00ff00);
			panel.setSize(10, 200);
			addChild(panel);
			Starling.juggler.tween(panel, 3, { width: 300 } );
			Starling.juggler.delayCall(function(): void
			{
				panel.backgroundSkin = new Quad(1, 1, 0x0000ff);
			}, 3.01);
		}

	}
}