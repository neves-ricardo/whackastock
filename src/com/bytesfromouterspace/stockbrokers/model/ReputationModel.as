/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {

    import com.bytesfromouterspace.stockbrokers.event.BonusEvent;

    [Event(name="bonusEvent", type="com.bytesfromouterspace.stockbrokers.event.BonusEvent")]
    public class ReputationModel extends BaseModel {

        public static const REP_TYPE_SUCCESSFUL_BUY:uint = 0;
        public static const REP_TYPE_SUCCESSFUL_SELL:uint = 1;
        public static const REP_TYPE_FRAUD_INSUFFICIENT_FUNDS:uint = 2;
        public static const REP_TYPE_FRAUD_QUANTITY_BUY:uint = 3;
        public static const REP_TYPE_FRAUD_QUANTITY_SELL:uint = 4;

        public var reputationValueSuccessfulBuy:int = 10;
        public var reputationValueSuccessfulSell:int = 15;
        public var reputationValueFraudInsFunds:int = -50;
        public var reputationValueFraudQtdBuy:int = -5;
        public var reputationValueFraudQtdSell:int = -20;

        private var _value:int = 0;

        public function ReputationModel() {
            super();
        }

        public function set value(amount:int):void {
            _value += amount;
            if(_value < 0) {
                _value = 0;
            }
            checkReputationLevel();
        }

        protected function checkReputationLevel():void {
            trace("New reputation level:", _value);
        }


        public function setBonus(bonusCategory:int):void {
            dispatchEvent(new BonusEvent(bonusCategory));
        }
    }
}
