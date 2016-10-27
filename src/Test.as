package
{
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import flash.text.TextFormat;
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
			var label: Label = new Label();
			label.textRendererFactory = function(): ITextRenderer
			{
				var textRenderer: TextFieldTextRenderer = new TextFieldTextRenderer();
				textRenderer.textFormat = new TextFormat( "Arial", 24, 0xFFffFF );
				//textRenderer.embedFonts = true;
				textRenderer.isHTML = true;
				return textRenderer;
			}
			label.text = "<b>foo<b>";
			label.x = 100;
			label.y = 120;
			addChild(label);
		}
	}
}