/**
 * Created by Akira on 02/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.controller {
    import com.bytesfromouterspace.stockbrokers.event.ReputationEvent;
    import com.bytesfromouterspace.stockbrokers.model.ReputationModel;
    import com.bytesfromouterspace.stockbrokers.model.ReputationModel;

    public class ReputationController {

        private var _model:ReputationModel;

        public function ReputationController(model:ReputationModel) {
            this._model = model;
        }

        public function reputationHandler(event:ReputationEvent):void {
            var repMod:int = event.repAmount;
            switch(event.repType) {
                case ReputationModel.REP_TYPE_SUCCESSFUL_BUY:
                    repMod += _model.reputationValueSuccessfulBuy;
                    break;
                case ReputationModel.REP_TYPE_SUCCESSFUL_SELL:
                    repMod += _model.reputationValueSuccessfulSell;
                    break;
                case ReputationModel.REP_TYPE_FRAUD_INSUFFICIENT_FUNDS:
                    repMod += _model.reputationValueFraudInsFunds;
                    break;
                case ReputationModel.REP_TYPE_FRAUD_QUANTITY_BUY:
                    repMod += _model.reputationValueFraudQtdBuy;
                    break;
                case ReputationModel.REP_TYPE_FRAUD_QUANTITY_SELL:
                    repMod += _model.reputationValueFraudQtdSell;
                    break;
            }
            _model.value = repMod;
            if(repMod > 30) {
                _model.setBonus(4);
            } else if(repMod > 10) {
                _model.setBonus(2);
            } else if(repMod > 0) {
                _model.setBonus(1);
            }
        }
    }
}
