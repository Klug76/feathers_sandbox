package
{
	import feathers.controls.AutoSizeMode;
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.themes.MetalWorksMobileTheme;
	import starling.filters.DropShadowFilter;
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

			autoSizeMode = AutoSizeMode.STAGE;

			test1();
		}


		private function test1(): void
		{
			new MetalWorksMobileTheme();

			var button: Button = new Button();
			button.label = "foo foo foo";
			button.move(120, 100);
			button.filter = new DropShadowFilter();
			addChild(button);

		}
	}
}