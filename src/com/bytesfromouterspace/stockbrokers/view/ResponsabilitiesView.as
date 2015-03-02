/**
 * Created by Akira on 02/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {
    import com.bytesfromouterspace.stockbrokers.event.InvestorsEvent;
    import com.bytesfromouterspace.stockbrokers.model.InvestorsModel;
    import com.bytesfromouterspace.stockbrokers.ui.StringUtils;
    import com.bytesfromouterspace.stockbrokers.ui.components.BorderBackground;
    import com.bytesfromouterspace.stockbrokers.ui.components.ComponentBase;
    import com.bytesfromouterspace.stockbrokers.ui.components.Label;

    import flash.display.Bitmap;

    public class ResponsabilitiesView extends ComponentBase {

        private var _model:InvestorsModel;
        private var _backgroundRates:BorderBackground;
        private var _labelRates:Label;
        private var _backgroundLoaned:BorderBackground;
        private var _labelLoaned:Label;

        public function ResponsabilitiesView(model:InvestorsModel) {
            super(300,22);
            this._model = model;
            _model.addEventListener(InvestorsEvent.CHANGE, onInvestorsChange);
            var lbl:Bitmap = theme.createBitmapLabel("Rate Expenses / Turn", 12, 0xFFFFFF );
            lbl.y = 4;
            _backgroundRates = new BorderBackground(100, 22);
            _backgroundRates.backgroundColor = 0x164259;
            _backgroundRates.borderColor = 0x12638D;
            _backgroundRates.x = lbl.width + 5;
            _backgroundRates.y = 1;
            addChild(_backgroundRates);
            addChild(lbl);
            _labelRates = new Label(100, 22, StringUtils.formatCurrency(_model.responsabilitiesRates), 14, 0xFFFFFF, "04b08");
            _labelRates.x = lbl.width + 5;
            _labelRates.y = 2;
            addChild(_labelRates);

            lbl = theme.createBitmapLabel("Total Capital Loaned", 12, 0xFFFFFF );
            lbl.x = _labelRates.x + _labelRates.width + 40;
            lbl.y = 4;
            addChild(lbl);

            _backgroundLoaned = new BorderBackground(120, 22);
            _backgroundLoaned.backgroundColor = 0x164259;
            _backgroundLoaned.borderColor = 0x12638D;
            _backgroundLoaned.x = lbl.width + 5 + lbl.x;
            _backgroundLoaned.y = 1;
            addChild(_backgroundLoaned);

            _labelLoaned = new Label(120, 22, StringUtils.formatCurrency(_model.responsabilitiesTotal), 14, 0xFFFFFF, "04b08");
            _labelLoaned.x = lbl.width + 5 +  lbl.x;
            _labelLoaned.y = 2;
            addChild(_labelLoaned);
        }

        private function onInvestorsChange(event:InvestorsEvent):void {
            _labelRates.text = StringUtils.formatCurrency(_model.responsabilitiesRates);
            _labelLoaned.text = StringUtils.formatCurrency(_model.responsabilitiesTotal);
        }
    }
}
