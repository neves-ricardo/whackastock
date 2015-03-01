/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {
    import com.bytesfromouterspace.stockbrokers.controller.MarketController;
    import com.bytesfromouterspace.stockbrokers.model.MarketModel;
    import com.bytesfromouterspace.stockbrokers.ui.components.ComponentBase;

    public class MarketView extends ComponentBase {

        private var _model:MarketModel;
        private var _controller:MarketController;
        private var _stockViews:Vector.<StockShareView>;

        public function MarketView(model:MarketModel, controller:MarketController) {
            super(821, 310);
            _model = model;
            _controller = controller;
            _stockViews = new Vector.<StockShareView>(model.stockShares.length, true);
            var positionX:Number = 0;
            var positionY:Number = 0;
            var gap:Number = 4;
            var stockView:StockShareView;
            for(var i:int = 0; i < _stockViews.length; i++) {
                stockView = new StockShareView(model.stockShares[i], controller.stockControllers[i]);
                stockView.x = positionX;
                stockView.y = positionY;
                _stockViews[i] = stockView;
                positionX += gap + stockView.width;
                addChild(stockView);
                if(i == 4) {
                    positionX = 0;
                    positionY = stockView.height + gap;
                }
            }
        }
    }
}
