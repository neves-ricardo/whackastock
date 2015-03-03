/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.controller {
    import com.bytesfromouterspace.stockbrokers.event.InvestorsEvent;
    import com.bytesfromouterspace.stockbrokers.event.SoundRandomGeneratorEvent;
    import com.bytesfromouterspace.stockbrokers.event.TransactionEvent;
    import com.bytesfromouterspace.stockbrokers.model.MarketModel;
    import com.bytesfromouterspace.stockbrokers.model.ReputationModel;
    import com.bytesfromouterspace.stockbrokers.model.StockShareModel;
    import com.bytesfromouterspace.stockbrokers.ui.StringUtils;

    public class MarketController {

        private var _model:MarketModel;
        public var logger:TransactionLogController;
        public var stockControllers:Vector.<StockShareController>;

        public function MarketController(model:MarketModel) {
            this._model = model;
            logger = new TransactionLogController(_model.logger);
            _model.generator.addEventListener(SoundRandomGeneratorEvent.CHANGE, onGeneratorChanged);
            stockControllers = new Vector.<StockShareController>(model.stockShares.length, true);
            for(var i:int = 0; i < stockControllers.length; i++) {
                stockControllers[i] = new StockShareController(model.stockShares[i]);
                model.stockShares[i].addEventListener(TransactionEvent.TRANSACTION_EVENT, onTransaction);
            }
        }

        private function onGeneratorChanged(event:SoundRandomGeneratorEvent):void {
            for(var i:int = 0; i < stockControllers.length; i++) {
                stockControllers[i].influence(event.number);
            }
            _model.addToHistory(_model.marketValue);
        }

        private function onTransaction(event:TransactionEvent):void {
            var funds:Number = _model.funds.available;
            var stock:StockShareModel = _model.getStockShareModel(event.stockId);
            var bonusValue:Number;
            var transactionValue:Number;
            if(event.transactionType == TransactionEvent.TRANSACTION_TYPE_BUY) {
                trace("Transaction BUY: ", event.stockId, event.amount, stock.quantityAvailable, funds);
                transactionValue = event.amount * stock.currentValue;
                if(event.amount <= stock.quantityAvailable) {
                    if(transactionValue < funds) {
                        stock.doBuy(event.amount);
                        _model.funds.withdraw(transactionValue);
                        logger.log("Bought", event.amount, "of", stock.name, "at",
                                StringUtils.formatCurrency(stock.currentValue),
                                " total:", StringUtils.formatCurrency(transactionValue));
                        bonusValue = (stock.currentValue < stock.startingValue)  ? 20 : 0;
                        _model.signalReputation(ReputationModel.REP_TYPE_SUCCESSFUL_BUY, bonusValue);
                        SoundController.instance.playCash();
                    } else {
                        _model.signalReputation(ReputationModel.REP_TYPE_FRAUD_INSUFFICIENT_FUNDS);
                        SoundController.instance.playFail();
                    }
                } else {
                    _model.signalReputation(ReputationModel.REP_TYPE_FRAUD_QUANTITY_BUY);
                    if(transactionValue > funds) {
                        _model.signalReputation(ReputationModel.REP_TYPE_FRAUD_INSUFFICIENT_FUNDS);
                    }
                    SoundController.instance.playFail();
                }
            } else if(event.transactionType == TransactionEvent.TRANSACTION_TYPE_SELL) {
                trace("Transaction Sell: ", event.stockId, event.amount, stock.quantityOwned);
                if(event.amount <= stock.quantityOwned) {
                    stock.doSell(event.amount);
                    _model.funds.add(event.amount * stock.currentValue);
                    logger.log("Sold", event.amount, "of", stock.name, "at",
                            StringUtils.formatCurrency(stock.currentValue),
                            " total:", StringUtils.formatCurrency(event.amount * stock.currentValue));
                    bonusValue = (stock.currentValue < stock.ownedValue) ? -40 : 0;
                    if(stock.currentValue < stock.ownedValue) {
                        bonusValue = -40; // loosing money
                    } else if(stock.currentValue > stock.ownedValue) {
                        bonusValue = 40;
                    } else {
                        bonusValue = 0;
                    }
                    _model.signalReputation(ReputationModel.REP_TYPE_SUCCESSFUL_SELL, bonusValue);
                    SoundController.instance.playCash();
                } else {
                    _model.signalReputation(ReputationModel.REP_TYPE_FRAUD_QUANTITY_SELL);
                    SoundController.instance.playFail();
                }
            }
        }

        public function onLoanAccepted(event:InvestorsEvent):void {
            SoundController.instance.playCash();
            _model.funds.add(event.loan.amount);
        }

        public function onLoanPay(event:InvestorsEvent):void {
            _model.payLoan(event.loan);
        }

        public function payLoanedInterestRates(loanedInterestRates:Number):Boolean {
            return _model.payRates(loanedInterestRates);
        }

        public function payTurnTax():Boolean {
            return _model.payTurnTax(1000);
        }
    }
}
