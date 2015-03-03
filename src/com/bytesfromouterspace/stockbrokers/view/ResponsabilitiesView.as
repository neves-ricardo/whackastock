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
            var lbl:Bitmap = theme.createBitmapLabel("Rates / Turn", 10, 0xFFFFFF);
            lbl.y = 5;

            addChild(lbl);
            _labelRates = new Label(100, 22, StringUtils.formatCurrency(_model.responsabilitiesRates+1000), 12, 0xFFFFFF, "visitor1");
            _labelRates.background.backgroundColor = 0x164259;
            _labelRates.background.borderColor = 0x12638D;
            _labelRates.x = lbl.width + 5;
            _labelRates.y = 2;
            addChild(_labelRates);

            lbl = theme.createBitmapLabel("Loans", 10, 0xFFFFFF );
            lbl.x = _labelRates.x + _labelRates.width + 40;
            lbl.y = 5;
            addChild(lbl);

            _labelLoaned = new Label(120, 22, StringUtils.formatCurrency(_model.responsabilitiesTotal), 12, 0xFFFFFF, "visitor1");
            _labelLoaned.background.backgroundColor = 0x164259;
            _labelLoaned.background.borderColor = 0x12638D;
            _labelLoaned.x = lbl.width + 5 +  lbl.x;
            _labelLoaned.y = 2;
            addChild(_labelLoaned);
        }

        private function onInvestorsChange(event:InvestorsEvent):void {
            _labelRates.text = StringUtils.formatCurrency(_model.responsabilitiesRates+1000);
            _labelLoaned.text = StringUtils.formatCurrency(_model.responsabilitiesTotal);
        }
    }
}
