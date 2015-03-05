/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {

    import com.bytesfromouterspace.stockbrokers.event.BonusEvent;
    import com.bytesfromouterspace.stockbrokers.event.ReputationStatusEvent;

    [Event(name="change", type="com.bytesfromouterspace.stockbrokers.event.ReputationStatusEvent")]
    [Event(name="levelUp", type="com.bytesfromouterspace.stockbrokers.event.ReputationStatusEvent")]
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
        private var _level:int = 0;

        public function ReputationModel() {
            super();
        }

        public function set value(amount:int):void {
            _value += amount;
            if(_value < 0) {
                _value = 0;
            }
            if(amount > 0) {
                incStat("totalRepGained", amount);
            } else {
                incStat("totalRepLost", amount);
            }
            dispatchEvent(new ReputationStatusEvent(ReputationStatusEvent.CHANGE));
            checkReputationLevel();
        }

        public function get value():int {
            return _value;
        }

        public function get level():int {
            return _level;
        }

        protected function checkReputationLevel():void {
            var curLevel:int = Math.floor(_value / 100);
            if(curLevel != _level) {
                _level = curLevel;
                dispatchEvent(new ReputationStatusEvent(ReputationStatusEvent.LEVEL_UP, _level));
            }
            multiStat("ReputationLevel", _level, STAT_CURRENT, STAT_MAX);
            multiStat("ReputationValue", _value, STAT_CURRENT, STAT_MAX);
        }


        public function setBonus(bonusCategory:int):void {
            incStat("totalRepBonus", bonusCategory);
            dispatchEvent(new BonusEvent(bonusCategory));
        }
    }
}
