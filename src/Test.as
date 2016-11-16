package
{
	import feathers.controls.AutoSizeMode;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.themes.MinimalMobileTheme;
	import feathers.themes.StyleNameFunctionTheme;
	import flash.text.TextFormat;
	import starling.display.Quad;
	import starling.events.Event;

	public class Test extends LayoutGroup
	{
		private var theme_: StyleNameFunctionTheme;
		private var label1: Label;
		private var label2: Label;

		public function Test()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

			autoSizeMode = LayoutGroup.AUTO_SIZE_MODE_STAGE;

			test2();
			//test1();
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
			theme_ = new MinimalMobileTheme();

			var view: LayoutGroup = new LayoutGroup();
			//view.autoSizeMode = AutoSizeMode.STAGE;
			//view.backgroundSkin = new Quad(100, 100, 0xff0000);

			var button: Button = new Button();
			button.label = "Foo";
			button.move(200, 40);
			button.addEventListener(Event.TRIGGERED, on_Button_Click)
			view.addChild(button);

			label1 = new Label();
			//label.styleProvider = null;
			label1.textRendererFactory = function(): ITextRenderer
			{
				var textRenderer: TextFieldTextRenderer = new TextFieldTextRenderer();
				textRenderer.textFormat = new TextFormat( "Arial", 24, 0xFFffFF );
				//textRenderer.embedFonts = true;
				textRenderer.isHTML = true;
				return textRenderer;
			}
			label1.text = "<b>foo<b>";
			label1.move(120, 100);
			view.addChild(label1);
			addChild(view);

			label2 = new Label();
			label2.text = "foo";
			label2.move(120, 150);
			view.addChild(label2);
		}

		private function on_Button_Click(e: Event): void
		{
			label1.text += " z";
			label2.text += " z";
		}

	}
}