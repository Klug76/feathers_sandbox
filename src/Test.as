package
{
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ArrayCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.TiledColumnsLayout;
	import feathers.layout.VerticalAlign;
	import feathers.themes.MetalWorksMobileTheme;
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
			test1();
		}

		private function test1(): void
		{
			new MetalWorksMobileTheme();

			layout = new AnchorLayout();

			var al: TiledColumnsLayout = new TiledColumnsLayout();
			al.gap = 16;
			al.useSquareTiles = false;
			al.distributeHeights = true;
			al.tileVerticalAlign = VerticalAlign.MIDDLE;

			var list: List = new List();
			list.layoutData = new AnchorLayoutData(0, 0, 0, 0);

			var arr: Array = [];
			for (var i: int = 0; i < 50; ++i)
			{
				arr[i] =
				{
					text: "item #" + i
				}
			}
			var groceryList:ArrayCollection = new ArrayCollection(arr);
			list.dataProvider = groceryList;
			list.itemRendererFactory = function():IListItemRenderer
			{
				var itemRenderer: DefaultListItemRenderer = new DefaultListItemRenderer();
				itemRenderer.labelField = "text";
				itemRenderer.setSize(320, 200);
				itemRenderer.defaultSkin = new Quad(1, 1, 0x406040);
				return itemRenderer;
			};
			list.layout = al;
			addChild(list);
		}
	}
}