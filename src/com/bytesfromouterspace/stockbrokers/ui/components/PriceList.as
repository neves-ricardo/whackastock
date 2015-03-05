/**
 * Created by Akira on 04/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.ui.components {
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;

    public class PriceList extends ComponentBase {
        private var txtLabels:TextField;
        private var txtPrices:TextField;
        public function PriceList(_w:Number, _h:Number, splitter:Number = 0.5) {
            super(_w, _h);
            txtLabels = new TextField();
            txtLabels.width = int(_w * splitter);
            txtLabels.height = 400;
            txtLabels.wordWrap = false;
            txtLabels.autoSize = "left";
            txtLabels.embedFonts = true;
            var tfm:TextFormat = theme.getDefaultTextFormat();
            tfm.font = theme.getFont("visitor1");
            tfm.size = 12;
            tfm.leading = 8;
            txtLabels.defaultTextFormat = tfm;
            addChild(txtLabels);
            txtPrices = new TextField();
            txtPrices.x = int(_w * splitter);
            txtPrices.width = int(_w * (1 - splitter));
            txtPrices.height = 400;
            txtPrices.wordWrap = true;
            txtPrices.autoSize = TextFieldAutoSize.RIGHT;
            txtPrices.embedFonts = true;
            tfm.align = TextFormatAlign.RIGHT;
            tfm.leading = 8;
            txtPrices.defaultTextFormat = tfm;
            addChild(txtPrices);
        }

        public function appendTexts(label:String, price:String = ""):void {
            txtLabels.appendText(label + "\n");
            txtPrices.appendText(price + "\n");
        }
    }
}
