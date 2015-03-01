/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.controller {
    import com.bytesfromouterspace.stockbrokers.model.GameModel;

    public class GameController {

        private var _gameModel:GameModel;
        public var marketController:MarketController;

        public function GameController(model:GameModel) {
            this._gameModel = model;
            marketController = new MarketController(model.market);
        }
    }
}
