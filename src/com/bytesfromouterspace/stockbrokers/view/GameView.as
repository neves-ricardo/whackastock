/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {
    import com.bytesfromouterspace.stockbrokers.controller.GameController;
    import com.bytesfromouterspace.stockbrokers.model.GameModel;
    import com.bytesfromouterspace.stockbrokers.ui.components.BottomBar;
    import com.bytesfromouterspace.stockbrokers.ui.components.ComponentBase;

    public class GameView extends ComponentBase {

        private var model:GameModel;
        private var controller:GameController;
        private var marketView:MarketView;
        private var bottomBar:BottomBar;

        public function GameView(model:GameModel, controller:GameController) {
            super(800,600);
            this.model = model;
            this.controller = controller;
            marketView = new MarketView(model.market, controller.marketController);
            marketView.x = 10;
            marketView.y = 200;
            addChild(marketView);
            bottomBar = new BottomBar();
            bottomBar.x = marketView.x;
            bottomBar.y = marketView.y + marketView.height + 4;
            addChild(bottomBar);
        }
    }
}
