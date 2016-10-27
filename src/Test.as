package
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.themes.MetalWorksDesktopTheme;
	import flash.text.TextFormat;
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

			autoSizeMode = LayoutGroup.AUTO_SIZE_MODE_STAGE;

			test2();
			test1();
		}


		private function test1(): void
		{
			var label: Label = new Label();
			label.styleProvider = null;
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

		private function test2(): void
		{
			new MetalWorksDesktopTheme();
			var navi: ScreenNavigator = new ScreenNavigator();
			addChild(navi);
			var sc: Screen = new Screen();
			sc.backgroundSkin = new Quad(100, 100, 0xff0000);
			var it: ScreenNavigatorItem = new ScreenNavigatorItem(sc);
			navi.addScreen("menu", it);
			var button: Button = new Button();
			button.label = "Foo";
			button.move(200, 120);
			sc.addChild(button);
			navi.showScreen("menu");
		}

	}
}