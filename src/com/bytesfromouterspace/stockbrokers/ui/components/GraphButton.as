/**
 * Created by Akira on 02/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.ui.components {
    import flash.display.Shape;

    public class GraphButton extends Button {

        public function GraphButton() {
            super(20, 15);
            buttonBackgroundNormal = 0x666666;
            buttonBorderNormal = 0x212121;
            var icon:Shape = new Shape();
            icon.graphics.lineStyle();
            icon.graphics.beginFill(0xFFFFFF);

            icon.graphics.drawRect(4, 3, 2, 10);
            icon.graphics.drawRect(7, 9, 2, 4);
            icon.graphics.drawRect(10, 7, 2, 6);
            icon.graphics.drawRect(13, 5, 2, 8);
            icon.graphics.drawRect(16, 9, 2, 4);
            icon.graphics.endFill();
            addChild(icon);
            drawBackground();
        }


    }
}
