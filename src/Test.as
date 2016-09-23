package
{
	import feathers.controls.LayoutGroup;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.themes.MetalWorksDesktopTheme;
	import flash.display.Shape;
	import flash.system.System;
	import flash.text.engine.ContentElement;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontWeight;
	import flash.text.engine.GraphicElement;
	import flash.text.engine.GroupElement;
	import flash.text.engine.TextElement;
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

			new MetalWorksDesktopTheme();

			test1();
		}


		private function test1(): void
		{
			var r: TextBlockTextRenderer = new TextBlockTextRenderer();
			var fd: FontDescription = new FontDescription("Arial", FontWeight.BOLD);
			var ef: ElementFormat = new ElementFormat(fd, 32);
			r.elementFormat = ef;

			var v: Vector.<ContentElement> = new Vector.<ContentElement>();

			var ef_blue: ElementFormat = ef.clone();
			ef_blue.color = 0x0000c0;
			var te: TextElement = new TextElement("One ", ef_blue);
			v.push(te);
			te = new TextElement("and ", ef);
			v.push(te);
			var ef_green: ElementFormat = ef.clone();
			ef_green.color = 0x00c000;
			te = new TextElement("Two", ef_green);
			v.push(te);
			r.content = new GroupElement(v);
			r.move(100, 100);
			//r.setSize(500, 300);
			addChild(r);
		}
	}
}