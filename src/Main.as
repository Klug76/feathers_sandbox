package
{
	import feathers.FEATHERS_VERSION;
	import feathers.system.DeviceCapabilities;
	import feathers.utils.ScreenDensityScaleFactorManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import starling.core.Starling;
	import starling.utils.SystemUtil;
	import flash.desktop.NativeApplication;

	public class Main extends Sprite
	{
		private var axe_: AxeContext;
		private var starling_: Starling;
		private var scaler_: ScreenDensityScaleFactorManager;

		public function Main()
		{
			trace("Starling ver=" + Starling.VERSION);
			trace("Feathers ver=" + FEATHERS_VERSION);

			axe_ = new AxeContext();
			axe_.init(stage);

			stage.addEventListener(Event.RESIZE, on_Resize_Stage);
			stage.addEventListener(Event.ENTER_FRAME, on_Enter_Frame_Stage);
			NativeApplication.nativeApplication.addEventListener(Event.EXITING, on_Exiting);
		}
//.............................................................................
		private function on_Exiting(e: Event) : void
		{
			stage.removeEventListener(Event.ENTER_FRAME, on_Enter_Frame_Stage);
			axe_.on_App_Close();
			axe_ = null;
		}
//.............................................................................
		private function on_Resize_Stage(e: Event) : void
		{
			if (axe_ != null)
				axe_.update_ViewPort();
		}
//.............................................................................
//.............................................................................
//.............................................................................
		private function on_Enter_Frame_Stage(e: Event): void
		{
			if (!axe_.frame_begin())
				return;
			//:scene 3d
			//if (scene_3d_ != null)
				//scene_3d_.next_Frame();

			axe_.frame_handover();

			//:Starling
			if (starling_ != null)
				starling_.nextFrame();
			else
				init_Starling();

			axe_.frame_end();
		}
//.............................................................................
		private function init_Starling(): void
		{
			starling_ = new Starling(Test, stage, null, axe_.stage3d);
			starling_.shareContext = true;
			starling_.supportHighResolutions = true;
			starling_.enableErrorChecking = true;
			starling_.showStats = true;
			starling_.start();

			if (SystemUtil.isDesktop)
				DeviceCapabilities.dpi = 160;
			scaler_ = new ScreenDensityScaleFactorManager(starling_);

		}
//.............................................................................
//.............................................................................
	}
}