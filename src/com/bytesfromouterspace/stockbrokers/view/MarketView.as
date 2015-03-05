/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {
    import com.bytesfromouterspace.stockbrokers.controller.MarketController;
    import com.bytesfromouterspace.stockbrokers.model.MarketModel;
    import com.bytesfromouterspace.stockbrokers.ui.components.ComponentBase;

    import flash.events.Event;

    public class MarketView extends ComponentBase {

        private var _model:MarketModel;
        private var _controller:MarketController;
        private var _stockViews:Vector.<StockShareView>;
        private var _animateCount:int = 8;

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
                if((i == 4) || (i == 9)) {
                    positionX = 0;
                    positionY += stockView.height + gap;
                    _stockViews[i].x += 1; // gap adjust
                }
            }
            destroyHandler = onDestroy;
            addEventListener(Event.ENTER_FRAME, onCheckAnimations);
        }

        private function onDestroy():void {
            if(hasEventListener(Event.ENTER_FRAME)) {
                removeEventListener(Event.ENTER_FRAME, onCheckAnimations);
            }
            removeChildren();
            for(var i:int = 0; i < _stockViews.length; i++) {
                _stockViews[i] = null;
            }
            _stockViews = null;
        }

        private function onCheckAnimations(event:Event):void {
            var blinkEnabled:Boolean = false;
            if(_animateCount > 4) {
                blinkEnabled = true;
            } else if(_animateCount > 0) {
                blinkEnabled = false;
            } else if(_animateCount <= 0) {
                _animateCount = 9;
            }
            _animateCount--;
            for(var i:int = 0; i < _stockViews.length; i++) {
                if(_stockViews[i].animate) {
                    _stockViews[i].blinkOwned = blinkEnabled; //.doAnimation();
                }
            }
        }

        public function gameEnd():void {
            for(var i:int = 0; i < _stockViews.length; i++) {
                _stockViews[i].gameEnd();
            }
        }
    }
}
