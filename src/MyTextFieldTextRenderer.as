package
{
	import feathers.controls.text.TextFieldTextRenderer;
	import flash.text.StyleSheet;

	public class MyTextFieldTextRenderer extends TextFieldTextRenderer
	{
		protected var _disabledStyleSheet: StyleSheet;

		public function MyTextFieldTextRenderer()
		{
			super();
		}

		public function get disabledStyleSheet(): StyleSheet
		{
			return this._disabledStyleSheet;
		}

		//:must be used together with styleSheet
		//:see 'this.textField.styleSheet = null' in super.commit();
		public function set disabledStyleSheet(value: StyleSheet): void
		{
			if (this._disabledStyleSheet == value)
			{
				return;
			}
			this._disabledStyleSheet = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		override protected function commit(): void
		{
			super.commit();
			var stylesInvalid: Boolean = this.isInvalid(INVALIDATION_FLAG_STYLES);
			var stateInvalid: Boolean = this.isInvalid(INVALIDATION_FLAG_STATE);
			if(stylesInvalid || stateInvalid)
			{
				if ((this._styleSheet !== null) && (this._disabledStyleSheet !== null))
				{
					this.textField.styleSheet = this._isEnabled ? this._styleSheet : this._disabledStyleSheet;
				}
			}
		}
	}

}