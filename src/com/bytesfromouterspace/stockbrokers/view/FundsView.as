/**
 * Created by Akira on 01/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {

    import com.bytesfromouterspace.stockbrokers.event.ReputationEvent;
    import com.bytesfromouterspace.stockbrokers.model.MarketModel;
    import com.bytesfromouterspace.stockbrokers.model.ReputationModel;
    import com.bytesfromouterspace.stockbrokers.ui.StringUtils;
    import com.bytesfromouterspace.stockbrokers.ui.components.BorderBackground;
    import com.bytesfromouterspace.stockbrokers.ui.components.ComponentBase;
    import com.bytesfromouterspace.stockbrokers.ui.components.Label;

    import flash.display.Bitmap;

    import flash.events.Event;

    public class FundsView extends ComponentBase {

        private var _model:MarketModel;
        private var _label:Label;
        private var _background:BorderBackground;
        private var _labelStocks:Label;

        public function FundsView(marketModel:MarketModel) {
            super(400,22);
            var lbl:Bitmap = theme.createBitmapLabel("Funds", 12, 0xFFFFFF );
            lbl.y = 4;
            _background = new BorderBackground(120, 22);
            _background.backgroundColor = 0x164259;
            _background.borderColor = 0x12638D;
            _background.x = lbl.width + 5;
            _background.y = 1;
            addChild(_background);
            addChild(lbl);
            _model = marketModel;
            _model.funds.addEventListener(Event.CHANGE, onFundModelChange);
            _model.addEventListener(ReputationEvent.REPUTATION_EVENT, onFundModelReputation);
            _label = new Label(120, 22, StringUtils.formatCurrency(_model.funds.available), 14, 0xFFFFFF, "04b08");
            _label.x = lbl.width + 5;
            _label.y = 2;
            addChild(_label);

            var lblAux:Bitmap = theme.createBitmapLabel("Owned Stocks", 10, 0xFFFFFF);
            lblAux.x = _label.x + _label.width + 20;
            lblAux.y = 5;
            addChild(lblAux);

            _labelStocks = new Label(100, 20, StringUtils.formatCurrency(_model.ownedStocksValue), 12, 0xFFFFFF, "visitor1");
            _labelStocks.background.backgroundColor = 0x164259;
            _labelStocks.background.borderColor = 0x12638D;
            _labelStocks.x = lblAux.x + lblAux.width + 5;
            _labelStocks.y = 2;
            addChild(_labelStocks);
            destroyHandler = onDestroy;
        }

        private function onDestroy():void {
            _model.funds.removeEventListener(Event.CHANGE, onFundModelChange);
            _model.removeEventListener(ReputationEvent.REPUTATION_EVENT, onFundModelReputation);
        }

        private function onFundModelReputation(event:ReputationEvent):void {
            if (event.repType == ReputationModel.REP_TYPE_FRAUD_INSUFFICIENT_FUNDS) {
                _background.setTemporaryTint(0xFF0000, 6);
            } else if(event.repType == ReputationModel.REP_TYPE_SUCCESSFUL_SELL) {
                _background.setTemporaryTint(0x00B200, 4);
            }
        }

        private function onFundModelChange(event:Event):void {
            _label.text = StringUtils.formatCurrency(_model.funds.available);
            _labelStocks.text = StringUtils.formatCurrency(_model.ownedStocksValue);
        }
    }
}
