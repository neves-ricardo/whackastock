/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {
    import com.bytesfromouterspace.stockbrokers.event.ReputationEvent;

    import flash.events.Event;

    [Event(name="change", type="flash.events.Event")]
    [Event(name="reputationEvent", type="com.bytesfromouterspace.stockbrokers.event.ReputationEvent")]
    public class FundsModel extends BaseModel {

        private var _funds:Number = 30000;

        public function FundsModel(startingCash:int) {
            super();
            _funds = startingCash;
        }

        public function withdraw(amount:Number):void {
            if(_funds >= amount) {
                funds -= amount;
            } else {
                dispatchEvent(new ReputationEvent(ReputationModel.REP_TYPE_FRAUD_INSUFFICIENT_FUNDS));
            }
        }

        public function validatedWithdraw(amount:Number):Boolean {
            if(amount == 0) {
                return true;
            }
            var auxFunds:Number = _funds;
            withdraw(amount);
            return (auxFunds != _funds);
        }

        public function add(amount:Number):void {
            funds += amount;
        }

        public function get available():Number {
            return _funds;
        }

        private function set funds(value:Number):void {
            _funds = value;
            dispatchEvent(new Event(Event.CHANGE));
        }

        private function get funds():Number {
            return _funds;
        }
    }
}
