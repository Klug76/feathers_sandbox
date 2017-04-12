package
{
	import feathers.controls.AutoSizeMode;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import flash.text.StyleSheet;
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
			//new Metalw
			
			var button: Button = new Button();
			button.label = "Click Me";
			button.addEventListener( Event.TRIGGERED, button_triggeredHandler );
			button.move(100, 100);
			addChild(button);
		}

		private function button_triggeredHandler( event: Event ): void
		{
			var css: StyleSheet = new StyleSheet();
			css.parseCSS("h1 {font-family: Arial; font-size: 32; font-weight: bold; } ");
			var foo: Label = new Label();
			foo.textRendererFactory = function(): ITextRenderer
			{
				var r: TextFieldTextRenderer = new TextFieldTextRenderer();
				r.styleSheet = css;
				return r;
			}
			//foo.move(100, 100);
			//foo.width = 600;
			foo.wordWrap = true;
			foo.text = "<h1>1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua." +
				"<br>2 ipsum<br><br>3<br>4<br>5<br>6</h1>";
			//addChild(foo);

			var button: Button = Button( event.currentTarget );
			var callout: Callout = Callout.show( foo, button );
		}
	}
}