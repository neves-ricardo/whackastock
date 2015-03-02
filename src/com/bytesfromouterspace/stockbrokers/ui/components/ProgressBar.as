/**
 * Created by Akira on 01/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.ui.components {
    import flash.display.Shape;
    import flash.events.Event;

    public class ProgressBar extends ComponentBase {

        private var innerBar:Shape;
        private var _targetValue:Number;
        private var _animSpeed:Number;

        public function ProgressBar(_width:Number, _height:Number = 12) {
            super(_width, _height);
            graphics.lineStyle(2, 0x888888);
            graphics.beginFill(0x212100, 1);
            graphics.drawRect(0,0,_width, _height);
            graphics.endFill();
            innerBar = new Shape();
            innerBar.graphics.beginFill(0xFF9326);
            innerBar.graphics.drawRect(0,0,_width - 4, _height - 4);
            innerBar.graphics.endFill();
            innerBar.x = 2;
            innerBar.y = 2;
            addChild(innerBar);
        }

        public function setProgress(value:Number, animate:Boolean = true):void {
            if(!animate) {
                innerBar.scaleX = value;
            } else {
                if(value != innerBar.scaleX) {
                    _targetValue = value;
                    _animSpeed = (_targetValue > innerBar.scaleX) ? -0.1 : 0.1;
                    if (!hasEventListener(Event.ENTER_FRAME)) {
                        addEventListener(Event.ENTER_FRAME, onAnimate)
                    }
                }
            }
        }

        public function getProgress():Number {
            return innerBar.scaleX;
        }

        private function onAnimate(event:Event):void {
            var completed:Boolean = false;
            if(_animSpeed > 0) {
                if(innerBar.scaleX + _animSpeed >= _targetValue) {
                    innerBar.scaleX = _targetValue;
                    completed = true;
                } else {
                    innerBar.scaleX += _animSpeed;
                }
            } else {
                if(innerBar.scaleX + _animSpeed <= _targetValue) {
                    innerBar.scaleX = _targetValue;
                    completed = true;
                } else {
                    innerBar.scaleX += _animSpeed;
                }
            }
            if(completed) {
                removeEventListener(Event.ENTER_FRAME, onAnimate);
            }
        }
    }
}
