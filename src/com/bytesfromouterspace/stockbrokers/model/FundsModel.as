/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {
    import com.bytesfromouterspace.stockbrokers.event.ReputationEvent;

    public class FundsModel extends BaseModel {

        private var _funds:Number = 700000;

        public function FundsModel() {
            super();
        }

        public function withdraw(amount:Number):void {
            if(_funds >= amount) {
                _funds -= amount;
            } else {
                dispatchEvent(new ReputationEvent(ReputationModel.REP_TYPE_FRAUD_INSUFFICIENT_FUNDS));
            }
        }

        public function add(amount:Number):void {
            _funds += amount;
        }

        public function get available():Number {
            return _funds;
        }

        public function set funds(value:Number):void {
            _funds = value;
        }
    }
}
