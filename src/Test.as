package
{
	import feathers.controls.LayoutGroup;
	import feathers.core.FeathersControl;
	import feathers.skins.ImageSkin;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class Test extends LayoutGroup
	{
		private var am_: AssetManager;
		private var panel_: LayoutGroup;

		static private const tile_size: int = 48;
		static private const corner_size: int = 20;

		public function Test()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		protected function addedToStageHandler(event: Event): void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

			autoSizeMode = LayoutGroup.AUTO_SIZE_MODE_STAGE;

			test1();
		}


		private function test1(): void
		{
			am_ = new AssetManager();
            var app_dir: File = File.applicationDirectory;

            am_.enqueue(app_dir.resolvePath("images/scale9-pattern.png"));
            am_.enqueue(app_dir.resolvePath("images/tile-pattern.png"));
			am_.loadQueue(on_Progress);
		}

		private function set_Panel_Size(fc: FeathersControl, nx: Number, ny: Number, w: Number, h: Number): void
		{
			fc.move(nx, ny);
			var t: Number = corner_size * 2;
			w -= t;
			w = Math.floor(w / tile_size) * tile_size;
			w += t;
			h -= t;
			h = Math.floor(h / tile_size) * tile_size;
			h += t;
			fc.setSize(Math.max(w, t), Math.max(h, t));
			fc.invalidate();
		}

		private function on_Progress(ratio: Number): void
		{
			trace("on_Progress, ratio=", ratio);
			if(ratio < 1)
				return;
			var tex_scale: Texture = am_.getTexture("scale9-pattern");
			var tex_tile: Texture = am_.getTexture("tile-pattern");

			layout = new PercentLayout();

			panel_ = new LayoutGroup();
			panel_.layout = new PercentLayout();
			panel_.layoutData = new PercentLayoutData(0, 0, 100, 100, 64, 64, -8, -8, false, set_Panel_Size);

			panel_.clipContent = true;

			//var layer0: LayoutGroup = new LayoutGroup();
			//layer0.layoutData = new PercentLayoutData(0, 0, 100, 100, 0, 0, 0, 0);
			//layer0.backgroundSkin = new Quad(1, 1, 0xff00ff);
			//panel_.addChild(layer0);

			var skin: ImageSkin;

			var layer1: LayoutGroup = new LayoutGroup();
			layer1.layoutData = new PercentLayoutData(0, 0, 100, 100, 0, 0, 0, 0);
			skin = new ImageSkin(tex_scale);
			skin.scale9Grid = new Rectangle(corner_size, corner_size, tile_size, tile_size);
			layer1.backgroundSkin = skin;
			panel_.addChild(layer1);

			var layer2: LayoutGroup = new LayoutGroup();
			layer2.layoutData = new PercentLayoutData(0, 0, 100, 100, -tile_size + corner_size, corner_size, 0, -corner_size);
			skin = new ImageSkin(tex_tile);
			skin.tileGrid = new Rectangle(0, 0, tile_size, tile_size);
			layer2.backgroundSkin = skin;
			panel_.addChild(layer2);

			var layer3: LayoutGroup = new LayoutGroup();
			layer3.layoutData = new PercentLayoutData(0, 0, 100, 0, corner_size, -tile_size + corner_size, -corner_size, corner_size);
			skin = new ImageSkin(tex_tile);
			skin.tileGrid = new Rectangle(0, 0, tile_size, tile_size);
			layer3.backgroundSkin = skin;
			panel_.addChild(layer3);

			var layer4: LayoutGroup = new LayoutGroup();
			layer4.layoutData = new PercentLayoutData(0, 100, 100, 100, corner_size, -corner_size, -corner_size, 0);
			skin = new ImageSkin(tex_tile);
			skin.tileGrid = new Rectangle(0, 0, tile_size, tile_size);
			layer4.backgroundSkin = skin;
			panel_.addChild(layer4);


			addChild(panel_);
		}
	}
}