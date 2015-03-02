/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {
    import com.bytesfromouterspace.stockbrokers.event.TurnEvent;

    [Event(name="timerStarted", type="com.bytesfromouterspace.stockbrokers.event.TurnEvent")]
    [Event(name="timerEnded", type="com.bytesfromouterspace.stockbrokers.event.TurnEvent")]
    [Event(name="timerTick", type="com.bytesfromouterspace.stockbrokers.event.TurnEvent")]
    [Event(name="timerChange", type="com.bytesfromouterspace.stockbrokers.event.TurnEvent")]
    public class TurnModel extends BaseModel{

        private var _currentTurn:int;
        private var _totalTime:Number;
        private var _currentTime:Number;

        public function TurnModel(turnDuration:int) {
            super();
            _totalTime = turnDuration;
            _currentTurn = 0;
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

        public function get currentTurn():int {
            return _currentTurn;
        }

        public function set currentTurn(value:int):void {
            _currentTurn = value;
        }

        public function startTurn():void {
            _currentTurn++;
            _currentTime = _totalTime;
            dispatchEvent(new TurnEvent(TurnEvent.TIMER_START));
        }

        public function decrease(qtd:Number):void {
            _currentTime -= qtd;
            if(_currentTime <= 0) {
                _currentTime = 0;
                dispatchEvent(new TurnEvent(TurnEvent.TIMER_ENDED));
            } else {
                dispatchEvent(new TurnEvent(TurnEvent.TIMER_TICK));
            }
        }

        public function get progress():Number {
            return _currentTime / _totalTime;
        }

        public function bonus(bonusCategory:uint):void {
            _currentTime += bonusCategory;
            if(_currentTime > _totalTime) {
                _currentTime = _totalTime;
            }
            dispatchEvent(new TurnEvent(TurnEvent.TIMER_TICK));
        }
    }
}
