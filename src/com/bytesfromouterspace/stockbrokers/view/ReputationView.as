/**
 * Created by Akira on 02/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {
    import com.bytesfromouterspace.stockbrokers.controller.ReputationController;
    import com.bytesfromouterspace.stockbrokers.event.ReputationStatusEvent;
    import com.bytesfromouterspace.stockbrokers.model.ReputationModel;
    import com.bytesfromouterspace.stockbrokers.ui.components.ComponentBase;
    import com.bytesfromouterspace.stockbrokers.ui.components.Label;
    import com.bytesfromouterspace.stockbrokers.ui.components.ProgressBar;

    import flash.display.Bitmap;

    public class ReputationView extends ComponentBase {

        private var _trustLabel:Label;
        private var _trustBar:ProgressBar;
        private var _model:ReputationModel;
        private var _controller:ReputationController;

        public function ReputationView(model:ReputationModel, controller:ReputationController) {
            super(350, 30);
            this._model = model;
            this._controller = controller;

            _model.addEventListener(ReputationStatusEvent.CHANGE, onReputationChange);
            _model.addEventListener(ReputationStatusEvent.LEVEL_UP, onReputationLevelUp);

            var lbl:Bitmap = theme.createBitmapLabel("Trust Lvl", 12, 0xFFFFFF );
            lbl.x = 4;
            lbl.y = 7;
            addChild(lbl);

            _trustLabel = new Label(30, 20, _model.level.toString(), 15, 0xFFFFFF, "visitor1", "left");
            _trustLabel.x = 4 + lbl.width;
            _trustLabel.y = 7;
            addChild(_trustLabel);

            _trustBar = new ProgressBar(232);
            //_trustBar.animSpeed = 0.005;
            _trustBar.x = 110;
            _trustBar.y = 10;
            _trustBar.setProgress(0);
            addChild(_trustBar);
        }

        private function onReputationLevelUp(event:ReputationStatusEvent):void {
            _trustLabel.text = _model.level.toString();
        }

        private function onReputationChange(event:ReputationStatusEvent):void {
            var barValue:uint = _model.value % 100;
            _trustBar.setProgress(barValue * 0.01);
        }
    }
}
