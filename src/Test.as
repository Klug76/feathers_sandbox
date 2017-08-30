package
{
	import feathers.controls.AutoSizeMode;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import starling.events.Event;

	public class Test extends LayoutGroup
	{
		private var foo_: Label;

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
			addEventListener(Event.RESIZE, on_Resize);
			foo_ = new Label();
			foo_.text = "foo foo foo foo foo";
			foo_.move(width * 0.5, height * 0.5);
			addChild(foo_);
			foo_.alignPivot();
			foo_.rotation = 0.1;
		}

		private function on_Resize(e: Event): void
		{
			trace("******on_Resize:");
			trace("stage.size=", stage.stageWidth, "x", stage.stageHeight);
			trace("size=", width, "x", height);
			trace("******");
			foo_.move(width * 0.5, height * 0.5);
		}
	}
}