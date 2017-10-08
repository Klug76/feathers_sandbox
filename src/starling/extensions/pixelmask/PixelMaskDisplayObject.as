package starling.extensions.pixelmask
{
	import flash.display3D.Context3DBlendFactor;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.events.Event;
	import starling.rendering.Painter;
	import starling.textures.RenderTexture;
	import starling.utils.Pool;

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
		private var _needUpdateRenderTextures:Boolean = true;
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

			Starling.current.stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated, false, 0, true);
			touchable = false;
		}

		override public function dispose():void
		{
			disposeRenderTextures();
			_mask = null;
			Starling.current.stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			super.dispose();
		}

		private function disposeRenderTextures(): void
		{
			if (_maskRenderTexture !== null)
			{
				_maskRenderTexture.dispose();
				_maskRenderTexture = null;
			}
			if (_renderTexture !== null)
			{
				_renderTexture.dispose();
				_renderTexture = null;
			}
			if (_image !== null)
 			{
				_image.dispose();
				_image = null;
			}
			if (_maskImage !== null)
			{
				_maskImage.dispose();
				_maskImage = null;
			}
		}

		private function onContextCreated(event:Object):void
		{
			_needUpdateRenderTextures = true;
		}

		public function get isAnimated():Boolean
		{
			return _isAnimated;
		}

		public function set isAnimated(value:Boolean):void
		{
			if (_isAnimated === value)
				return;
			_isAnimated = value;
			_needUpdateRenderTextures = true;
		}

		public function get inverted():Boolean { return _inverted; }
		public function set inverted(value:Boolean):void
		{
			if (_inverted === value)
				return;
			_inverted = value;
			_needUpdateRenderTextures = true;
		}

		public function get pixelMask():DisplayObject { return _mask; }
		public function set pixelMask(value:DisplayObject):void
		{
			if (_mask === value)
				return;
			_mask = value;
			_needUpdateRenderTextures = true;
		}

		private function createRenderTextures():void
		{
			if (_mask !== null)
			{
				var bounds:Rectangle = Pool.getRectangle();
				_mask.getBounds(null, bounds);
				var maskWidth:int = Math.ceil(bounds.width);
				var maskHeight:int = Math.ceil(bounds.height);
				Pool.putRectangle(bounds);

				if ((maskWidth > 0) && (maskHeight > 0))
				{
					_maskRenderTexture = new RenderTexture(maskWidth, maskHeight, false, _scaleFactor);
					_renderTexture = new RenderTexture(maskWidth, maskHeight,
						!_isAnimated,//:bugfix: (if the texture is persistent, its contents remains intact after each draw call)
						_scaleFactor);

					// create image with the result texture
					_image = new Image(_renderTexture);

					// create image to blit the mask onto
					_maskImage = new Image(_maskRenderTexture);

					if (_inverted)
						_maskImage.blendMode = MASK_MODE_INVERTED;
					else
						_maskImage.blendMode = MASK_MODE_NORMAL;
				}
			}
			_maskRendered = false;
		}

		public override function render(painter:Painter):void
		{
			if (_mask !== null)
				testMaskResize();
			if (_needUpdateRenderTextures)
			{
				_needUpdateRenderTextures = false;
				disposeRenderTextures();
				createRenderTextures();
			}
			if (null === _maskRenderTexture)
				return;
			if (_superRenderFlag)
			{
				super.render(painter);
				return;
			}
			if (_isAnimated || !_maskRendered)
			{
				_maskRendered = true;
				painter.finishMeshBatch();
				painter.excludeFromCache(this);

				drawNoTransform(_maskRenderTexture, _mask);
				_renderTexture.drawBundled(drawRenderTextures);
			}
			this.transformationMatrix.copyFrom(_mask.transformationMatrix);
			_image.render(painter);//:paint result texture
		}

		private function testMaskResize(): void
		{
			var bounds:Rectangle = Pool.getRectangle();
			_mask.getBounds(null, bounds);
			var maskWidth:int = Math.ceil(bounds.width);
			var maskHeight:int = Math.ceil(bounds.height);
			Pool.putRectangle(bounds);
			if (null === _maskRenderTexture)
			{
				if ((maskWidth > 0) && (maskHeight > 0))
					_needUpdateRenderTextures = true;
				return;
			}
			if ((_maskRenderTexture.width < maskWidth) || (_maskRenderTexture.height < maskHeight))
				_needUpdateRenderTextures = true;
		}

		private function drawRenderTextures():void
		{
			_superRenderFlag = true;
			drawNoTransform(_renderTexture, this);
			_superRenderFlag = false;

			_renderTexture.draw(_maskImage);
		}

		private function drawNoTransform(renderTexture:RenderTexture, od:DisplayObject): void
		{
			var m:Matrix = Pool.getMatrix();
			renderTexture.draw(od, m);
			Pool.putMatrix(m);
		}
	}
}