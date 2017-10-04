package
{
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.pixelmask.PixelMaskDisplayObject;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class Test extends DisplayObjectContainer
	{
		[Embed(source="../assets/bg.png")]
		private var ClassBgTexture: Class;

		[Embed(source="../assets/shimmer_button.png")]
		private var ClassButtonTexture: Class;

		// embed shimmer texture
		[Embed(source="../assets/shimmer.png")]
		private var ClassShimmer: Class;

		private var button_image_: Image;
		private var button_shimmer_image_: Image;
		private var button_shimmer_container_: PixelMaskDisplayObject;

		private var text_: TextField;

		public function Test()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
		}

		private function handleAddedToStage(event:Event) : void
		{
			// background image
			var bg: Image = new Image(Texture.fromBitmap(new ClassBgTexture()));
			bg.width = stage.stageWidth;
			bg.height = stage.stageHeight;
			bg.tileGrid = new Rectangle();
			addChild(bg);

			// container
			var container: Sprite = new Sprite();

			button_image_ = new Image(Texture.fromBitmap(new ClassButtonTexture()));
			container.addChild(button_image_);

			text_ = new TextField(button_image_.width, button_image_.height, "Foo");
			text_.format.bold = true;
			text_.format.size = 28;
			container.addChild(text_);
			text_.visible = false;//:!!??

			button_shimmer_container_ = new PixelMaskDisplayObject();
			button_shimmer_image_ = new Image(Texture.fromBitmap(new ClassShimmer()));
			button_shimmer_image_.alpha = 0.4;
			button_shimmer_container_.addChild(button_shimmer_image_);

			button_shimmer_container_.pixelMask = button_image_;

			container.addChild(button_shimmer_container_);

			container.x = (stage.stageWidth - button_image_.width) * .5;
			container.y = (stage.stageHeight - button_image_.height) * .5;
			addChild(container);

			fire_Shimmer();

			addEventListener(TouchEvent.TOUCH, on_Touch);
		}

		private function on_Touch(e: TouchEvent): void
		{
			if (e.getTouch(this, TouchPhase.ENDED) !== null)
				text_.visible = !text_.visible;
		}


		private function fire_Shimmer() : void
		{
			button_shimmer_container_.visible = false;
			Starling.juggler.delayCall(perform_Shimmer, 1);
		}

		private function perform_Shimmer() : void
		{
			button_shimmer_container_.visible = true;
			button_shimmer_image_.x = -button_shimmer_image_.width;
			button_shimmer_image_.y = 8;

			Starling.juggler.tween(button_shimmer_image_, 2.5,
				{
					"x": button_image_.width,
					"onComplete": fire_Shimmer
				}
			);
		}
	}
}