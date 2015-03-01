/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {
    public class TurnTimerModel extends BaseModel{

        private var _totalTime:Number;
        private var _currentTime:Number;

        public function TurnTimerModel() {
            super();
        }

        public function get totalTime():Number {
            return _totalTime;
        }

        public function set totalTime(value:Number):void {
            _totalTime = value;
        }

        public function get currentTime():Number {
            return _currentTime;
        }

        public function set currentTime(value:Number):void {
            _currentTime = value;

        }
    }
}
