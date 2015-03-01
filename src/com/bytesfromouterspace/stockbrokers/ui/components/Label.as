/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.ui.components {
    import flash.text.TextField;
    import flash.text.TextFormat;

    public class Label extends ComponentBase {

        protected var _txt:TextField;
        private var _background:BorderBackground;

        public function Label(_width:Number, _height:Number, text:String, fontSize:Number, fontColor:uint, fontName:String = "default", align:String = "center") {
            super(_width, _height);
            _background = new BorderBackground(_width, _height);
            addChild(_background);
            _txt = new TextField();
            _txt.width = _width;
            _txt.height = _height;
            _txt.embedFonts = true;
            _txt.selectable = false;
            var tfm:TextFormat = theme.getDefaultTextFormat();
            tfm.font = theme.getFont(fontName);
            tfm.size = fontSize;
            tfm.color = fontColor;
            tfm.align = align;
            _txt.defaultTextFormat = tfm;
            this.text = text;
            _txt.y = _height * 0.5 - _txt.textHeight * 0.5 - 3;
            addChild(_txt);
        }

        public function get text():String {
            return _txt.text;
        }

        public function set text(value:String):void {
            _txt.text = value;
        }

        public function get background():BorderBackground {
            return _background;
        }

        public function set background(value:BorderBackground):void {
            _background = value;
        }
    }
}
