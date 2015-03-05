/**
 * Created by Akira on 02/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {
    import com.bytesfromouterspace.stockbrokers.controller.InvestorsController;
    import com.bytesfromouterspace.stockbrokers.model.InvestorsModel;
    import com.bytesfromouterspace.stockbrokers.ui.components.BorderBackground;
    import com.bytesfromouterspace.stockbrokers.ui.components.ComponentBase;

    import flash.display.Bitmap;
    import flash.display.DisplayObject;

    public class InvestorsView extends ComponentBase {

        private var _background:BorderBackground;

        public function InvestorsView(model:InvestorsModel, controller:InvestorsController) {
            super(350, 180);
            _background = new BorderBackground(350, 180);
            _background.backgroundColor = 0x017EC1;
            _background.borderColor = 0x41C6F3;
            addChild(_background);

            var lbl:Bitmap = theme.createBitmapLabel("Investors", 12, 0xFFFFFF );
            lbl.x = 4;
            lbl.y = 4;
            addChild(lbl);

            var positionX:Number = 8;
            var positionY:Number = 30;
            var gap:Number = 4;
            var kingpinView:KingpinView;

            for(var i:int = 0; i < model.kingpins.length; i++) {
                kingpinView = new KingpinView(model.kingpins[i], controller.kingpinControllers[i]);
                kingpinView.x = positionX;
                kingpinView.y = positionY;
                addChild(kingpinView);
                positionY += kingpinView.height + gap;
            }

        }

        public function gameEnd():void {
            var dso:DisplayObject;
            for(var i:int = 0; i < numChildren; i++) {
                dso = getChildAt(i);
                if(dso && (dso is KingpinView)) {
                    (dso as KingpinView).gameEnd();
                }
            }
        }
    }
}
