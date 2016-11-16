// $Id: AxeContext.as 86 2016-02-09 17:36:52Z Klug $

package
{
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DClearMask;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.events.ErrorEvent;
	import flash.events.Event;

//:________________________________________________________________________________________________
	public class AxeContext
	{
		private var debug_out_				: Boolean = true;
		private var	is_ready_				: Boolean = false;
		private var	is_lost_				: Boolean = false;
		private var	is_bbuffer_ready_		: Boolean = false;
		private var	is_app_closed_			: Boolean = false;

		private var	stage_					: Stage;
		private var	stage3d_				: Stage3D;
		private var	context3d_				: Context3D;


		private var generation_				: int = 0;

		private var bbuffer_width_			: int = 0;
		private var bbuffer_height_			: int = 0;
		private var	aniti_alias_			: int = 0;			//: back buffer property
		private var	enable_depth_n_stencil_	: Boolean = true;	//: back buffer property

		private var on_create_: Function;
//.............................................................................
		public function AxeContext(): void
		{}
//.............................................................................
//.............................................................................
		final private function dbg_Trace(s : String) : void
		{
			if(debug_out_)
				trace(s);
		}
//.............................................................................
		public function get stage()		: Stage	{ return stage_; }
		public function get stage3d()	: Stage3D	{ return stage3d_; }
		public function get context3d()	: Context3D	{ return context3d_; }
//.............................................................................
		public function init(stage: Stage, onCreate: Function, profile: String = "baseline") : void
		{
			on_create_ = onCreate;
			stage_ = stage;
			stage3d_ = stage.stage3Ds[0];//TODO review (see minko 3d engine)
			stage3d_.addEventListener(Event.CONTEXT3D_CREATE, on_Context3d_Created);
			stage3d_.addEventListener(ErrorEvent.ERROR, on_Context3d_Error);
			//stage3d_.requestContext3D(Context3DRenderMode.AUTO, Context3DProfile.BASELINE_CONSTRAINED)
			stage3d_.requestContext3D(Context3DRenderMode.AUTO, profile /*, Context3DProfile.STANDARD_CONSTRAINED */);
			//stage3d_.requestContext3D(Context3DRenderMode.SOFTWARE);
		}
//.............................................................................
//.............................................................................
		private function on_Context3d_Created(event: Event): void
		{
			if (is_app_closed_)
				return;
			if (context3d_ != null)
			{
				is_bbuffer_ready_ = false;
				is_lost_ = true;
			}
			context3d_ = stage3d_.context3D;
			dbg_Trace("Stage3D: " + ((context3d_ != null) ? context3d_.driverInfo : ""));
			is_ready_ = true;
			validate();
			//TODO may be avoid
			//	Display Driver: Software Hw_disabled=unavailable
			//	in desktop mode!?
			if (!is_ready_)
				return;
			++generation_;
			CONFIG::debug
			{
				context3d_.enableErrorChecking = true;
			}
			if (on_create_ != null)
				on_create_();
		}
//.............................................................................
		private function on_Context3d_Error(e: ErrorEvent): void
		{
			if (is_app_closed_)
				return;
			is_ready_ = false;
			is_bbuffer_ready_ = false;
			throw new Error("ERROR.Axe3d: " + e.text);
		}
//.............................................................................
//.............................................................................
		public function update_ViewPort() : void
		{
			//:on Android, the context is not valid while we're resizing
			//:so we set up flag
			is_bbuffer_ready_ = false;
		}
//.............................................................................
		private function configure_Back_Buffer(): void
		{
			bbuffer_width_	= stage_.stageWidth;
			bbuffer_height_	= stage_.stageHeight;
			//:The minimum size of the buffer is 50x50 pixels.
			if (bbuffer_width_ < 64)
				bbuffer_width_ = 64;
			if (bbuffer_height_ < 64)
				bbuffer_height_ = 64;
			//TODO fix me: MAX buffer size
			try
			{
				dbg_Trace("configureBackBuffer(" + bbuffer_width_ + ", "+ bbuffer_height_ + ", "+ aniti_alias_ + ", "+ enable_depth_n_stencil_+ ")");
				context3d_.configureBackBuffer(bbuffer_width_, bbuffer_height_, aniti_alias_, enable_depth_n_stencil_);
				is_bbuffer_ready_ = true;
			}
			catch (err: Error)
			{
				dbg_Trace("ERROR.Axe3d: configureBackBuffer(): " + err);
				bbuffer_width_	=
				bbuffer_height_	= 0;
				is_ready_ = false;
				is_bbuffer_ready_ = false;
			}
		}
//.............................................................................
//:called by frame_begin
//:called by AxeMaterial::on_ARGB_Loaded
		public function validate() : void
		{
			if ((context3d_ != null) && (context3d_.driverInfo == "Disposed"))
			{
				dbg_Trace("AxeContext: disposed");
				context3d_ = null;
				is_ready_ = false;
				is_bbuffer_ready_ = false;
				is_lost_ = true;
			}
		}
//.............................................................................
		public function is_Ready() : Boolean
		{
			return is_ready_;
		}
//.............................................................................
		public function on_App_Close() : void
		{
			is_app_closed_ = true;
			is_ready_ = false;
			stage3d_.removeEventListener(Event.CONTEXT3D_CREATE, on_Context3d_Created);
			stage3d_.removeEventListener(ErrorEvent.ERROR, on_Context3d_Error);
		}
//.............................................................................
//.............................................................................
		public function frame_begin() : Boolean
		{
			validate();
			if (is_lost_)
			{
				dbg_Trace("Stage3d lost");
				is_lost_ = false;
				return false;
			}
			if (!is_ready_)
				return false;
			if (!is_bbuffer_ready_)
				configure_Back_Buffer();
			return is_ready_;
		}
//.............................................................................
		public function clear() : void
		{
			var clear_color: uint = stage_.color;
			context3d_.clear((clear_color & 0xFF0000) / 0xFF0000, (clear_color & 0xFF00) / 0xFF00, (clear_color & 0xFF) / 0xFF, 1, 1, 0, Context3DClearMask.ALL);
		}
//.............................................................................
		public function frame_handover() : void
		{
		}
//.............................................................................
		public function frame_end() : void
		{
			if (!is_ready_)
				return;
			context3d_.present();
		}
//.............................................................................
//.............................................................................
//.............................................................................
	}
}
