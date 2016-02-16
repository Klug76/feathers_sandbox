package
{
	import feathers.controls.LayoutGroup;
	import feathers.themes.MetalWorksDesktopTheme;
	import flash.filesystem.File;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class Test extends LayoutGroup
	{
		private var am_: AssetManager;

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
			am_ = new AssetManager();
            var app_dir: File = File.applicationDirectory;

            am_.enqueue(app_dir.resolvePath("images/scale9-tile-pattern.png"));
			am_.loadQueue(on_Progress);

		}

		private function on_Progress(ratio:Number): void
		{
			trace("on_Progress, ratio=", ratio);
			if(ratio < 1)
				return;
			var tex: Texture = am_.getTexture("scale9-tile-pattern");
			if (tex)
				addChild(new Image(tex));
		}


	}
}