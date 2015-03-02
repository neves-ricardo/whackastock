/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.controller {
    import com.bytesfromouterspace.stockbrokers.event.BonusEvent;
    import com.bytesfromouterspace.stockbrokers.event.ReputationEvent;
    import com.bytesfromouterspace.stockbrokers.model.GameModel;

    public class GameController {

        private var _gameModel:GameModel;
        public var marketController:MarketController;
        public var turnController:TurnControler;
        public var reputationController:ReputationController;

        public function GameController(model:GameModel) {
            this._gameModel = model;
            marketController = new MarketController(model.market);
            turnController = new TurnControler(model.turn);
            reputationController = new ReputationController(model.reputation);

            // link market to reputation
            _gameModel.market.addEventListener(ReputationEvent.REPUTATION_EVENT, reputationController.reputationHandler);

            // link reputation to turn bonus
            _gameModel.reputation.addEventListener(BonusEvent.BONUS_EVENT, turnController.handleBonus);

        }
    }
}
