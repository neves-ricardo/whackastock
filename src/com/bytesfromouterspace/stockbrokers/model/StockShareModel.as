/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {

    import com.bytesfromouterspace.stockbrokers.event.StockShareEvent;
    import com.bytesfromouterspace.stockbrokers.event.TransactionEvent;

    import flash.events.Event;

    [Event(name="stockShareChanged", type="com.bytesfromouterspace.stockbrokers.event.StockShareEvent")]
    public class StockShareModel extends BaseModel implements IHistoryModel {

        private var _history:Vector.<Number>;
        public var stockId:int = 0;
        public var startingValue:Number;
        private var _currentValue:Number;
        public var samples:int;
        private var lastSample:Number = 0;
        private var _name:String;
        private var _quantityAvailable:int = 0;
        private var _quantityOwned:int = 0;
        private var _ownedValue:Number = 0;
        private var _delta:Number = 0;
        public var marketModifier:Number = 0;
        private var _totalQuantity:Number = 0;
        private var _focus:Boolean = false;
        private var _locked:Boolean = false;

        public function StockShareModel(stockId:int, name:String, rand:Number) {
            super();
            this.stockId = stockId;
            this._name = name;
            _totalQuantity = 1000;
            _quantityAvailable = _totalQuantity;
            startingValue = int(rand * 100);
            samples = 0;
            _currentValue = startingValue;
            lastSample = _currentValue;
            _history = new Vector.<Number>();
            _history.push(startingValue);
        }

        public var auxDelta:Number;
        private var signal:Number;

        public function update(newValue:Number):void {
            /*if(lastSample == 0) {
                lastSample = newValue;
                auxDelta = 0;
            }
            if(Math.abs(newValue/lastSample) > 2) {
                newValue /= lastSample;
            }
            lastSample = newValue;*/
            //newValue = Math.abs(newValue);
            /*auxDelta = newValue * startingValue;
            if(Math.abs(auxDelta) < (startingValue*0.5)) {
                currentValue += auxDelta;
            } else {
                signal = newValue > 0 ? 1 : -1;
                currentValue += (Math.random()*startingValue*signal);
            }*/
            auxDelta = newValue * startingValue;
            _currentValue += auxDelta - _currentValue;
            if(_currentValue < 0.1 * startingValue) {
                _currentValue = 0.1 * startingValue;
            }
            samples += 20;
        }

        public function refresh():void {
            dispatchEvent(new StockShareEvent(StockShareEvent.STOCK_SHARE_CHANGED));
        }

        public function get quantityAvailable():int {
            return _quantityAvailable;
        }

        public function set quantityAvailable(value:int):void {
            _quantityAvailable = value;
            refresh();
        }

        public function get quantityOwned():int {
            return _quantityOwned;
        }

        public function set quantityOwned(value:int):void {
            _quantityOwned = value;
            refresh();
        }

        public function get ownedValue():Number {
            return _ownedValue;
        }

        public function set ownedValue(value:Number):void {
            _ownedValue = value;
            refresh();
        }

        public function requestSell(quantity:int):void {
            dispatchEvent(new TransactionEvent(stockId, TransactionEvent.TRANSACTION_TYPE_SELL, quantity));
        }

        public function requestBuy(quantity:int):void {
            dispatchEvent(new TransactionEvent(stockId, TransactionEvent.TRANSACTION_TYPE_BUY, quantity));
        }

        public function doBuy(amount:int):void {
            _quantityAvailable -= amount;
            if(_quantityOwned > 0) {
                _ownedValue = (_quantityOwned * _ownedValue + amount * _currentValue) / (_quantityOwned + amount);
            } else {
                _ownedValue = _currentValue;
            }
            _quantityOwned += amount;
            //marketModifier += amount /
            refresh();
        }

        public function doSell(amount:int):void {
            _quantityAvailable += amount;
            _quantityOwned -= amount;
            refresh();
        }

        public function setMarketInfluence(value:Number):void {
            var newValue:Number = _currentValue * value;
            var lastValue:Number = _history[_history.length - 1];
            _delta = (newValue - lastValue) / lastValue;
            currentValue = newValue;
        }

        public function get currentValue():Number {
            return _currentValue;
        }

        public function set currentValue(value:Number):void {
            _currentValue = value;
            _locked = (_currentValue < (0.1 * startingValue));
            refresh();
            addToHistory(value);
        }

        public function get locked():Boolean {
            return _locked;
        }

        public function get delta():Number {
            return _delta;
        }

        public function get history():Vector.<Number> {
            return _history;
        }

        public function dispatchHistoryChange():void {
            if(_focus) {
                dispatchEvent(new Event(Event.CHANGE));
            }
        }

        public function set focus(value:Boolean):void {
            _focus = value;
        }

        public function get name():String {
            return _name;
        }

        public function addToHistory(value:Number):void {
            _history.push(value);
            dispatchHistoryChange();
        }
    }
}
