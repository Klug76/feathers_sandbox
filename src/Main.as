package
{
	import feathers.FEATHERS_VERSION;
	import feathers.utils.ScreenDensityScaleFactorManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import starling.core.Starling;

	public class Main extends Sprite
	{
		private var starling_: Starling;
		private var scaler_: ScreenDensityScaleFactorManager;

		public function Main()
		{
			trace("Starling ver=" + Starling.VERSION);
			trace("Feathers ver=" + FEATHERS_VERSION);
			starling_ = new Starling(Test, stage, null, null, "auto",
				"baseline"
				//"baselineConstrained"
				);
			starling_.supportHighResolutions = true;
			starling_.enableErrorChecking = CONFIG::debug;
			starling_.showStats = true;
			starling_.start();

			scaler_ = new ScreenDensityScaleFactorManager(starling_);
		}
	}
}