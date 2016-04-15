package
{
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.VerticalLayout;
	import feathers.themes.MetalWorksDesktopTheme;
	import flash.display.Shape;
	import flash.system.System;
	import flash.text.engine.ContentElement;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.GraphicElement;
	import flash.text.engine.GroupElement;
	import flash.text.engine.TextElement;
	import starling.events.Event;

	public class Test extends LayoutGroup
	{
		private var info_: Label;
		private var tf_: MyTextRenderer;

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
			layout = new AnchorLayout();

			info_ = new Label();
			info_.text = "numLines: 0";
			info_.layoutData = new AnchorLayoutData(10, 10, 10, 100);
			addChild(info_);

			tf_ = new MyTextRenderer();
			tf_.wordWrap = true;
			tf_.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu.";
			tf_.layoutData = new AnchorLayoutData(200, 10, 10, 10);
			addChild(tf_);
			tf_.addEventListener("numLines", on_numLines_Change);
		}

		private function on_numLines_Change(e: Event): void
		{
			info_.text = "numLines: " + tf_.numLines;
		}
	}
}