/**
 * Created by Akira on 03/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.controller {
    import com.bytesfromouterspace.stockbrokers.model.TransactionLogModel;

    public class TransactionLogController {

        private var _model:TransactionLogModel;

        public function TransactionLogController(model:TransactionLogModel) {
            this._model = model;
        }

        public function log(...what):void {
            _model.log(what.join(" "));
        }
    }
}
