/**
 * Created by Akira on 01/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {

    import com.bytesfromouterspace.stockbrokers.controller.TurnControler;
    import com.bytesfromouterspace.stockbrokers.event.TurnEvent;
    import com.bytesfromouterspace.stockbrokers.model.TurnModel;
    import com.bytesfromouterspace.stockbrokers.ui.components.BorderBackground;
    import com.bytesfromouterspace.stockbrokers.ui.components.Button;
    import com.bytesfromouterspace.stockbrokers.ui.components.ComponentBase;
    import com.bytesfromouterspace.stockbrokers.ui.components.Label;
    import com.bytesfromouterspace.stockbrokers.ui.components.ProgressBar;

    import flash.display.Bitmap;
    import flash.events.MouseEvent;

    public class TurnView extends ComponentBase {

        private var _background:BorderBackground;
        private var _controller:TurnControler;
        private var _model:TurnModel;
        private var _turnLabel:Label;
        private var _turnBar:ProgressBar;
        private var _btnReset:Button;
        private var _resetLabel:Label;

        public function TurnView(model:TurnModel, controller:TurnControler) {
            super(821, 30);
            _controller = controller;
            _model = model;

            _model.addEventListener(TurnEvent.TIMER_START, onTurnStart);
            _model.addEventListener(TurnEvent.TIMER_ENDED, onTurnEnd);
            _model.addEventListener(TurnEvent.TIMER_TICK, onTurnUpdate);

            _background = new BorderBackground(821, 30);
            _background.backgroundColor = 0x017EC1;
            _background.borderColor = 0x41C6F3;
            addChild(_background);

            var lbl:Bitmap = theme.createBitmapLabel("Turn", 12, 0xFFFFFF );
            lbl.x = 4;
            lbl.y = 7;
            addChild(lbl);

            _turnLabel = new Label(30, 20, "00", 15, 0xFFFFFF, "visitor1", "left");
            _turnLabel.x = 4 + lbl.width;
            _turnLabel.y = 7;
            addChild(_turnLabel);

            _turnBar = new ProgressBar(660);
            _turnBar.x = 74;
            _turnBar.y = 10;
            addChild(_turnBar);

            _btnReset = new Button(50, 20);
            _btnReset.buttonBackgroundDisabled = 0x666666;
            _btnReset.buttonBackgroundNormal = 0x008C00;
            _btnReset.buttonBackgroundOver = 0xFFCC00;
            _btnReset.buttonBorderNormal = 0xFFFFFF;
            _btnReset.drawBackground();
            _btnReset.setLabel(" Reset", 9, 0xFFFFFF);
            _btnReset.x = _width - 80;
            _btnReset.y = 5;

            _btnReset.addEventListener(MouseEvent.CLICK, onResetTimer);

            addChild(_btnReset);

            _resetLabel = new Label(30, 20, "00", 15, 0xFFFFFF, "visitor1", "left");
            _resetLabel.x = _width - 24;
            _resetLabel.y = 7;
            addChild(_resetLabel);
        }

        private function onTurnEnd(event:TurnEvent):void {

        }

        private function onTurnStart(event:TurnEvent):void {
            _turnLabel.text = numPadd(_model.currentTurn);
        }

        private function numPadd(num:int, digits:int = 2, padder:String = "0"):String {
            var ret:String = num.toString();
            while(ret.length < digits) {
                ret = padder + ret;
            }
            return ret;
        }

        private function onTurnUpdate(event:TurnEvent):void {
            _turnBar.setProgress(_model.progress)
        }

        private function onResetTimer(event:MouseEvent):void {
            _controller.start();
        }
    }
}
