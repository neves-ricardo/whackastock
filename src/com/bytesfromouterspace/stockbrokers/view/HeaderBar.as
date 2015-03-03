/**
 * Created by Akira on 03/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {
    import com.bytesfromouterspace.stockbrokers.controller.GameController;
    import com.bytesfromouterspace.stockbrokers.controller.SoundController;
    import com.bytesfromouterspace.stockbrokers.model.GameModel;
    import com.bytesfromouterspace.stockbrokers.ui.components.BorderBackground;
    import com.bytesfromouterspace.stockbrokers.ui.components.Button;
    import com.bytesfromouterspace.stockbrokers.ui.components.ComponentBase;

    import flash.display.Bitmap;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class HeaderBar extends ComponentBase{
        private var background:BorderBackground;
        private var btnHelp:Button;
        private var btnStats:Button;
        private var btnHighscores:Button;
        private var btnRestart:Button;
        private var btnSound:Button;

        public function HeaderBar(model:GameModel, controller:GameController) {
            super(821, 30);
            background = new BorderBackground(821, 30);
            background.backgroundColor = 0x017EC1;
            background.borderColor = 0x41C6F3;
            addChild(background);

            var lbl:Bitmap = theme.createBitmapLabel("Whack  a  Stock", 14, 0xFFFFFF );
            lbl.x = 4;
            lbl.y = 7;
            addChild(lbl);

            lbl = theme.createBitmapLabel("Version " + GameModel.VERSION, 10, 0x212121, "visitor1" );
            lbl.x = 410;
            lbl.y = 8;
            addChild(lbl);

            btnHelp = new Button(50, 16);
            btnHelp.buttonBackgroundNormal = 0x444444;
            btnHelp.buttonBorderNormal = 0x999999;
            btnHelp.drawBackground();
            btnHelp.setLabel("Help", 10, 0xFFFFFF, "visitor1");
            btnHelp.x = 490;
            btnHelp.y = 7;
            btnHelp.addEventListener(MouseEvent.CLICK, onHelpClick);
            addChild(btnHelp);

            btnStats = new Button(50, 16);
            btnStats.buttonBackgroundNormal = 0x444444;
            btnStats.buttonBorderNormal = 0x999999;
            btnStats.drawBackground();
            btnStats.setLabel("Stats", 10, 0xFFFFFF, "visitor1");
            btnStats.x = btnHelp.x + btnHelp.width + 2;
            btnStats.y = 7;
            btnStats.enabled = false;
            addChild(btnStats);

            btnHighscores = new Button(80, 16);
            btnHighscores.buttonBackgroundNormal = 0x444444;
            btnHighscores.buttonBorderNormal = 0x999999;
            btnHighscores.drawBackground();
            btnHighscores.setLabel("High Scores", 10, 0xFFFFFF, "visitor1");
            btnHighscores.x = btnStats.x + btnStats.width + 2;
            btnHighscores.y = 7;
            btnHighscores.enabled = false;
            addChild(btnHighscores);

            btnRestart = new Button(60, 16);
            btnRestart.buttonBackgroundNormal = 0x444444;
            btnRestart.buttonBorderNormal = 0x999999;
            btnRestart.drawBackground();
            btnRestart.setLabel("Restart", 10, 0xFFFFFF, "visitor1");
            btnRestart.x = btnHighscores.x + btnHighscores.width + 2;
            btnRestart.y = 7;
            btnRestart.addEventListener(MouseEvent.CLICK, onRequestRestart);
            addChild(btnRestart);

            btnSound = new Button(70, 16);
            btnSound.buttonBackgroundNormal = 0x444444;
            btnSound.buttonBorderNormal = 0x999999;
            btnSound.drawBackground();
            btnSound.setLabel("Sound OFF", 10, 0xFFFFFF, "visitor1");
            btnSound.x = btnRestart.x + btnRestart.width + 2;
            btnSound.y = 7;
            btnSound.addEventListener(MouseEvent.CLICK, onSoundBtnClick);
            addChild(btnSound);
        }

        private function onSoundBtnClick(event:MouseEvent):void {
            if(SoundController.instance.soundsEnabled) {
                SoundController.instance.soundsEnabled = false;
                btnSound.setLabel("Sound ON", 10, 0xFFFFFF, "visitor1");
            } else {
                SoundController.instance.soundsEnabled = true;
                btnSound.setLabel("Sound OFF", 10, 0xFFFFFF, "visitor1");
            }
        }

        private function onRequestRestart(event:MouseEvent):void {
            var paux:DisplayObjectContainer = this.parent;
            while(paux.parent != null) {
                paux = paux.parent;
            }
            dispatchEvent(new Event("reloadGame", true));
        }

        private function get viewRef():GameView {
            return parent as GameView;
        }

        private function onHelpClick(event:MouseEvent):void {
            viewRef.requestHelpMenu();
        }
    }
}
