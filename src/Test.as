package
{
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.ScrollBar;
	import feathers.controls.ScrollPolicy;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ArrayCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.TiledColumnsLayout;
	import feathers.layout.VerticalAlign;
	import feathers.themes.MinimalDesktopTheme;
	import starling.display.Quad;
	import starling.events.Event;

	public class Test extends LayoutGroup
	{
		public function Test()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		protected function addedToStageHandler(event: Event): void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			test1();
		}

		private function test1(): void
		{
			new MinimalDesktopTheme();
			//ScrollBar

			layout = new AnchorLayout();

			var list: List = new List();
			list.layoutData = new AnchorLayoutData(0, 0, 0, 0);

			var arr: Array = [];
			for (var i: int = 0; i < 3; ++i)
			{
				arr[i] =
				{
					text: "item #" + i
				}
			}
			list.dataProvider = new ArrayCollection(arr);
			list.itemRendererFactory = function(): IListItemRenderer
			{
				var itemRenderer: DefaultListItemRenderer = new DefaultListItemRenderer();
				itemRenderer.labelField = "text";
				itemRenderer.setSize(320, 200);
				itemRenderer.defaultSkin = new Quad(1, 1, 0x406040);
				return itemRenderer;
			};
			list.verticalScrollPolicy = ScrollPolicy.ON;
			addChild(list);
		}
	}
}