/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {
    import com.bytesfromouterspace.stockbrokers.controller.GameController;
    import com.bytesfromouterspace.stockbrokers.event.ReputationEvent;
    import com.bytesfromouterspace.stockbrokers.model.GameModel;
    import com.bytesfromouterspace.stockbrokers.model.IHistoryModel;
    import com.bytesfromouterspace.stockbrokers.ui.BottomBar;
    import com.bytesfromouterspace.stockbrokers.ui.components.Button;
    import com.bytesfromouterspace.stockbrokers.ui.components.GraphButton;
    import com.bytesfromouterspace.stockbrokers.ui.components.ComponentBase;
    import com.bytesfromouterspace.stockbrokers.ui.components.ProgressBar;

    import flash.events.FocusEvent;
    import flash.events.MouseEvent;

    public class GameView extends ComponentBase {

        private var model:GameModel;
        private var turnView:TurnView;
        private var controller:GameController;
        private var marketView:MarketView;
        private var bottomBar:BottomBar;
        private var investorsView:InvestorsView;
        private var reputationView:ReputationView;
        private var historyView:MarketHistoryView;

        public function GameView(model:GameModel, controller:GameController) {
            super(821,600);
            this.model = model;
            this.controller = controller;

            historyView = new MarketHistoryView(model.market);
            historyView.x = 10;
            historyView.y = 10;
            addChild(historyView);

            investorsView = new InvestorsView(model.investors, controller.investors);
            investorsView.x = _width - investorsView.width + 11;
            investorsView.y = historyView.y;
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
            bottomBar = new BottomBar(new FundsView(model.market), new ResponsabilitiesView(model.investors));
            bottomBar.x = marketView.x;
            bottomBar.y = marketView.y + marketView.height + 4;
            addChild(bottomBar);

            addEventListener(FocusEvent.FOCUS_IN, onFocusChange);

            var btn:Button = new Button(100, 20);
            btn.setLabel("Start Game", 10, 0xFFFFFF);
            btn.x = bottomBar.x;
            btn.y = bottomBar.y + bottomBar.height + 4;
            addChild(btn);
            btn.addEventListener(MouseEvent.CLICK, onBtnClick);
        }

        private function onBtnClick(event:MouseEvent):void {
            (event.target as Button).enabled = false;
            controller.startGame();
        }

        private function onFocusChange(event:FocusEvent):void {
            event.stopImmediatePropagation();
            if((event.target is GraphButton)||(event.target is MarketHistoryView)) {
                historyView.historyModel = model.market;
            } else if(event.target is StockShareView) {
                historyView.historyModel = event.target.model as IHistoryModel;
            }
        }
    }
}
