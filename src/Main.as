package {

    import com.bytesfromouterspace.stockbrokers.controller.GameController;
    import com.bytesfromouterspace.stockbrokers.controller.SoundRandomGeneratorController;
    import com.bytesfromouterspace.stockbrokers.controller.StockShareController;
    import com.bytesfromouterspace.stockbrokers.model.GameModel;
    import com.bytesfromouterspace.stockbrokers.model.SoundRandomGeneratorModel;
    import com.bytesfromouterspace.stockbrokers.model.StockShareModel;
    import com.bytesfromouterspace.stockbrokers.ui.components.Button;
    import com.bytesfromouterspace.stockbrokers.ui.components.Label;
    import com.bytesfromouterspace.stockbrokers.ui.components.Panel;
    import com.bytesfromouterspace.stockbrokers.view.GameView;
    import com.bytesfromouterspace.stockbrokers.view.SoundRandomGeneratorView;
    import com.bytesfromouterspace.stockbrokers.view.StockShareView;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;

    [SWF(width="1280", height="768", backgroundColor="#212121")]
    public class Main extends Sprite {
        public function Main() {
            addEventListener(Event.ADDED_TO_STAGE, onStageAdd);
        }
        
        private var _gameModel:GameModel;
        private var _gameController:GameController;
        private var _gameView:GameView;
        
        private function onStageAdd(event:Event):void {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            _gameModel = new GameModel();
            _gameController = new GameController(_gameModel);
            _gameView = new GameView(_gameModel, _gameController);
            addChild(_gameView);
            _gameController.startGame();
        }
    }
}
