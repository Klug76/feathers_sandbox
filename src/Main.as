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
		private var scene_3d_: Scene3d;
		private var scaler_: ScreenDensityScaleFactorManager;

		public function Main()
		{
			trace("Starling ver=" + Starling.VERSION);
			trace("Feathers ver=" + FEATHERS_VERSION);

			axe_ = new AxeContext();
			axe_.init(stage, on_Context_Create);

			stage.addEventListener(Event.RESIZE, on_Resize_Stage);
			stage.addEventListener(Event.ENTER_FRAME, on_Enter_Frame_Stage);
			NativeApplication.nativeApplication.addEventListener(Event.EXITING, on_Exiting);
		}
//.............................................................................
		private function on_Context_Create(): void
		{
			init_Starling();
			init_Scene3d();
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
			if (starling_ != null)
				starling_.painter.clear(stage.color & 0xFFFFFF);
			else
				axe_.clear();

			//:scene 3d
			if (scene_3d_ != null)
				scene_3d_.next_Frame();

			axe_.frame_handover();

			//:Starling
			if (starling_ != null)
				starling_.nextFrame();

			axe_.frame_end();
		}
//.............................................................................
		private function init_Starling(): void
		{
			if (starling_ != null)
				return;
			starling_ = new Starling(Test, stage, null, axe_.stage3d);
			starling_.shareContext = true;
			starling_.supportHighResolutions = true;
			starling_.enableErrorChecking = true;
			starling_.showStats = true;
			starling_.start();

			if (SystemUtil.isDesktop)
				DeviceCapabilities.dpi = 320;
			scaler_ = new ScreenDensityScaleFactorManager(starling_);
		}
//.............................................................................
		private function init_Scene3d(): void
		{
			if (null == scene_3d_)
				scene_3d_ = new Scene3d();
			scene_3d_.on_Create(axe_);
		}
//.............................................................................
	}
}