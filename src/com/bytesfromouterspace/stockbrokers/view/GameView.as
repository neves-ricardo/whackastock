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
        private var investorsView:InvestorsView;
        private var reputationView:ReputationView;

        public function GameView(model:GameModel, controller:GameController) {
            super(821,600);
            this.model = model;
            this.controller = controller;

            investorsView = new InvestorsView(model.investors, controller.investors);
            investorsView.x = _width - investorsView.width + 11;
            investorsView.y = 10;
            addChild(investorsView);

            reputationView = new ReputationView(model.reputation, controller.reputation);
            reputationView.x = investorsView.x;
            reputationView.y = investorsView.y + investorsView.height - 30;
            addChild(reputationView);

            turnView = new TurnView(model.turn, controller.turn);
            turnView.x = 10;
            turnView.y = investorsView.y + investorsView.height + 4;
            addChild(turnView);
            marketView = new MarketView(model.market, controller.market);
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
