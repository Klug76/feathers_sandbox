package
{
	import feathers.controls.AutoSizeMode;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Tree;
	import feathers.controls.renderers.DefaultTreeItemRenderer;
	import feathers.data.HierarchicalCollection;
	import feathers.layout.VerticalLayout;
	import feathers.themes.MetalWorksMobileTheme;
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
			layout = new VerticalLayout();
			//!new MetalWorksMobileTheme();

			var groups: Array =
			[
				{
					label: "Group A",
					children:
					[
						{ label: "One" },
						{ label: "Two" },
						{ label: "Three" },
					]
				},
				{
					label: "Group B",
					children:
					[
						{ label: "Four" }
					]
				},
			];

			var hc: HierarchicalCollection = new HierarchicalCollection(groups);
			var tree: Tree = new Tree();

			tree.typicalItem = { label: "Typical Item Typical Item Typical Item" };
			tree.dataProvider = hc;
			tree.itemRendererType = DefaultTreeItemRenderer;

			addChild(tree);
		}
	}
}