/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.ui.components {

    import com.bytesfromouterspace.stockbrokers.ui.events.UIEvent;
    import com.bytesfromouterspace.stockbrokers.ui.themes.ITheme;
    import com.bytesfromouterspace.stockbrokers.ui.themes.ThemeFactory;

    import flash.display.Sprite;
    import flash.events.Event;

    [Event(name="uiChanged", type="com.bytesfromouterspace.stockbrokers.ui.events.UIEvent")]
    public class ComponentBase extends Sprite implements IThemedComponent{

        private var _changed:Boolean = false;

        public var initHandler:Function;
        protected var _theme:ITheme;
        public var destroyHandler:Function;

        protected var _width:Number;
        protected var _height:Number;

        public function ComponentBase(_width: Number,_height: Number) {
            super();
            this._width = _width;
            this._height = _height;
            _theme = ThemeFactory.instance.theme;
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }


        protected function onAddedToStage(event:Event):void {
            if(hasEventListener(Event.ADDED_TO_STAGE)) {
                removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            }
            if(!hasEventListener(Event.REMOVED_FROM_STAGE)) {
                addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
            }
            if(initHandler != null) {
                initHandler.call();
            }
            changed = true;
            initHandler = null;
        }

        protected function onRemovedFromStage(event:Event):void {
            if(!hasEventListener(Event.REMOVED_FROM_STAGE)) {
                addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
            }
            if(destroyHandler != null) {
                destroyHandler.call();
            }
            destroyHandler = null;
        }

        public function get changed():Boolean {
            return _changed;
        }

        public function set changed(value:Boolean):void {
            if(value && !_changed) {
                dispatchEvent(new UIEvent(UIEvent.UI_CHANGED));
            }
            _changed = value;
        }

        public function set theme(value:ITheme):void {

        }

        public function get theme():ITheme {
            return _theme;
        }

        public function updateTheme():void {
        }
    }
}
