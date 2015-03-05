/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {
    import com.bytesfromouterspace.stockbrokers.controller.StockShareController;
    import com.bytesfromouterspace.stockbrokers.event.StockShareEvent;
    import com.bytesfromouterspace.stockbrokers.model.IHistoryModel;
    import com.bytesfromouterspace.stockbrokers.model.StockShareModel;
    import com.bytesfromouterspace.stockbrokers.ui.MarketTendencyShape;
    import com.bytesfromouterspace.stockbrokers.ui.components.GraphButton;
    import com.bytesfromouterspace.stockbrokers.ui.components.GraphButton;
    import com.bytesfromouterspace.stockbrokers.ui.components.Button;
    import com.bytesfromouterspace.stockbrokers.ui.components.ComponentBase;
    import com.bytesfromouterspace.stockbrokers.ui.components.Label;
    import com.bytesfromouterspace.stockbrokers.ui.themes.StyleGroup;

    import flash.display.Bitmap;
    import flash.display.Shape;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import flash.events.MouseEvent;

    public class StockShareView extends ComponentBase {

        private var _model:StockShareModel;

        protected var _styles:StyleGroup;
        protected var _label:Bitmap;
        protected var _graphButton:GraphButton;
        protected var _lblQtdAvailable:Label;
        private var _lblPriceMarket:Label;
        private var _lblQtdOwned:Label;
        private var _lblPriceOwned:Label;
        private var tendency:MarketTendencyShape;
        private var _lblTendency:Label;
        private var _btnBuy10:Button;
        private var _btnBuy100:Button;
        private var _btnBuy1000:Button;
        private var _btnSell10:Button;
        private var _btnSell100:Button;
        private var _btnSell1000:Button;

        private var _enabled:Boolean;
        private var _controller:StockShareController;
        private var _lockedShape:Shape;
        private var _lockedLabel:Bitmap;
        public var animate:Boolean;

        public function StockShareView(stockModel:StockShareModel, stockController:StockShareController) {
            super(160, 152);
            this._model = stockModel;
            this._controller = stockController;
            _styles = theme.getStyleGroup("stockView");
            drawBackground();
            buildUI();
            _model.addEventListener(StockShareEvent.STOCK_SHARE_CHANGED, onStockShareChange);
            _model.refresh();
            animate = false;
        }

        public function get model():IHistoryModel {
            return _model;
        }

        private function onStockShareChange(event:StockShareEvent):void {
            _lblQtdAvailable.text = _model.quantityAvailable.toString();
            _lblPriceMarket.text = _model.currentValue.toFixed(2);
            _lblQtdOwned.text = _model.quantityOwned.toString();
            _lblPriceOwned.text = _model.ownedValue.toFixed(2);
            if(_model.delta > 0) {
                tendency.tendency = MarketTendencyShape.TENDENCY_UP;
                _lblTendency.text = "+" + _model.delta.toFixed(2) + "%";
            } else if(_model.delta < 0) {
                tendency.tendency = MarketTendencyShape.TENDENCY_DOWN;
                _lblTendency.text = _model.delta.toFixed(2) + "%";
            } else {
                tendency.tendency = MarketTendencyShape.TENDENCY_EQUAL;
                _lblTendency.text = "----";
            }
            enabled = !_model.locked;

            if((_model.quantityOwned > 0) && (_model.currentValue > _model.ownedValue)) {
                animate = true;
            } else {
                animate = false;
            }
        }

        public function set blinkOwned(blinkState:Boolean):void {
            if(blinkState) {
                _lblPriceOwned.background.backgroundColor = 0xFFCC00;
            } else {
                _lblPriceOwned.background.backgroundColor = 0xFFFF93;
            }
        }

        public function get enabled():Boolean {
            return _enabled;
        }

        public function set enabled(value:Boolean):void {
            _enabled = value;
            if(value) {
                _btnBuy10.enabled = true;
                _btnBuy100.enabled = true;
                _btnBuy1000.enabled = true;
                _btnSell10.enabled = true;
                _btnSell100.enabled = true;
                _btnSell1000.enabled = true;
                _lockedShape.visible = false;
                _lockedLabel.visible = false;
            } else {
                _btnBuy10.enabled = false;
                _btnBuy100.enabled = false;
                _btnBuy1000.enabled = false;
                _btnSell10.enabled = false;
                _btnSell100.enabled = false;
                _btnSell1000.enabled = false;
                _lockedShape.visible = true;
                _lockedLabel.visible = true;
            }
        }

        public function gameEnd():void {
            _btnBuy10.enabled = false;
            _btnBuy100.enabled = false;
            _btnBuy1000.enabled = false;
            _btnSell10.enabled = false;
            _btnSell100.enabled = false;
            _btnSell1000.enabled = false;
        }

        private function drawBackground():void {
            graphics.clear();

            // background
            graphics.lineStyle(1, _styles.getStyle("borderColor", 0x41C6F3), 1);
            graphics.beginFill(_styles.getStyle("backgroundColor",0x017EC1), _styles.getStyle("backgroundAlpha", 1));
            graphics.drawRect(0,0,_width,_height);
            graphics.endFill();

            // title
            graphics.lineStyle();
            graphics.beginFill(_styles.getStyle("titleBackgroundColor",0), _styles.getStyle("titleBackgroundAlpha", 0));
            graphics.drawRect(1,1,_width-2,20);
            graphics.endFill();

            // Content zones
            graphics.lineStyle();
            graphics.beginFill(0x79BBDE, 1);

            // Qtd
            graphics.drawRect(6,26, 56, 36);
            graphics.drawRect(62,26,_width-66,16);
            graphics.drawRect(62,46,_width-66,16);

            graphics.drawRect(6,90, 56, 36);
            graphics.drawRect(62,90,_width-66,16);
            graphics.drawRect(62,110,_width-66,16);
            graphics.endFill();

        }

        private function buildUI():void {

            _label = theme.createBitmapLabel(_model.name, 9, _styles.getStyle("titleColor", 0xFFFFFF));
            _label.x = 4;
            _label.y = 4;
            addChild(_label);


            _graphButton = new GraphButton();
            _graphButton.x = _width - 24;
            _graphButton.y = 2;
            addChild(_graphButton);
            _graphButton.addEventListener(MouseEvent.CLICK, onRequestFocus);

            var lblAux:Bitmap = theme.createBitmapLabel("Market", 10, 0x00661A, "type_writer");
            lblAux.x = 12;
            lblAux.y = 32;
            addChild(lblAux);

            tendency = new MarketTendencyShape();
            tendency.x = 14;
            tendency.y = 48;
            addChild(tendency);
            tendency.tendency = MarketTendencyShape.TENDENCY_DOWN;

            _lblTendency = new Label(40, 20, "----", 11, 0, "visitor1");
            _lblTendency.x = 24;
            _lblTendency.y = 44;
            addChild(_lblTendency);

            lblAux = theme.createBitmapLabel("QUANTITY:", 8, 0x00661A);
            lblAux.x = 66;
            lblAux.y = 28;
            addChild(lblAux);

            lblAux = theme.createBitmapLabel("PRICE", 8, 0x00661A);
            lblAux.x = 84;
            lblAux.y = 48;
            addChild(lblAux);

            _lblQtdAvailable = new Label(34, 12, "----", 12, 0, "visitor1");
            _lblQtdAvailable.background.backgroundColor = 0xBFFFCF;
            _lblQtdAvailable.x = 120;
            _lblQtdAvailable.y = 28;
            addChild(_lblQtdAvailable);

            _lblPriceMarket = new Label(34, 12, "----", 12, 0, "visitor1");
            _lblPriceMarket.background.backgroundColor = 0xBFFFCF;
            _lblPriceMarket.x = 120;
            _lblPriceMarket.y = 48;
            addChild(_lblPriceMarket);

            lblAux = theme.createBitmapLabel("BUY", 10, 0xFFFFFF);
            lblAux.x = 20;
            lblAux.y = 66;
            addChild(lblAux);

            _btnBuy10 = createButton("10");
            _btnBuy10.x = 56;
            _btnBuy10.y = 66;
            _btnBuy10.addEventListener(MouseEvent.CLICK, onBuyAction);
            addChild(_btnBuy10);

            _btnBuy100 = createButton("100");
            _btnBuy100.x = 90;
            _btnBuy100.y = 66;
            _btnBuy100.addEventListener(MouseEvent.CLICK, onBuyAction);
            addChild(_btnBuy100);

            _btnBuy1000 = createButton("1000");
            _btnBuy1000.x = 124;
            _btnBuy1000.y = 66;
            _btnBuy1000.addEventListener(MouseEvent.CLICK, onBuyAction);
            addChild(_btnBuy1000);

            //Sell
            lblAux = theme.createBitmapLabel("Owned", 10, 0x8C6900, "type_writer");
            lblAux.x = 12;
            lblAux.y = 100;
            addChild(lblAux);

            lblAux = theme.createBitmapLabel("QUANTITY:", 8, 0x8C6900);
            lblAux.x = 66;
            lblAux.y = 92;
            addChild(lblAux);

            lblAux = theme.createBitmapLabel("PRICE", 8, 0x8C6900);
            lblAux.x = 84;
            lblAux.y = 112;
            addChild(lblAux);

            _lblQtdOwned = new Label(34, 12, "----", 12, 0, "visitor1");
            _lblQtdOwned.background.backgroundColor = 0xFFFF93;
            _lblQtdOwned.x = 120;
            _lblQtdOwned.y = 92;
            addChild(_lblQtdOwned);

            _lblPriceOwned = new Label(34, 12, "----", 12, 0, "visitor1");
            _lblPriceOwned.background.backgroundColor = 0xFFFF93;
            _lblPriceOwned.x = 120;
            _lblPriceOwned.y = 112;
            addChild(_lblPriceOwned);

            _btnSell10 = createButton("10", false);
            _btnSell10.x = 56;
            _btnSell10.y = 130;
            _btnSell10.addEventListener(MouseEvent.CLICK, onSellAction);
            addChild(_btnSell10);

            _btnSell100 = createButton("100", false);
            _btnSell100.x = 90;
            _btnSell100.y = 130;
            _btnSell100.addEventListener(MouseEvent.CLICK, onSellAction);
            addChild(_btnSell100);

            _btnSell1000 = createButton("1000", false);
            _btnSell1000.x = 124;
            _btnSell1000.y = 130;
            _btnSell1000.addEventListener(MouseEvent.CLICK, onSellAction);
            addChild(_btnSell1000);

            lblAux = theme.createBitmapLabel("SELL", 10, 0xFFFFFF);
            lblAux.x = 15;
            lblAux.y = 131;
            addChild(lblAux);

            _lockedShape = new Shape();
            _lockedShape.graphics.lineStyle(1, 0xFFCC00, 1);
            _lockedShape.graphics.beginFill(0x212121, 0.4);
            _lockedShape.graphics.drawRect(0,0,_width, 20);
            _lockedShape.graphics.endFill();
            _lockedShape.graphics.beginFill(0x212121, 0.9);
            _lockedShape.graphics.drawRect(0,20,_width,_height-20);
            _lockedShape.graphics.endFill();
            addChild(_lockedShape);
            _lockedShape.visible = false;

            _lockedLabel = theme.createBitmapLabel("Locked by\n\nMarket\n\nRegulator", 15, 0xFFFFFF, "visitor2");
            _lockedLabel.x = _width * 0.5 - _lockedLabel.width * 0.5;
            _lockedLabel.y = _height * 0.5 - _lockedLabel.height * 0.5;
            addChild(_lockedLabel);
            _lockedLabel.visible = false;

        }

        private function onRequestFocus(event:MouseEvent):void {
            dispatchEvent(new FocusEvent(FocusEvent.FOCUS_IN, true, true));
        }

        private function onSellAction(event:MouseEvent):void {
            var btn:Button = event.target as Button;
            var quantity:int = 0;
            switch(btn) {
                case _btnSell10:
                    quantity = 10;
                    break;
                case _btnSell100:
                    quantity = 100;
                    break;
                case _btnSell1000:
                    quantity = 1000;
                    break;
            }
            _controller.sellToMarket(quantity);
        }

        private function onBuyAction(event:MouseEvent):void {
            var btn:Button = event.target as Button;
            var quantity:int = 0;
            switch(btn) {
                case _btnBuy10:
                    quantity = 10;
                    break;
                case _btnBuy100:
                    quantity = 100;
                    break;
                case _btnBuy1000:
                    quantity = 1000;
                    break;
            }
            _controller.buyFromMarket(quantity);
        }

        private function createButton(text:String, isBuy:Boolean = true):Button {
            var btn:Button = new Button(30,15);
            btn.buttonBorderNormal = 0xFFFFFF;
            btn.buttonBackgroundNormal = isBuy ? 0x00B200 : 0xD9A300;
            btn.drawBackground();
            btn.setLabel(text, 10, 0xFFFFFF, "visitor1");
            return btn;
        }

    }
}
