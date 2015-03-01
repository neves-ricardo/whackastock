/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.ui.components {

    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.geom.Rectangle;

    public class GroupContainer extends Sprite{

        protected var _width:Number;
        protected var _height:Number;

        public function GroupContainer(_width:Number, _height:Number) {
            super();
            this._width = _width;
            this._height = _height;
            graphics.beginFill(0,0.1);
            graphics.drawRect(0,0,_width,_height);
            graphics.endFill();
            scrollRect = new Rectangle(0,0,_width,_height);
        }
    }
}
