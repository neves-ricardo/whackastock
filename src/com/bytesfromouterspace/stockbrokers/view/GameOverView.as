/**
 * Created by Akira on 03/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {

    import com.bytesfromouterspace.stockbrokers.model.GameStatsSessionModel;

    import flash.display.Bitmap;

    import flash.events.Event;
    import flash.events.MouseEvent;

    public class GameOverView extends GameStatsView {


        public function GameOverView(stats:GameStatsSessionModel) {
            super(stats, 600, 580);
            //content.height += 20;
            topPadding = 30;
            var lblGame:Bitmap = theme.createBitmapLabel("Game over!", 14, 0xFFCC00);
            lblGame.x = 240;
            lblGame.y = 20;
            content.addChild(lblGame);
            btnClose.setLabel("High Scores", 10, 0xFFFFFF, "visitor1");
        }

        private function onCloseClick(event:MouseEvent):void {
            dispatchEvent(new Event(Event.CLOSE));
        }
    }
}
