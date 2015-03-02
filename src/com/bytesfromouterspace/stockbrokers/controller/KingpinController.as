/**
 * Created by Akira on 02/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.controller {

    import com.bytesfromouterspace.stockbrokers.model.KingpinModel;

    public class KingpinController {

        private var model:KingpinModel;

        public function KingpinController(model:KingpinModel) {
            this.model = model;
        }

        public function onLevelChanged(level:int):void {
            model.enabled = (model.minLevel > level) ? false : true;
        }

        public function acceptLoan():void {
            model.accepted = true;
        }

        public function payLoan():void {
            model.accepted = false;
        }
    }
}
