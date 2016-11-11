package
{
	import com.adobe.utils.AGALMiniAssembler;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DCompareMode;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTriangleFace;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.geom.Matrix3D;
	import flash.display3D.Program3D;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;

//cube sample from https://gist.github.com/noonat/847106

	public class Scene3d
	{
		//[x, y, z, r, g, b], ccw
		static private const _cubeVertexes:Vector.<Number> = Vector.<Number>([
			// near face
			-1.0, -1.0,  1.0, 1.0, 0.0, 0.0,
			-1.0,  1.0,  1.0, 1.0, 0.0, 0.0,
			1.0,  1.0,  1.0, 1.0, 0.0, 0.0,
			1.0, -1.0,  1.0, 1.0, 0.0, 0.0,

			// left face
			-1.0, -1.0, -1.0, 0.0, 1.0, 0.0,
			-1.0,  1.0, -1.0, 0.0, 1.0, 0.0,
			-1.0,  1.0,  1.0, 0.0, 1.0, 0.0,
			-1.0, -1.0,  1.0, 0.0, 1.0, 0.0,

			// far face
			1.0, -1.0, -1.0, 0.0, 0.0, 1.0,
			1.0,  1.0, -1.0, 0.0, 0.0, 1.0,
			-1.0,  1.0, -1.0, 0.0, 0.0, 1.0,
			-1.0, -1.0, -1.0, 0.0, 0.0, 1.0,

			// right face
			1.0, -1.0,  1.0, 1.0, 1.0, 0.0,
			1.0,  1.0,  1.0, 1.0, 1.0, 0.0,
			1.0,  1.0, -1.0, 1.0, 1.0, 0.0,
			1.0, -1.0, -1.0, 1.0, 1.0, 0.0,

			// top face
			-1.0,  1.0,  1.0, 1.0, 0.0, 1.0,
			-1.0,  1.0, -1.0, 1.0, 0.0, 1.0,
			1.0,  1.0, -1.0, 1.0, 0.0, 1.0,
			1.0,  1.0,  1.0, 1.0, 0.0, 1.0,

			// bottom face
			-1.0, -1.0, -1.0, 0.0, 1.0, 1.0,
			-1.0, -1.0,  1.0, 0.0, 1.0, 1.0,
			1.0, -1.0,  1.0, 0.0, 1.0, 1.0,
			1.0, -1.0, -1.0, 0.0, 1.0, 1.0,
		]);

		static private const _cubeIndexes:Vector.<uint> = Vector.<uint>([
			0, 1, 2,
			0, 2, 3,
			4, 5, 6,
			4, 6, 7,
			8, 9, 10,
			8, 10, 11,
			12, 13, 14,
			12, 14, 15,
			16, 17, 18,
			16, 18, 19,
			20, 21, 22,
			20, 22, 23
		]);

		static private const _vertexShader:String = [
		  "m44 op, va0, vc0",
		  "mov v0, va1"
		].join("\n");

		static private const _fragmentShader:String = [
		  "mov oc, v0"
		].join("\n");

		private var _context: Context3D;


		private var _indexBuffer:IndexBuffer3D;
		private var _vertexBuffer:VertexBuffer3D;
		private var _program:Program3D;

		private var _modelView:Matrix3D;
		private var _modelViewProjection:Matrix3D;
		private var _projection:Matrix3D;

		private var _time:Number = 0;
		private var _deltaTime:Number = 0;
		private var _tweenTime:Number = 0;
		private var _tweenPitch:Number = 0;
		private var _tweenYaw:Number = 0;
		private var _pitch:Number = 0;
		private var _yaw:Number = 0;

		public function Scene3d()
		{
			_modelView = new Matrix3D();
			_modelViewProjection = new Matrix3D();
		}

		public function on_Create(axe: AxeContext): void
		{
			dispose();

			_context = axe.context3d;
			_time = getTimer() / 1000.0;
			_tweenTime = _time + 1;

			_projection = perspectiveProjection(60, axe.stage.stageWidth / axe.stage.stageHeight, 0.1, 2048);

			var vsAssembler: AGALMiniAssembler = new AGALMiniAssembler();
			vsAssembler.assemble(Context3DProgramType.VERTEX, _vertexShader);
			var fsAssembler: AGALMiniAssembler = new AGALMiniAssembler();
			fsAssembler.assemble(Context3DProgramType.FRAGMENT, _fragmentShader);
			_program = _context.createProgram();
			_program.upload(vsAssembler.agalcode, fsAssembler.agalcode);

			_vertexBuffer = _context.createVertexBuffer(_cubeVertexes.length / 6, 6);
			_vertexBuffer.uploadFromVector(_cubeVertexes, 0, _cubeVertexes.length / 6);

			_indexBuffer = _context.createIndexBuffer(_cubeIndexes.length);
			_indexBuffer.uploadFromVector(_cubeIndexes, 0, _cubeIndexes.length);
		}

		private function dispose(): void
		{
			if (_program)
			{
				_program.dispose();
				_program = null;
			}
			if (_vertexBuffer)
			{
				_vertexBuffer.dispose();
				_vertexBuffer = null;
			}
			if (_indexBuffer)
			{
				_indexBuffer.dispose();
				_indexBuffer = null;
			}
		}

		public function next_Frame(): void
		{
			var newTime:Number = getTimer() / 1000.0;
			_deltaTime = Math.min(newTime - _time, 0.1);
			_time = newTime;

			updateRotation();

			_modelView.identity();
			_modelView.appendRotation(_tweenPitch, Vector3D.X_AXIS);
			_modelView.appendRotation(_tweenYaw, Vector3D.Y_AXIS);
			_modelView.appendTranslation(0, 0, -4);

			_modelViewProjection.identity();
			_modelViewProjection.append(_modelView);
			_modelViewProjection.append(_projection);

			_context.setProgram(_program);
			_context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _modelViewProjection, true);

			_context.setCulling(Context3DTriangleFace.BACK);
			_context.setDepthTest(true, Context3DCompareMode.LESS_EQUAL);

			_context.setVertexBufferAt(0, _vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			_context.setVertexBufferAt(1, _vertexBuffer, 3, Context3DVertexBufferFormat.FLOAT_3);

			_context.drawTriangles(_indexBuffer);

			_context.setVertexBufferAt(0, null);
			_context.setVertexBufferAt(1, null);
		}

		private function perspectiveProjection(fov:Number=90, aspect:Number = 1, near:Number = 1, far:Number = 2048): Matrix3D
		{
			var y2: Number = near * Math.tan(fov * Math.PI / 360);
			var y1: Number = -y2;
			var x1: Number = y1 * aspect;
			var x2: Number = y2 * aspect;

			var a: Number = 2 * near / (x2 - x1);
			var b: Number = 2 * near / (y2 - y1);
			var c: Number = (x2 + x1) / (x2 - x1);
			var d: Number = (y2 + y1) / (y2 - y1);
			var q: Number = -(far + near) / (far - near);
			var qn: Number = -2 * (far * near) / (far - near);

			return new Matrix3D(Vector.<Number>([
				a, 0, 0, 0,
				0, b, 0, 0,
				c, d, q, -1,
				0, 0, qn, 0
				]));
		}

		private function updateRotation(): void
		{
			while (_tweenTime < _time)
			{
				++_tweenTime;
				_pitch = (_pitch + 60) % 360;
				_yaw = (_yaw + 40) % 360;
			}

			var factor:Number = _tweenTime - _time;
			if (factor < 0.0) factor = 0.0;
			else if (factor > 1.0) factor = 1.0;
			factor = 1.0 - Math.pow(factor, 4);

			_tweenPitch = _pitch + (60 * factor);
			_tweenYaw = _yaw + (40 * factor);
		}
	}

}