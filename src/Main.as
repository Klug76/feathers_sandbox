package
{
	import feathers.FEATHERS_VERSION;
	import feathers.system.DeviceCapabilities;
	import feathers.utils.ScreenDensityScaleFactorManager;
	import flash.display.Sprite;
	import starling.core.Starling;
	import starling.utils.SystemUtil;

	public class Main extends Sprite
	{
		private var starling_: Starling;
		private var scaler_: ScreenDensityScaleFactorManager;

		public function Main()
		{
			trace("Starling ver=" + Starling.VERSION);
			trace("Feathers ver=" + FEATHERS_VERSION);
			starling_ = new Starling(Test, stage);
			starling_.supportHighResolutions = true;
			starling_.enableErrorChecking = CONFIG::debug;
			starling_.showStats = true;
			starling_.start();

			if (SystemUtil.isDesktop)
				DeviceCapabilities.dpi = 216;
			scaler_ = new ScreenDensityScaleFactorManager(starling_);
		}
	}
}