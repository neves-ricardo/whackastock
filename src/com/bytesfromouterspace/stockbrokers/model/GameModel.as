/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {

    public class GameModel extends BaseModel {

        public var turn:TurnModel;
        public var market:MarketModel;
        public var reputation:ReputationModel;
        public var investors:InvestorsModel;
        public var generator:SoundRandomGeneratorModel;

        public function GameModel() {
            super();

            generator = new SoundRandomGeneratorModel('assets/audio/sample1_cut.mp3');

            // Prepare Market
            market = new MarketModel(generator);

            // Prepare reputation, set bonus & penalties
            reputation = new ReputationModel();
            reputation.reputationValueSuccessfulBuy = 10;
            reputation.reputationValueSuccessfulSell = 15;
            reputation.reputationValueFraudInsFunds = -50;
            reputation.reputationValueFraudQtdBuy = -5;
            reputation.reputationValueFraudQtdSell = -20;

            // Prepare turn timer
            turn = new TurnModel(1);

            // Prepare investors & kingpins
            investors = new InvestorsModel();


        }

    }
}
