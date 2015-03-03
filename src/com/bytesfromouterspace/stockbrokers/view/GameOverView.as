/**
 * Created by Akira on 03/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {

    import com.bytesfromouterspace.stockbrokers.ui.components.BlockerPanel;
    import com.bytesfromouterspace.stockbrokers.ui.components.Button;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;

    public class GameOverView extends BlockerPanel {

        private var content:Sprite;
        private var btnClose:Button;

        public function GameOverView() {
            super();
            content = new Sprite();
            content.graphics.lineStyle(1, 0xFFFFFF);
            content.graphics.beginFill(0x121212);
            content.graphics.drawRect(0, 0, 600, 500);
            content.graphics.endFill();
            content.x = _width * 0.5 - content.width * 0.5;
            content.y = _height * 0.5 - content.height * 0.5;
            addChild(content);

            var txt:TextField = new TextField();
            txt.x = 30;
            txt.y = 30;
            txt.width = 550;
            txt.height = 400;
            txt.wordWrap = true;
            txt.autoSize = "left";
            txt.embedFonts = true;
            var tfm:TextFormat = theme.getDefaultTextFormat();
            tfm.leading = 10;
            txt.defaultTextFormat = tfm;
            content.addChild(txt);
            txt.text = "Game Over!\n\n\nPENDING: Show stats";
            btnClose = new Button(70, 16);
            btnClose.buttonBackgroundNormal = 0x444444;
            btnClose.buttonBorderNormal = 0x999999;
            btnClose.drawBackground();
            btnClose.setLabel("Okidoki", 10, 0xFFFFFF, "visitor1");
            btnClose.x = content.width * 0.5 - btnClose.width * 0.5;
            btnClose.y = content.height - 30;
            btnClose.addEventListener(MouseEvent.CLICK, onCloseClick);
            content.addChild(btnClose);

        }

        private function onCloseClick(event:MouseEvent):void {
            dispatchEvent(new Event(Event.CLOSE));
        }
    }
}
