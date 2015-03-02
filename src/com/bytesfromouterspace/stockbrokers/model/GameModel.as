/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {

    public class GameModel extends BaseModel {

        public var turn:TurnModel;
        public var market:MarketModel;
        public var reputation:ReputationModel;

        public function GameModel() {
            super();

            // Prepare Market
            market = new MarketModel();

            // Prepare reputation, set bonus & penalties
            reputation = new ReputationModel();
            reputation.reputationValueSuccessfulBuy = 10;
            reputation.reputationValueSuccessfulSell = 15;
            reputation.reputationValueFraudInsFunds = -50;
            reputation.reputationValueFraudQtdBuy = -5;
            reputation.reputationValueFraudQtdSell = -20;

            // Link market events to reputation handler
            // market.addEventListener(ReputationEvent.REPUTATION_EVENT, reputation.reputationHandler);

            turn = new TurnModel(10);
            // Link turn to rep bonus
            //reputation.addEventListener(BonusEvent.BONUS_EVENT, turn.bo)
        }

    }
}
