package
{
	import feathers.controls.text.TextFieldTextRenderer;

	public class MyTextRenderer extends TextFieldTextRenderer
	{

		public function MyTextRenderer()
		{
			super();

		}

		public function get numLines(): int
		{
			return textField.numLines;
		}

		override protected function refreshSnapshot(): void
		{
			super.refreshSnapshot();
			dispatchEventWith("numLines");
		}
	}
}
