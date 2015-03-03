package {

    import com.bytesfromouterspace.stockbrokers.controller.GameController;
    import com.bytesfromouterspace.stockbrokers.model.GameModel;
    import com.bytesfromouterspace.stockbrokers.view.GameView;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;

    [SWF(width="924", height="720", backgroundColor="#212121")]
    public class WackAStock extends Sprite {

        public function WackAStock() {
            addEventListener(Event.ADDED_TO_STAGE, onStageAdd);
        }
        
        private var _gameModel:GameModel;
        private var _gameController:GameController;
        private var _gameView:GameView;
        
        private function onStageAdd(event:Event):void {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            scaleX = scaleY = 1.1;
            addEventListener("reloadGame", reloadGame);
            _gameModel = new GameModel();
            _gameController = new GameController(_gameModel);
            _gameView = new GameView(_gameModel, _gameController);
            addChild(_gameView);
        }

        public function reloadGame(event:Event):void {
            removeChildren();
            _gameModel = null;
            _gameController = null;
            _gameView = null;
            _gameModel = new GameModel();
            _gameController = new GameController(_gameModel);
            _gameView = new GameView(_gameModel, _gameController);
            addChild(_gameView);
        }
    }
}
