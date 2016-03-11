package
{
	import feathers.controls.Label;
	import feathers.controls.renderers.LayoutGroupGroupedListItemRenderer;

	public class CustomLastItemRenderer extends LayoutGroupGroupedListItemRenderer
	{
		private var label_: Label;

		public function CustomLastItemRenderer()
		{
			super();
			setSize(120, 60);
			label_ = new Label();
			addChild(label_);
		}


		override protected function commitData():void
		{
			if (data != null)
			{
				label_.text = "LAST: " + data.label;
			}
		}

	}

}