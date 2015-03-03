/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {
    import com.bytesfromouterspace.stockbrokers.controller.GameController;
    import com.bytesfromouterspace.stockbrokers.event.GameEvent;
    import com.bytesfromouterspace.stockbrokers.event.ReputationEvent;
    import com.bytesfromouterspace.stockbrokers.model.GameModel;
    import com.bytesfromouterspace.stockbrokers.model.IHistoryModel;
    import com.bytesfromouterspace.stockbrokers.ui.BottomBar;
    import com.bytesfromouterspace.stockbrokers.ui.components.BlockerPanel;
    import com.bytesfromouterspace.stockbrokers.ui.components.Button;
    import com.bytesfromouterspace.stockbrokers.ui.components.GraphButton;
    import com.bytesfromouterspace.stockbrokers.ui.components.ComponentBase;
    import com.bytesfromouterspace.stockbrokers.ui.components.ProgressBar;

    import flash.events.Event;

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
        private var headerBar:HeaderBar;
        private var transactionLogView:TransactionLogView;

        public function GameView(model:GameModel, controller:GameController) {
            super(821,600);
            this.model = model;
            this.controller = controller;

            model.addEventListener(GameEvent.GAME_OVER, onGameOver);

            headerBar = new HeaderBar(model, controller);
            headerBar.x = 10;
            headerBar.y = 10;
            addChild(headerBar);

            historyView = new MarketHistoryView(model.market);
            historyView.x = 10;
            historyView.y = headerBar.y + headerBar.height + 4;
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

            transactionLogView = new TransactionLogView(model.market.logger);
            transactionLogView.x = bottomBar.x;
            transactionLogView.y = bottomBar.y + bottomBar.height + 4;
            addChild(transactionLogView);

            var intro:HelpView = new HelpView(true);
            intro.addEventListener(Event.CLOSE, onIntroClosed);
            intro.x = 10;
            intro.y = 10;
            addChild(intro);
        }

        private function onIntroClosed(event:Event):void {
            var intro:HelpView = event.target as HelpView;
            intro.removeEventListener(Event.CLOSE, onIntroClosed);
            removeChild(intro);
            controller.startGame();
        }

        private function onGameOver(event:GameEvent):void {
            var gameOverView:GameOverView = new GameOverView();
            gameOverView.addEventListener(Event.CLOSE, onGameOverClosed);
            gameOverView.x = 10;
            gameOverView.y = 10;
            addChild(gameOverView);
        }

        private function onGameOverClosed(event:Event):void {
            var gameOverView:GameOverView = event.target as GameOverView;
            gameOverView.removeEventListener(Event.CLOSE, onGameOverClosed);
            removeChild(gameOverView);
        }

        private function onFocusChange(event:FocusEvent):void {
            event.stopImmediatePropagation();
            if((event.target is GraphButton)||(event.target is MarketHistoryView)) {
                historyView.historyModel = model.market;
            } else if(event.target is StockShareView) {
                historyView.historyModel = event.target.model as IHistoryModel;
            }
        }

        public function requestHelpMenu():void {
            controller.pause();
            var help:HelpView = new HelpView(false);
            help.addEventListener(Event.CLOSE, onPanelClosed);
            help.x = 10;
            help.y = 10;
            addChild(help);
        }

        private function onPanelClosed(event:Event):void {
            var help:HelpView = event.target as HelpView;
            help.removeEventListener(Event.CLOSE, onPanelClosed);
            removeChild(help);
            controller.resume();
        }
    }
}
