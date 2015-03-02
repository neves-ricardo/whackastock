/**
 * Created by Akira on 01/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {

    import com.bytesfromouterspace.stockbrokers.event.ReputationEvent;
    import com.bytesfromouterspace.stockbrokers.model.MarketModel;
    import com.bytesfromouterspace.stockbrokers.model.ReputationModel;
    import com.bytesfromouterspace.stockbrokers.ui.components.BorderBackground;
    import com.bytesfromouterspace.stockbrokers.ui.components.ComponentBase;
    import com.bytesfromouterspace.stockbrokers.ui.components.Label;

    import flash.display.Bitmap;

    import flash.events.Event;

    public class FundsView extends ComponentBase {

        private var _model:MarketModel;
        private var _label:Label;
        private var _background:BorderBackground;

        public function FundsView(marketModel:MarketModel) {
            super(160,22);
            var lbl:Bitmap = theme.createBitmapLabel("Funds", 12, 0xFFFFFF );
            lbl.y = 3;
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
            _label = new Label(120, 22, formatNumber(_model.funds.available), 14, 0xFFFFFF, "04b08");
            _label.x = lbl.width + 5;
            _label.y = 2;
            addChild(_label);
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

        private function formatNumber(value:Number):String {

            var numString:String = value.toString()
            var result:String = ''

            while (numString.length > 3)  {
                var chunk:String = numString.substr(-3)
                numString = numString.substr(0, numString.length - 3)
                result = ',' + chunk + result
            }

            if (numString.length > 0) {
                result = numString + result
            }

            return result + "$";
        }

        private function onFundModelChange(event:Event):void {
            _label.text = formatNumber(_model.funds.available);
        }
    }
}
