/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {

    import com.bytesfromouterspace.stockbrokers.event.StockShareEvent;
    import com.bytesfromouterspace.stockbrokers.event.TransactionEvent;

    [Event(name="stockShareChanged", type="com.bytesfromouterspace.stockbrokers.event.StockShareEvent")]
    public class StockShareModel extends BaseModel {

        public var stockId:int = 0;
        public var startingValue:Number;
        public var value:Number;
        public var samples:int;
        private var lastSample:Number = 0;
        public var name:String;
        private var _quantityAvailable:int = 0;
        private var _quantityOwned:int = 0;
        private var _ownedValue:Number = 0;
        public var delta:Number = 0;

        public function StockShareModel(stockId:int, name:String) {
            super();
            this.stockId = stockId;
            this.name = name;
            _quantityAvailable = 1000;
            startingValue = int(Math.random() * 100);
            samples = 0;
            value = startingValue;
            lastSample = value;
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
                value += auxDelta;
            } else {
                signal = newValue > 0 ? 1 : -1;
                value += (Math.random()*startingValue*signal);
            }*/
            auxDelta = newValue * startingValue;
            value += auxDelta - value;
            if(value < 0.1 * startingValue) {
                value = 0.1 * startingValue;
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
                _ownedValue = (_quantityOwned * _ownedValue + amount * value) / (_quantityOwned + amount);
            } else {
                _ownedValue = value;
            }
            _quantityOwned += amount;
            refresh();
        }

        public function doSell(amount:int):void {
            _quantityAvailable += amount;
            _quantityOwned -= amount;
            refresh();
        }
    }
}
