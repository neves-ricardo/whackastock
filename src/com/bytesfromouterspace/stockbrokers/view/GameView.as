/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {
    import com.bytesfromouterspace.stockbrokers.controller.GameController;
    import com.bytesfromouterspace.stockbrokers.event.ReputationEvent;
    import com.bytesfromouterspace.stockbrokers.model.GameModel;
    import com.bytesfromouterspace.stockbrokers.ui.BottomBar;
    import com.bytesfromouterspace.stockbrokers.ui.components.ComponentBase;
    import com.bytesfromouterspace.stockbrokers.ui.components.ProgressBar;

    public class GameView extends ComponentBase {

        private var model:GameModel;
        private var turnView:TurnView;
        private var controller:GameController;
        private var marketView:MarketView;
        private var bottomBar:BottomBar;

        public function GameView(model:GameModel, controller:GameController) {
            super(800,600);
            this.model = model;
            this.controller = controller;
            turnView = new TurnView(model.turn, controller.turnController);
            turnView.x = 10;
            turnView.y = 10;
            addChild(turnView);
            marketView = new MarketView(model.market, controller.marketController);
            marketView.x = turnView.x;
            marketView.y = turnView.y + turnView.height + 4;
            addChild(marketView);
            bottomBar = new BottomBar(new FundsView(model.market));
            bottomBar.x = marketView.x;
            bottomBar.y = marketView.y + marketView.height + 4;
            addChild(bottomBar);

        }
    }
}
