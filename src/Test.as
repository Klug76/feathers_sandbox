package
{
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import starling.events.Event;
	import feathers.controls.GroupedList;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.controls.renderers.LayoutGroupGroupedListItemRenderer;
	import feathers.data.HierarchicalCollection;
	import feathers.themes.MetalWorksDesktopTheme;

	public class Test extends LayoutGroup
	{
		private var debug_counter_: int;
		private var debug_counter2_: int;

		public function Test()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

			autoSizeMode = LayoutGroup.AUTO_SIZE_MODE_STAGE;

			new MetalWorksDesktopTheme();

			test1();
		}


		private function test1(): void
		{
			var list: GroupedList = new GroupedList();
			addChild(list);
			list.move(100, 100);
			list.setSize(400, 300);

			const head_count: int = 5;
			const item_count: int = 3;
			var head_arr: Array = [];
			for (var j:int = 0; j < head_count; ++j)
			{
				var item_arr: Array = [];
				for (var i:int = 0; i < item_count; ++i)
				{
					var child_node: Object =
					{
						label: "child #" + j + "." + i
					};
					item_arr.push(child_node);
				}
				var head_node: Object =
				{
					header: "header #" + j,
					children: item_arr
				};
				head_arr.push(head_node);
			}
			var hc: HierarchicalCollection = new HierarchicalCollection();
			hc.data = head_arr;
			list.itemRendererFactory = item_Renderer_Factory;
			list.lastItemRendererFactory = last_Renderer_Factory;
			list.dataProvider = hc;

			var k: int = head_arr.length - 1;
			var t: int = 0;
			var btn: Button;
			btn = new Button();
			btn.label = "redraw item #" + k + "." + t;
			btn.addEventListener(Event.TRIGGERED, function(e: Event): void
			{
				head_arr[k].children[t].label += ":" + debug_counter_++;
				hc.updateItemAt(k, t);
			});
			btn.move(100, 10);
			addChild(btn);

			btn = new Button();
			btn.label = "redraw header #" + k;
			btn.addEventListener(Event.TRIGGERED, function(e: Event): void
			{
				head_arr[k].header += ":" + debug_counter2_++;
				hc.updateItemAt(k);
			});
			btn.move(300, 10);
			addChild(btn);
		}

		private function item_Renderer_Factory(): IGroupedListItemRenderer
		{
			return new CustomItemRenderer();
		}

		private function last_Renderer_Factory(): IGroupedListItemRenderer
		{
			return new CustomLastItemRenderer();
		}

	}
}