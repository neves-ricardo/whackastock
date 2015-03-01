/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {
    import com.bytesfromouterspace.stockbrokers.event.ReputationEvent;

    public class ReputationModel extends BaseModel {

        public static const REP_TYPE_SUCCESSFUL_BUY:uint = 0;
        public static const REP_TYPE_SUCCESSFUL_SELL:uint = 1;
        public static const REP_TYPE_FRAUD_INSUFFICIENT_FUNDS:uint = 2;
        public static const REP_TYPE_FRAUD_QUANTITY_BUY:uint = 3;
        public static const REP_TYPE_FRAUD_QUANTITY_SELL:uint = 4;

        private var _value:int = 0;

        public function ReputationModel() {
            super();
        }

        public function increase(amount:int):void {
            _value += amount;
            checkReputationLevel();
        }

        public function decrease(amount:int):void {
            _value -= amount;
            if(_value < 0) {
                _value = 0;
            }
            checkReputationLevel();
        }

        protected function checkReputationLevel():void {
            trace("New reputation level:", _value);
        }

        public function handleFraud(event:ReputationEvent):void {
            switch(event.repType) {
                case REP_TYPE_SUCCESSFUL_BUY:
                    increase(10);
                    break;
                case REP_TYPE_SUCCESSFUL_SELL:
                    increase(15);
                    break;
                case REP_TYPE_FRAUD_INSUFFICIENT_FUNDS:
                    decrease(30);
                    break;
                case REP_TYPE_FRAUD_QUANTITY_BUY:
                    decrease(5);
                    break;
                case REP_TYPE_FRAUD_QUANTITY_SELL:
                    decrease(20);
                    break;
            }
        }
    }
}
