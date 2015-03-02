/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.ui {
    import com.bytesfromouterspace.stockbrokers.event.ReputationEvent;
    import com.bytesfromouterspace.stockbrokers.ui.components.BorderBackground;
    import com.bytesfromouterspace.stockbrokers.ui.components.ComponentBase;
    import com.bytesfromouterspace.stockbrokers.view.FundsView;
    import com.bytesfromouterspace.stockbrokers.view.ResponsabilitiesView;

    public class BottomBar extends ComponentBase {

        private var background:BorderBackground;
        private var funds:FundsView;
        private var responsabilities:ResponsabilitiesView;

        public function BottomBar(fundsView:FundsView, responsabilitiesView:ResponsabilitiesView) {
            super(821, 30);
            background = new BorderBackground(821, 30);
            background.backgroundColor = 0x017EC1;
            background.borderColor = 0x41C6F3;
            addChild(background);

            funds = fundsView;
            funds.x = 5;
            funds.y = 3;
            addChild(funds);

            responsabilities = responsabilitiesView;
            responsabilities.x = 200;
            responsabilities.y = 3;
            addChild(responsabilities);
        }
    }
}
