/**
 * Created by Akira on 02/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {

    import com.bytesfromouterspace.stockbrokers.model.IHistoryModel;
    import com.bytesfromouterspace.stockbrokers.ui.components.GraphButton;
    import com.bytesfromouterspace.stockbrokers.ui.components.BorderBackground;
    import com.bytesfromouterspace.stockbrokers.ui.components.ComponentBase;

    import flash.display.Bitmap;
    import flash.display.Shape;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import flash.events.MouseEvent;

    public class MarketHistoryView extends ComponentBase {

        private var _label:Bitmap;
        private var _graphBtn:GraphButton;
        private var _background:BorderBackground;
        private var graphBackground:Shape;
        private var plotArea:Shape;
        private var model:IHistoryModel;

        public function MarketHistoryView(model:IHistoryModel) {
            super(467, 180);

            this.model = model;
            model.focus = true;
            _background = new BorderBackground(467, 180);
            _background.backgroundColor = 0x017EC1;
            _background.borderColor = 0x41C6F3;
            addChild(_background);

            _label = theme.createBitmapLabel(model.name + " History", 12, 0xFFFFFF );
            _label.x = 4;
            _label.y = 4;
            addChild(_label);

            _graphBtn = new GraphButton();
            _graphBtn.x = _width - 24;
            _graphBtn.y = 3;
            addChild(_graphBtn);
            _graphBtn.addEventListener(MouseEvent.CLICK, onRequestFocus);

            graphBackground = new Shape();
            graphBackground.graphics.beginFill(0x333333);
            graphBackground.graphics.drawRect(0,0, 430, 140);
            graphBackground.graphics.endFill();
            graphBackground.graphics.lineStyle(1, 0xFFFFFF, 1);
            graphBackground.graphics.moveTo(6, 6);
            graphBackground.graphics.lineTo(6, 132);
            graphBackground.graphics.lineTo(418, 132);

            graphBackground.y = 30;
            graphBackground.x = 18;

            addChild(graphBackground);

            plotArea = new Shape();
            plotArea.graphics.beginFill(0x212121, 0);
            plotArea.graphics.drawRect(0, 0, 414, 128);
            plotArea.graphics.endFill();
            plotArea.x = 25;
            plotArea.y = 34;
            addChild(plotArea);

            model.addEventListener(Event.CHANGE, onHistoryChanged);

        }

        private function onRequestFocus(event:MouseEvent):void {
            dispatchEvent(new FocusEvent(FocusEvent.FOCUS_IN, true, true));
        }

        private function onHistoryChanged(event:Event):void {
            //414, 128
            plotArea.graphics.clear();

            var min:Number = Number.MAX_VALUE;
            var max:Number = Number.MIN_VALUE;
            var total:Number = 0;
            var data:Vector.<Number> = model.history;
            var i;
            var len:int = data.length;
            for(i=0; i < len; i++) {
                total += data[i];
                if(data[i] > max) {
                    max = data[i];
                }
                if(data[i] < min) {
                    min = data[i];
                }
            }
            var avg:Number = total / len;

            var py;
            var step:int = 0;
            plotArea.graphics.lineStyle(1, 0x0000FF);
            py = 128 * (data[0] / max);
            plotArea.graphics.moveTo(414,py); //414, 64);
            plotArea.graphics.lineTo(0, py);
            plotArea.graphics.lineStyle(1, 0xFFCC00);
            var aux:Number;
            for (i = 0; i < len; i++) {
                if(step < 414) {
                    aux = data[i] / max;
                    py = 128 - 128 * (aux);
                    plotArea.graphics.lineTo(step, py);
                    //trace(step, py, aux, data[i]);
                    step += 4;
                }
            }

        }

        public function set historyModel(historyModel:IHistoryModel):void {
            model.focus = false;
            if(model.hasEventListener(Event.CHANGE)) {
                model.removeEventListener(Event.CHANGE, onHistoryChanged);
            }
            model = historyModel;
            model.addEventListener(Event.CHANGE, onHistoryChanged);
            removeChild(_label);
            _label.bitmapData.dispose();
            _label = theme.createBitmapLabel(model.name + " History", 12, 0xFFFFFF );
            _label.x = 4;
            _label.y = 4;
            addChild(_label);
            model.focus = true;
            onHistoryChanged(null);
        }

        public function get historyModel():IHistoryModel {
            return model;
        }
    }
}
