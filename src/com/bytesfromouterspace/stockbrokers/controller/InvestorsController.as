/**
 * Created by Akira on 02/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.controller {
    import com.bytesfromouterspace.stockbrokers.event.ReputationStatusEvent;
    import com.bytesfromouterspace.stockbrokers.model.InvestorsModel;

    public class InvestorsController {

        private var model:InvestorsModel;
        public var kingpinControllers:Vector.<KingpinController>;

        public function InvestorsController(model:InvestorsModel) {
            this.model = model;
            kingpinControllers = new Vector.<KingpinController>(model.kingpins.length, true);
            for(var i:int = 0; i < kingpinControllers.length; i++) {
                kingpinControllers[i] = new KingpinController(model.kingpins[i]);
            }
        }

        public function handleLevelChange(event:ReputationStatusEvent):void {
            for(var i:int = 0; i < kingpinControllers.length; i++) {
                kingpinControllers[i].onLevelChanged(event.level);
            }
        }
    }
}
