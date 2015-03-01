/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.event {
    import flash.events.Event;

    public class TransactionEvent extends Event {

        public static const TRANSACTION_EVENT:String = "transactionEvent";

        public static const TRANSACTION_TYPE_SELL:uint = 0;
        public static const TRANSACTION_TYPE_BUY:uint = 1;

        public var stockId:int;
        public var transactionType:uint;
        public var amount:int;

        public function TransactionEvent(stockId:int, transactionType:uint, amount:int, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(TRANSACTION_EVENT, bubbles, cancelable);
            this.stockId = stockId;
            this.transactionType = transactionType;
            this.amount = amount;
        }

        public override function clone():Event {
            return new TransactionEvent(stockId, transactionType, amount);
        }

        public override function toString():String {
            return formatToString("TransactionEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

    }
}