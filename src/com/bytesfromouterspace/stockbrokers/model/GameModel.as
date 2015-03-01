/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {
    import com.bytesfromouterspace.stockbrokers.event.ReputationEvent;

    public class GameModel extends BaseModel {

        public var market:MarketModel;
        public var reputation:ReputationModel;

        public function GameModel() {
            super();
            market = new MarketModel();
            reputation = new ReputationModel();
            market.addEventListener(ReputationEvent.REPUTATION_EVENT, reputation.handleFraud);

        }

    }
}
