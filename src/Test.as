package
{
	import feathers.controls.LayoutGroup;
	import feathers.display.Scale9Image;
	import feathers.display.TiledImage;
	import feathers.textures.Scale9Textures;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class Test extends LayoutGroup
	{
		private var am_: AssetManager;
		private var panel_: LayoutGroup;
		private var skin9_: DisplayObject;
		private var skin_tiled_: TiledImage;

		public function Test()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

			autoSizeMode = LayoutGroup.AUTO_SIZE_MODE_STAGE;

			test1();
		}


		private function test1(): void
		{
			am_ = new AssetManager();
            var app_dir: File = File.applicationDirectory;

            am_.enqueue(app_dir.resolvePath("images/scale9-tile-pattern.png"));
			am_.loadQueue(on_Progress);


			layout = new PercentLayout();
		}

		private function on_Resize(e: Event): void
		{
			trace("size=", skin9_.width, "x", skin9_.height);
		}

		private function on_Progress(ratio:Number): void
		{
			trace("on_Progress, ratio=", ratio);
			if(ratio < 1)
				return;
			var tex: Texture = am_.getTexture("scale9-tile-pattern");
			if (tex)
				addChild(new Image(tex));

			skin9_ = new Scale9Image(new Scale9Textures(tex, new Rectangle(21, 21, 42, 42)));
			skin_tiled_ = new TiledImage(Texture.fromTexture(tex, new Rectangle(20, 20, 48, 48)));

			panel_ = new LayoutGroup();
			panel_.layoutData = new PercentLayoutData(0, 0, 100, 100, tex.width + 10, 10, 10, 10);
			panel_.backgroundSkin = skin_tiled_;
			addChild(panel_);
			panel_.addEventListener(Event.RESIZE, on_Resize);
		}


	}
}