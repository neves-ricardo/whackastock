/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.ui.components {
    public class BottomBar extends ComponentBase {

        private var background:BorderBackground;

        public function BottomBar() {
            super(821, 30);
            background = new BorderBackground(821, 30);
            background.backgroundColor = 0x017EC1;
            background.borderColor = 0x41C6F3;
            addChild(background);
        }
    }
}
