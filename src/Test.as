package
{
	import feathers.controls.AutoSizeMode;
	import feathers.controls.LayoutGroup;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.styles.DistanceFieldStyle;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class Test extends LayoutGroup
	{
		private var assets_: AssetManager;
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
			assets_ = new AssetManager();
			var appDir: File = File.applicationDirectory;
			assets_.enqueue(appDir.resolvePath("assets"));
			assets_.loadQueue(function (ratio: Number):void
			{
				if (1. == ratio)
				{
					//init_Df();
					init_Df_Font();
				}
			});
		}

		private function init_Df(): void
		{
			var texture: Texture = assets_.getTexture("cat-df");
			var image: Image;

			image = new Image(texture);
			image.x = 10;
			image.y = 120;
			addChild(image);

			image = new Image(texture);
			var style: DistanceFieldStyle = new DistanceFieldStyle();
			style.setupDropShadow();
			image.style = style;
			image.color = 0xffFFff;
			image.x = 210;
			image.y = 120;
			addChild(image);


			image = new Image(texture);
			style = new DistanceFieldStyle();
			style.setupDropShadow();
			image.style = style;
			image.color = 0xffFFff;
			image.x = 410;
			image.y = 120;
			image.scale = 3;
			addChild(image);
		}

		private function init_Df_Font(): void
		{
			//var texture: Texture = assets_.getTexture("ascii");
			//var texture: Texture = assets_.getTexture("myfont3");

			//trace("texture.w=" + texture.width);
			//var image: Image;
			//image = new Image(texture);
			//image.x = 400;
			//image.y = 300;
			//image.scale = 0.25;
			//addChild(image);

			//var xml: XML = text2XML("ascii");
			//var xml: XML = assets_.getXml("myfont3");
			//var font: BitmapFont = new BitmapFont(texture, xml)

			//TextField.registerCompositor(font, font.name);

			var textField: TextField = new TextField(300, 150, "1100101");
			textField.x = 20;
			textField.y = 100;
			//trace("font.name=" + font.name);
			//textField.format.setTo(BitmapFont.MINI, BitmapFont.NATIVE_SIZE);
			//textField.format.setTo("nyfont3", 50, 0xffff00);
			textField.format.setTo("myfont3", BitmapFont.NATIVE_SIZE, 0xffff00);
			//var style: DistanceFieldStyle = new DistanceFieldStyle();
			//textField.style = style;
			addChild(textField);
		}

		private function text2XML(string: String): XML
		{
			var xml: XML =
			<font>
				<info />
				<common />
				<chars>
				</chars>
			</font>;
			var ba: ByteArray = assets_.getByteArray(string);
			var s: String = ba.readUTFBytes(ba.length);
			//trace(s);
			parse(s, xml);
			trace(xml.toXMLString());
			return xml;
		}

		private function parse(text: String, xml: XML): void
		{
			var arr: Array;
			if (text.indexOf("\r\n") >= 0)
				arr = text.split("\r\n");
			else if (text.indexOf("\r") >= 0)
				arr = text.split("\r");
			else
				arr = text.split("\n");
			var p: TinyParser = new TinyParser();
			var len: int = arr.length;
			var s: String;
			for (var i: int = 0; i < len; ++i)
			{
				s = arr[i];
				if (s.length <= 0)
					continue;
				//trace(s);
				p.init(s);
				if (p.cmp("info"))
				{
					parse_Line(p, xml.info[0]);
					continue;
				}
				if (p.cmp("common"))
				{
					parse_Line(p, xml.common[0]);
					continue;
				}
				if (p.cmp("chars"))
				{
					parse_Line(p, xml.chars[0]);
					continue;
				}
				if (p.cmp("page"))
				{
					continue;
				}
				if (p.cmp("char"))
				{
					var child: XML = <char/>;
					XML(xml.chars[0]).appendChild(child);
					parse_Line(p, child);
					continue;
				}
				trace("WARNING: unknown line: '" + s + "'");
			}
		}

		private function parse_Line(p: TinyParser, xml: XML): void
		{
			var key: String;
			var value: String;
			for (;; )
			{
				p.skip_Space();
				if (p.done)
					break;
				key = p.read_Until("=", false);
				value = p.read_Until(" ", true);
				if ("charset" == key)
					trace(value);
				if (value.length > 1)
				{
					if ((value.indexOf('"') == 0) && (value.lastIndexOf('"') == value.length - 1))
						value = value.substr(1, value.length - 2);
				}
				xml.@[key] = value;
			}
		}

	}
}