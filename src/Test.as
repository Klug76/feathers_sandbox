package
{
	import feathers.controls.LayoutGroup;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	public class Test extends LayoutGroup
	{
        // particle designer configurations

        [Embed(source="../media/drugs.pex", mimeType="application/octet-stream")]
        private static const DrugsConfig:Class;

        [Embed(source="../media/fire.pex", mimeType="application/octet-stream")]
        private static const FireConfig:Class;

        [Embed(source="../media/sun.pex", mimeType="application/octet-stream")]
        private static const SunConfig:Class;

        [Embed(source="../media/jellyfish.pex", mimeType="application/octet-stream")]
        private static const JellyfishConfig:Class;

        // particle textures

        [Embed(source="../media/drugs_particle.png")]
        private static const DrugsParticle:Class;

        [Embed(source="../media/fire_particle.png")]
        private static const FireParticle:Class;

        [Embed(source="../media/sun_particle.png")]
        private static const SunParticle:Class;

        [Embed(source="../media/jellyfish_particle.png")]
        private static const JellyfishParticle:Class;

        private var _particleSystem: PDParticleSystem;

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
            var drugsConfig:XML = XML(new DrugsConfig());
            var drugsTexture:Texture = Texture.fromEmbeddedAsset(DrugsParticle);

            var fireConfig:XML = XML(new FireConfig());
            var fireTexture:Texture = Texture.fromEmbeddedAsset(FireParticle);

            var sunConfig:XML = XML(new SunConfig());
            var sunTexture:Texture = Texture.fromEmbeddedAsset(SunParticle);

            var jellyConfig:XML = XML(new JellyfishConfig());
            var jellyTexture:Texture = Texture.fromEmbeddedAsset(JellyfishParticle);

			//_particleSystem = new PDParticleSystem(drugsConfig, drugsTexture);
			_particleSystem = new PDParticleSystem(fireConfig, fireTexture);
			//_particleSystem = new PDParticleSystem(sunConfig, sunTexture);
			//_particleSystem = new PDParticleSystem(jellyConfig, jellyTexture);
			_particleSystem.emitterX = 320;
			_particleSystem.emitterY = 240;

			// add it to the stage and the juggler
			addChild(_particleSystem);
			Starling.juggler.add(_particleSystem);

			// start emitting particles
			_particleSystem.start();

			stage.addEventListener(TouchEvent.TOUCH, on_Touch)
		}

		private function on_Touch(e: TouchEvent): void
		{
			var t: Touch = e.getTouch(stage);
			if ((null == t) || (t.phase == TouchPhase.HOVER))
				return;
			trace(t.globalX + ":" + t.globalY);
			_particleSystem.emitterX = t.globalX;
			_particleSystem.emitterY = t.globalY;
		}
	}
}