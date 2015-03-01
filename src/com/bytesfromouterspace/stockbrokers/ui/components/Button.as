/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.ui.components {
    import flash.display.Bitmap;
    import flash.events.MouseEvent;

    public class Button extends ComponentBase {

        public static const BUTTON_STATE_NORMAL:uint = 0;
        public static const BUTTON_STATE_OVER:uint = 1;
        public static const BUTTON_STATE_DISABLED:uint = 2;

        public var buttonBackgroundNormal:uint = 0x017EC1;
        public var buttonBorderNormal:uint = 0x41C6F3;

        public var buttonBackgroundOver:uint = 0x41C6F3;
        public var buttonBorderOver:uint = 0x017EC1;

        public var buttonBackgroundDisabled:uint = 0x666666;
        public var buttonBorderDisabled:uint = 0x212121;

        private var _label:Bitmap;
        protected var state:uint = BUTTON_STATE_NORMAL;
        private var _enabled:Boolean;
        
        public function Button(_width:Number, _height:Number) {
            super(_width, _height);
            drawBackground();
            enabled = true;
            addEventListener(MouseEvent.CLICK, onMouseClick);
        }

        public function setLabel(text:String, fontSize:int, fontColor:uint, fontName:String = "default", backgroundColor:uint = 0, backgroundAlpha:Number = 0):void {
            if(_label && contains(_label)) {
                removeChild(_label);
                _label.bitmapData.dispose();
                _label = null;
            }
            _label = theme.createBitmapLabel(text, fontSize, fontColor, fontName, backgroundColor, backgroundAlpha);
            _label.x = _width * 0.5 - _label.width * 0.5;
            _label.y = _height * 0.5 - _label.height * 0.5;
            addChild(_label);
        }

        public function drawBackground():void {
            graphics.clear();
            switch(state) {
                case BUTTON_STATE_NORMAL:
                    graphics.lineStyle(1, buttonBorderNormal, 1);
                    graphics.beginFill(buttonBackgroundNormal, 1);
                    break;

                case BUTTON_STATE_OVER:
                    graphics.lineStyle(1, buttonBorderOver, 1);
                    graphics.beginFill(buttonBackgroundOver, 1);
                    break;

                case BUTTON_STATE_DISABLED:
                    graphics.lineStyle(1, buttonBorderDisabled, 1);
                    graphics.beginFill(buttonBackgroundDisabled, 1);
                    break;
            }
            graphics.drawRect(0,0,_width, _height);
            graphics.endFill();
        }

        private function onMouseOut(event:MouseEvent):void {
            if (_enabled) {
                state = BUTTON_STATE_NORMAL;
                drawBackground();
            }
        }

        private function onMouseOver(event:MouseEvent):void {
            if (_enabled) {
                state = BUTTON_STATE_OVER;
                drawBackground();
            }
        }

        private function onMouseClick(event:MouseEvent):void {
            if(!_enabled) {
                event.stopImmediatePropagation();
            }
        }


        public function get enabled():Boolean {
            return _enabled;
        }

        public function set enabled(value:Boolean):void {
            _enabled = value;
            if(value) {
                if(!hasEventListener(MouseEvent.MOUSE_OVER)) {
                    addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
                }
                if(!hasEventListener(MouseEvent.MOUSE_OUT)) {
                    addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
                }
                state = BUTTON_STATE_NORMAL;
            } else {
                if(hasEventListener(MouseEvent.MOUSE_OVER)) {
                    removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
                }
                if(hasEventListener(MouseEvent.MOUSE_OUT)) {
                    removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
                }
                state = BUTTON_STATE_DISABLED;
            }
            drawBackground();
            buttonMode = value;
            useHandCursor = value;
        }



    }
}
