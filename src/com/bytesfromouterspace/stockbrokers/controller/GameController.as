/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.controller {

    import com.bytesfromouterspace.stockbrokers.event.BonusEvent;
    import com.bytesfromouterspace.stockbrokers.event.GameEvent;
    import com.bytesfromouterspace.stockbrokers.event.InvestorsEvent;
    import com.bytesfromouterspace.stockbrokers.event.ReputationEvent;
    import com.bytesfromouterspace.stockbrokers.event.ReputationStatusEvent;
    import com.bytesfromouterspace.stockbrokers.event.TurnEvent;
    import com.bytesfromouterspace.stockbrokers.model.GameModel;

    public class GameController {

        private var _game:GameModel;
        public var market:MarketController;
        public var turn:TurnControler;
        public var reputation:ReputationController;
        public var investors:InvestorsController;
        private var generator:SoundRandomGeneratorController;
        private var _started:Boolean = false;

        public function GameController(model:GameModel) {
            this._game = model;

            generator = new SoundRandomGeneratorController(model.generator);
            market = new MarketController(model.market);
            turn = new TurnControler(model.turn);
            reputation = new ReputationController(model.reputation);
            investors = new InvestorsController(model.investors);

            // link market to reputation
            _game.market.addEventListener(ReputationEvent.REPUTATION_EVENT, reputation.reputationHandler);

            // link reputation to turn bonus
            _game.reputation.addEventListener(BonusEvent.BONUS_EVENT, turn.handleBonus);
            _game.reputation.addEventListener(ReputationStatusEvent.LEVEL_UP, turn.handleLevelUp);
            _game.reputation.addEventListener(ReputationStatusEvent.LEVEL_UP, investors.handleLevelChange);

            // link loans to funds
            _game.investors.addEventListener(InvestorsEvent.LOAN_ACCEPTED, market.onLoanAccepted);
            _game.investors.addEventListener(InvestorsEvent.LOAN_PAY, market.onLoanPay);

            // link turn timer to game controller
            _game.turn.addEventListener(TurnEvent.TIMER_ENDED, onTurnEnded);

        }

        public function startGame():void {
            _started = true;
            generator.start();
            turn.start();
        }

        private function onTurnEnded(event:TurnEvent):void {
            // pay interest rates
            if(market.payLoanedInterestRates(investors.getLoanedInterestRates()) && market.payTurnTax()) {
                generator.generate();
                turn.start();
            } else {
                trace("GAME END!");
                _game.turn.removeEventListener(TurnEvent.TIMER_ENDED, onTurnEnded);
                _game.endGame();
            }
        }




        public function pause():void {
            if(_started) {
                turn.pause();
            }
        }

        public function resume():void {
            if(_started) {
                turn.resume();
            } else {
                startGame();
            }
        }
    }
}
