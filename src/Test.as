package
{
	import feathers.controls.AutoSizeMode;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.TextCallout;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalLayout;
	import feathers.layout.RelativePosition;
	import feathers.skins.ImageSkin;
	import feathers.themes.MetalWorksDesktopTheme;
	import flash.text.StyleSheet;
	import flash.ui.Keyboard;
	import starling.events.Event;
	import starling.text.TextFormat;
	import starling.utils.Align;

	public class Test extends LayoutGroup
	{
		public function Test()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		protected function addedToStageHandler(event: Event): void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

			autoSizeMode = AutoSizeMode.STAGE;

			test1();
		}


		private function test1(): void
		{
			new MetalWorksDesktopTheme();

			var button: Button = new Button();
			button.label = "Click Me";
			button.addEventListener( Event.TRIGGERED, button_triggeredHandler );
			button.move(stage.stageWidth - 100, 20);
			addChild(button);

			var label: Label = create_Label();
			label.move(10, 100);
			addChild(label);
			var skin: ImageSkin = new ImageSkin();
			skin.defaultColor = 0xcc8860;
			label.backgroundSkin = skin;

			//var group: LayoutGroup = new LayoutGroup();
			//group.alpha = 0.5;
			//group.layout = new VerticalLayout();
			//group.move(300, 150);
			//var skin: ImageSkin = new ImageSkin();
			//skin.defaultColor = 0xcc8860;
			//group.backgroundSkin = skin;
			//addChild(group);
//
			//group.addChild(create_Label());
		}

		//private const text_: String = "1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua." +
			//"\n2\n3\n4\n5\n6\n7\n8\n9\nend";
		//private const text_: String = "<h3>Lorem ipsum dolor<br>sit amet, consectetur adipiscing elit,<br>1<br>2<br>3<br>4<br>5<br>6<br>7<br>__</h3>";
		private const text_: String = "<h3>Lorem ipsum dolor sit amet,<br>consectetur adipiscing elit,<br>sed do eiusmod tempor incididunt ut labore<br>et dolore magna aliqua.<br>Ut enim ad minim veniam,<br>quis nostrud exercitation ullamco laboris<br>nisi ut aliquip ex ea commodo consequat.<br>Duis aute irure dolor in reprehenderit in voluptate<br>velit esse cillum dolore eu fugiat nulla pariatur.<br>Excepteur sint occaecat cupidatat non proident,<br>sunt in culpa qui officia deserunt mollit anim id est laborum.</h3>";
		//private const text_: String = "<h3>Lorem ipsum dolor sit amet,<br>consectetur adipiscing elit,<br>sed do eiusmod tempor incididunt ut labore<br>et dolore magna aliqua.<br>Ut enim ad minim veniam,<br>quis nostrud exercitation ullamco laboris<br>nisi ut aliquip ex ea commodo consequat.<br>Duis aute irure dolor in reprehenderit in voluptate<br>velit esse cillum dolore eu fugiat nulla pariatur.<br>Excepteur sint occaecat cupidatat non proident,<br>sunt in culpa qui officia deserunt mollit anim id est laborum.<br></h3>";
		//private const text_: String = "<h3>Рыба-ножик-режик<br>День защитника аквариума уже наступил.<br><br>path=23knife<br>diamonds=10<br>sell=4400<br>buy_xp=800<br>sell_xp=800<br>need_level=23<br>__</h3>";

		private const tf_: TextFormat = new TextFormat("Arial", 18, 0xffffff, Align.LEFT, Align.TOP);

		private function create_Label(): Label
		{
			var css: StyleSheet = new StyleSheet();
			css.parseCSS('h3{font-family:"Arial";font-size:18;color:#FFffFF}');
			var result: Label = new Label();
			result.textRendererFactory = function(): ITextRenderer
			{
				var r: TextFieldTextRenderer = new TextFieldTextRenderer();
				r.styleSheet = css;
				return r;
			}
			result.wordWrap = true;
			//result.fontStyles = tf_;
			result.text = text_;
			return result;
		}

		private function create_Content(): FeathersControl
		{
			var result: LayoutGroup = new LayoutGroup();
			var al: VerticalLayout = new VerticalLayout();
			al.horizontalAlign = HorizontalAlign.JUSTIFY;
			result.layout = al;
			var label: Label = create_Label();
			result.addChild(label);
			return result;
		}

		private function button_triggeredHandler( event: Event ): void
		{

			var button: Button = Button( event.currentTarget );
			//var callout: Callout = Callout.show( create_Content(), button, new <String>[RelativePosition.RIGHT, RelativePosition.LEFT]);
			var callout: Callout = Callout.show( create_Label(), button);// , new <String>[RelativePosition.RIGHT, RelativePosition.LEFT]);
			//callout.maxWidth = 500;
			//callout.maxHeight = 2400;
			/*
			TextCallout.calloutFactory = function(): TextCallout
			{
				var callout:TextCallout = new TextCallout();
				//set properties here!
				callout.textRendererFactory = function(): ITextRenderer
				{
					var tr: TextFieldTextRenderer = new TextFieldTextRenderer();
					//tr.styleSheet
					tr.isHTML = true;
					return tr;
				}
				callout.fontStyles = tf_;
				callout.wordWrap = true;
				callout.closeOnTouchBeganOutside = true;
				callout.closeOnTouchEndedOutside = true;
				callout.closeOnKeys = new <uint>[Keyboard.BACK, Keyboard.ESCAPE];
				callout.maxWidth = 600;
				//callout.maxWidth = 800;
				return callout;
			};
			var callout: TextCallout = TextCallout.show(text_, button, new <String>[RelativePosition.RIGHT, RelativePosition.LEFT]);
			/**/
		}
	}
}