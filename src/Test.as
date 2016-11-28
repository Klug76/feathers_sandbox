package
{
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.themes.MetalWorksDesktopTheme;
	import flash.text.engine.ContentElement;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.GroupElement;
	import flash.text.engine.TextElement;
	import starling.core.Starling;
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
			layout = new AnchorLayout();

			var fd: FontDescription = new FontDescription("Arial");
			var ef: ElementFormat = new ElementFormat(fd, 32, 0xffffff);

			var r1: TextBlockTextRenderer = new TextBlockTextRenderer();
			r1.elementFormat = ef;
			r1.wordWrap = true;
			r1.content = create_Content(ef);
			r1.layoutData = new AnchorLayoutData(100, 100, NaN, 100);
			addChild(r1);

			var r2: TextBlockTextRenderer = new TextBlockTextRenderer();
			r2.elementFormat = ef;
			r2.wordWrap = true;
			r2.content = create_Content(ef);
			r2.layoutData = new AnchorLayoutData(250, 100, 250, 100);
			//r2.layoutData = new AnchorLayoutData(250, 100, NaN, 100);
			addChild(r2);

			var btn: Button = new Button();
			btn.label = "click me";
			btn.move(160, 20);
			addChild(btn);
			var nx: Number = 100;
			btn.addEventListener(Event.TRIGGERED, function(e: Event): void
			{
				nx = 400 - nx;
				Starling.juggler.tween(r1.layoutData, 0.6, { left: nx } );
				Starling.juggler.tween(r2.layoutData, 0.6, { left: nx } );
			});

		}

		private function create_Content(ef: ElementFormat): GroupElement
		{
			var v: Vector.<ContentElement> = new Vector.<ContentElement>();
			v.push(new TextElement("0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9", ef));
			return new GroupElement(v);
		}
	}
}