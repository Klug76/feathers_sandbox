package
{
	import feathers.controls.AutoSizeMode;
	import feathers.controls.Button;
	import feathers.controls.ButtonState;
	import feathers.controls.LayoutGroup;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.themes.MetalWorksDesktopTheme;
	import flash.text.StyleSheet;
	import starling.events.Event;
	import starling.text.TextFormat;

	public class Test extends LayoutGroup
	{
		private var css_: StyleSheet = new StyleSheet();
		private var css_disabled_: StyleSheet = new StyleSheet();
		private var button2_: Button;

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
			new MetalWorksDesktopTheme();
			css_.parseCSS("h1 { font-size: 20; font-weight: bold; color: #0000CC }");
			css_disabled_.parseCSS("h1 { font-size: 20; color: #606060 }");

			var b: Button = add_Button();
			b.label = "<h1>foo     bar</h1>";
			b.move(100, 120);
			b.addEventListener(Event.TRIGGERED, on_Click);
			addChild(b);

			button2_ = add_Button();
			button2_.label = b.label;
			button2_.move(100, 220);
			button2_.isEnabled = false;
			addChild(button2_);
		}

		private function on_Click(e: Event): void
		{
			button2_.isEnabled = !button2_.isEnabled;
		}

		private function add_Button(): Button
		{
			var b: Button = new Button();
			b.labelFactory = function(): ITextRenderer
			{
				var r: TextFieldTextRenderer = new TextFieldTextRenderer();
				r.condenseWhite = false;
				//r.styleSheet = css_;
				return r;
			}
			b.defaultLabelProperties =
			{
				styleSheet: css_
			};
			b.disabledLabelProperties =//:DEPRECATION WARNING
			{
				styleSheet: css_disabled_
			};

			//var fmt: TextFormat = new TextFormat();
			//fmt.color = 0x404040;
			//b.setFontStylesForState(ButtonState.DISABLED, fmt);
			return b;
		}
	}
}