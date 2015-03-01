/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {
    import com.bytesfromouterspace.stockbrokers.event.ReputationEvent;

    public class MarketModel extends BaseModel{

        public static const MAX_STOCK_SHARES:int = 10;

        private static const _stockShareNames:Array = [
            "Firkin Bee", "ACME Inc", "Electric Industries", "Bank Horizon", "Cell Interactive",
            "Phone Foundation", "Oil Topia", "Market Venture", "Investment Synergy", "Rotten Foods"
        ];

        public var stockShares:Vector.<StockShareModel>;
        public var funds:FundsModel;

        public function MarketModel() {
            super();
            stockShares = new Vector.<StockShareModel>(MAX_STOCK_SHARES, true);
            funds = new FundsModel();
            initShares();
        }

        private function initShares():void {
            for(var i:int = 0; i < MAX_STOCK_SHARES; i++) {
                stockShares[i] = new StockShareModel(i, _stockShareNames[i]);
            }
        }


        public function getStockShareModel(stockId:int):StockShareModel {
            return stockShares[stockId];
        }

        public function signalReputation(repType:uint, repAmount:int = 0):void {
            dispatchEvent(new ReputationEvent(repType, repAmount));
        }
    }
}
