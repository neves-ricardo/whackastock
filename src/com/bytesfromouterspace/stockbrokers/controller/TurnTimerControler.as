/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.controller {
    import com.bytesfromouterspace.stockbrokers.model.TurnTimerModel;

    public class TurnTimerControler {

        private var _model:TurnTimerModel;

        public function TurnTimerControler(model:TurnTimerModel) {
            this._model = model;
        }

        public function start():void {

        }

        public function appendTime(value:Number):void {
            _model.currentTime += value;
        }
    }
}
