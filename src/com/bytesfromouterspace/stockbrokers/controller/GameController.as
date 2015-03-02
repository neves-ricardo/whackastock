/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.controller {
    import com.bytesfromouterspace.stockbrokers.event.BonusEvent;
    import com.bytesfromouterspace.stockbrokers.event.ReputationEvent;
    import com.bytesfromouterspace.stockbrokers.event.ReputationStatusEvent;
    import com.bytesfromouterspace.stockbrokers.model.GameModel;

    public class GameController {

        private var _game:GameModel;
        public var market:MarketController;
        public var turn:TurnControler;
        public var reputation:ReputationController;
        public var investors:InvestorsController;

        public function GameController(model:GameModel) {
            this._game = model;
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

        }
    }
}
