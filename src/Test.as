package
{
	import feathers.controls.LayoutGroup;
	import feathers.controls.text.TextBlockTextRenderer;
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
			var arr: Array = [];
			arr.length = 25;
			var s: String = arr.join("W") + "\n";
			var r: TextBlockTextRenderer = new TextBlockTextRenderer();
			var ef: ElementFormat = new ElementFormat(null, 64);
			r.elementFormat = ef;
			r.textAlign = TextBlockTextRenderer.TEXT_ALIGN_RIGHT;
			//r.wordWrap = true;
			//r.text = s;
			var shape: Shape = new Shape();
			shape.graphics.beginFill(0xff0000);
			shape.graphics.drawCircle(30, 30, 30);
			shape.graphics.endFill();
			var ge: GraphicElement = new GraphicElement(shape, shape.width, shape.height, ef);
			var v: Vector.<ContentElement> = new Vector.<ContentElement>();
			v.push(ge);
			var te: TextElement = new TextElement(s, ef);
			v.push(te);
			te = new TextElement(s, ef);
			v.push(te);
			r.content = new GroupElement(v);
			r.move(100, 100);
			//r.setSize(500, 300);
			addChild(r);
			trace(System.totalMemoryNumber);
		}
	}
}