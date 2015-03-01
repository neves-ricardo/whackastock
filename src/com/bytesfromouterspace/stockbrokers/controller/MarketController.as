/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.controller {
    import com.bytesfromouterspace.stockbrokers.event.TransactionEvent;
    import com.bytesfromouterspace.stockbrokers.model.MarketModel;
    import com.bytesfromouterspace.stockbrokers.model.ReputationModel;
    import com.bytesfromouterspace.stockbrokers.model.StockShareModel;

    public class MarketController {

        private var _model:MarketModel;

        public var stockControllers:Vector.<StockShareController>;

        public function MarketController(model:MarketModel) {
            this._model = model;
            stockControllers = new Vector.<StockShareController>(model.stockShares.length, true);
            for(var i:int = 0; i < stockControllers.length; i++) {
                stockControllers[i] = new StockShareController(model.stockShares[i]);
                model.stockShares[i].addEventListener(TransactionEvent.TRANSACTION_EVENT, onTransaction);
            }
        }

        private function onTransaction(event:TransactionEvent):void {
            var funds:Number = _model.funds.available;
            var stock:StockShareModel = _model.getStockShareModel(event.stockId);

            var transactionValue:Number;
            if(event.transactionType == TransactionEvent.TRANSACTION_TYPE_BUY) {
                trace("Transaction BUY: ", event.stockId, event.amount, stock.quantityAvailable, funds);
                transactionValue = event.amount * stock.value;
                if(event.amount <= stock.quantityAvailable) {
                    if(transactionValue < funds) {
                        stock.doBuy(event.amount);
                        _model.funds.withdraw(transactionValue);
                        _model.signalReputation(ReputationModel.REP_TYPE_SUCCESSFUL_BUY, transactionValue);
                    } else {
                        _model.signalReputation(ReputationModel.REP_TYPE_FRAUD_INSUFFICIENT_FUNDS, transactionValue);
                    }
                } else {
                    _model.signalReputation(ReputationModel.REP_TYPE_FRAUD_QUANTITY_BUY, event.amount);
                }
            } else if(event.transactionType == TransactionEvent.TRANSACTION_TYPE_SELL) {
                trace("Transaction Sell: ", event.stockId, event.amount, stock.quantityOwned);
                if(event.amount <= stock.quantityOwned) {
                    stock.doSell(event.amount);
                    _model.funds.add(event.amount * stock.value);
                    _model.signalReputation(ReputationModel.REP_TYPE_SUCCESSFUL_SELL, event.amount);
                } else {
                    _model.signalReputation(ReputationModel.REP_TYPE_FRAUD_QUANTITY_SELL, event.amount);
                }
            }
        }
    }
}
