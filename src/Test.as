package
{
	import feathers.controls.LayoutGroup;
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
		}

		private function on_Progress(ratio:Number): void
		{
		}


	}
}