/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {

    import com.bytesfromouterspace.stockbrokers.event.ReputationEvent;

    import flash.events.Event;

    public class MarketModel extends BaseModel implements IHistoryModel {

        public static const MAX_STOCK_SHARES:int = 10;
        private var _history:Vector.<Number>;

        private static const _stockShareNames:Array = [
            "Firkin Bee", "ACME Inc", "Electric Industries", "Bank Horizon", "Cell Interactive",
            "Phone Foundation", "OilTopia", "Market Venture", "Investment Synergy", "Rotten Foods"
        ];

        public var stockShares:Vector.<StockShareModel>;
        public var funds:FundsModel;
        public var generator:SoundRandomGeneratorModel;
        private var _focus:Boolean;
        public var generatorInfluenceRatio:Number;
        public var transactionInfluenceRatio:Number;
        public var startingCash:int;

        public function MarketModel(generator:SoundRandomGeneratorModel) {
            super();
            this.generator = generator;
            stockShares = new Vector.<StockShareModel>(MAX_STOCK_SHARES, true);
            _history = new Vector.<Number>();
            //initialize();
        }

        public function initialize():void {
            funds = new FundsModel(startingCash);
            var rand:Number;
            var totalRand:Number = 0;
            for(var i:int = 0; i < MAX_STOCK_SHARES; i++) {
                rand = Math.random();
                stockShares[i] = new StockShareModel(i, _stockShareNames[i], rand, generatorInfluenceRatio, transactionInfluenceRatio);
                totalRand += rand;
            }
            _history.push(marketValue);
        }


        public function getStockShareModel(stockId:int):StockShareModel {
            return stockShares[stockId];
        }

        public function signalReputation(repType:uint, repAmount:int = 0):void {
            dispatchEvent(new ReputationEvent(repType, repAmount));
        }

        public function payLoan(loan:KingpinModel):void {
            if(funds.validatedWithdraw(loan.amount + loan.interestRateValue)) {
                loan.accepted = false;
            } else {
                signalReputation(ReputationModel.REP_TYPE_FRAUD_INSUFFICIENT_FUNDS);
            }
        }

        public function payRates(loanedInterestRates:Number):Boolean {
            if(funds.validatedWithdraw(loanedInterestRates)) {
                return true;
            }
            signalReputation(ReputationModel.REP_TYPE_FRAUD_INSUFFICIENT_FUNDS);
            return false;
        }

        public function get history():Vector.<Number> {
            return _history;
        }

        public function dispatchHistoryChange():void {
            if(_focus) {
                dispatchEvent(new Event(Event.CHANGE));
            }
        }

        public function set focus(value:Boolean):void {
            _focus = value;
        }

        public function get name():String {
            return "Market";
        }

        public function addToHistory(value:Number):void {
            _history.push(value);
            dispatchHistoryChange();
        }

        public function get marketValue():Number {
            var _marketValue:Number = 0;
            for(var i:int = 0; i < stockShares.length; i++) {
                _marketValue += stockShares[i].marketValue;
            }
            return _marketValue;
        }
    }
}
