/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.ui.components {

    import com.bytesfromouterspace.stockbrokers.ui.events.UIEvent;
    import com.bytesfromouterspace.stockbrokers.ui.themes.ITheme;

    import flash.display.Graphics;
    import flash.display.Shape;

    import flash.display.Sprite;

    public class BackgroundContainer extends ComponentBase {

        protected var paddingTop:Number = 10;
        protected var paddingBottom:Number = 10;
        protected var paddingLeft:Number = 10;
        protected var paddingRight:Number = 10;

        public var background:Shape;
        public var container:GroupContainer;

        public function BackgroundContainer(_width:Number, _height:Number) {
            super(_width, _height);
            //addEventListener(UIEvent.UI_CHANGED, redraw);
            background = _theme.drawCorneredBackground(_width, _height);
            addChild(background);
            drawContainer();
        }

        protected function drawContainer():void {
            container = new GroupContainer(width - paddingLeft - paddingRight, height - paddingTop - paddingBottom);
            container.x = paddingLeft;
            container.y = paddingTop;
            addChild(container);
        }

        protected function redraw(event:UIEvent):void {
           // _theme.drawBackground(this.graphics, width, height);
        }
    }
}
