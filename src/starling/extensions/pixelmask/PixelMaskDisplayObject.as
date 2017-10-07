package starling.extensions.pixelmask
{
	import flash.display3D.Context3DBlendFactor;
	import flash.geom.Matrix;
	import starling.utils.Pool;

	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.events.Event;
	import starling.rendering.Painter;
	import starling.textures.RenderTexture;

	public class PixelMaskDisplayObject extends DisplayObjectContainer
	{
		private static const MASK_MODE_NORMAL:String = "pixelMask";
		private static const MASK_MODE_INVERTED:String = "pixelMask::inverted";

		private var _mask:DisplayObject;
		private var _renderTexture:RenderTexture;
		private var _maskRenderTexture:RenderTexture;

		private var _image:Image;
		private var _maskImage:Image;

		private var _superRenderFlag:Boolean = false;
		private var _inverted:Boolean = false;
		private var _scaleFactor:Number;
		private var _isAnimated:Boolean = true;
		private var _maskRendered:Boolean = false;
		private static var _blendModeInit:Boolean = false;

		public function PixelMaskDisplayObject(scaleFactor:Number=-1, isAnimated:Boolean=true)
		{
			super();

			_isAnimated = isAnimated;
			_scaleFactor = scaleFactor;

			if (!_blendModeInit)
			{
				_blendModeInit = true;
				BlendMode.register(MASK_MODE_NORMAL, Context3DBlendFactor.ZERO, Context3DBlendFactor.SOURCE_ALPHA);
				BlendMode.register(MASK_MODE_INVERTED, Context3DBlendFactor.ZERO, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
			}
		}

		public function get isAnimated():Boolean
		{
			return _isAnimated;
		}

		public function set isAnimated(value:Boolean):void
		{
			_isAnimated = value;
		}

		override public function dispose():void
		{
			clearRenderTextures();
			super.dispose();
		}

		public function get inverted():Boolean { return _inverted; }
		public function set inverted(value:Boolean):void
		{
			_inverted = value;
			refreshRenderTextures(null);
		}

		public function get pixelMask():DisplayObject { return _mask; }
		public function set pixelMask(value:DisplayObject):void
		{
			_mask = value;

			if (value)
			{
				if (_mask.width == 0 || _mask.height == 0)
					throw new Error ("Mask must have dimensions. Current dimensions are " +
						_mask.width + "x" + _mask.height + ".");

				refreshRenderTextures(null);
			}
			else
			{
				clearRenderTextures();
			}
		}

		private function clearRenderTextures() : void
		{
			if (_maskRenderTexture)	_maskRenderTexture.dispose();
			if (_renderTexture) 	_renderTexture.dispose();
			if (_image) 			_image.dispose();
			if (_maskImage) 		_maskImage.dispose();
		}

		private function refreshRenderTextures(e:Event=null):void
		{
			if (_mask)
			{
				clearRenderTextures();

				_maskRenderTexture = new RenderTexture(_mask.width, _mask.height, false, _scaleFactor);
				_renderTexture = new RenderTexture(_mask.width, _mask.height, false, _scaleFactor);

				// create image with the new render texture
				_image = new Image(_renderTexture);

				// create image to blit the mask onto
				_maskImage = new Image(_maskRenderTexture);

				// set the blending mode to MASK (ZERO, SRC_ALPHA)
				if (_inverted)
					_maskImage.blendMode = MASK_MODE_INVERTED;
				else
					_maskImage.blendMode = MASK_MODE_NORMAL;
			}

			_maskRendered = false;
		}

		public override function render(painter:Painter):void
		{
			if (_isAnimated || (!_isAnimated && !_maskRendered))
			{
				if (_superRenderFlag || !_mask)
				{
					super.render(painter);
				}
				else
				{
					if (_mask)
					{
						painter.finishMeshBatch();
						painter.excludeFromCache(this);

						drawNoTransform(_maskRenderTexture, _mask);
						_renderTexture.drawBundled(drawRenderTextures);
						_image.render(painter);
						_maskRendered = true;
					}
				}
			}
			else if (_image)
			{
				_image.render(painter);
			}
		}

		private function drawRenderTextures():void
		{
			_superRenderFlag = true;
			drawNoTransform(_renderTexture, this);
			_renderTexture.draw(this);
			_superRenderFlag = false;

			_renderTexture.draw(_maskImage);
		}

		private function drawNoTransform(renderTexture: RenderTexture, od: DisplayObject): void
		{
			var m: Matrix = Pool.getMatrix();
			renderTexture.draw(od, m);
			Pool.putMatrix(m);
		}
	}
}