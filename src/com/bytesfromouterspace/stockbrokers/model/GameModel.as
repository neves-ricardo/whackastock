/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {

    public class GameModel extends BaseModel {

        public var turn:TurnModel;
        public var market:MarketModel;
        public var reputation:ReputationModel;
        public var investors:InvestorsModel;

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

            // Prepare turn timer
            turn = new TurnModel(10);

            // Prepare investors & kingpins
            investors = new InvestorsModel();


        }

    }
}
