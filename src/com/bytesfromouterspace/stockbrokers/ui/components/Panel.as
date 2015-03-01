/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.ui.components {
    import flash.display.Bitmap;

    public class Panel extends BackgroundContainer {

        private var _title:String;
        protected var label:Bitmap;

        public function Panel(_width:Number, _height:Number) {
            super(_width, _height);
        }


        override protected function drawContainer():void {
            paddingTop = 30;
            super.drawContainer();
        }

        public function get title():String {
            return _title;
        }

        public function set title(value:String):void {
            label = theme.createBitmapLabel(value, 14, 0xFFCC00);
            label.x = paddingLeft;
            label.y = 10;
            trace("Label:", label, label.width);
            addChild(label);
            _title = value;
        }
    }
}
