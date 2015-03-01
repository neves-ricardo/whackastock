/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.ui {
    import flash.display.Shape;

    public class MarketTendencyShape extends Shape {

        public static const TENDENCY_UNKNOWN:uint = 0;
        public static const TENDENCY_DOWN:uint = 1;
        public static const TENDENCY_UP:uint = 2;
        public static const TENDENCY_EQUAL:uint = 3;

        private static const WIDTH:Number = 11;
        private static const HEIGHT:Number = 9;

        private var _tendency:uint = 0;

        public function MarketTendencyShape() {
            update();
        }

        private function update():void {
            switch(_tendency) {
                case TENDENCY_DOWN:
                        graphics.clear();
                        graphics.beginFill(0xFF0000, 1);
                        graphics.lineTo(WIDTH, 0);
                        graphics.lineTo(WIDTH * 0.5, HEIGHT);
                        graphics.lineTo(0,0);
                        graphics.endFill();
                    break;
                case TENDENCY_UP:
                    graphics.clear();
                    graphics.beginFill(0x00FF00, 1);
                    graphics.moveTo(0,HEIGHT);
                    graphics.lineTo(WIDTH, HEIGHT);
                    graphics.lineTo(WIDTH * 0.5, 0);
                    graphics.lineTo(0,HEIGHT);
                    graphics.endFill();
                    break;

                case TENDENCY_EQUAL:
                    graphics.clear();
                    graphics.beginFill(0xFFCC00, 1);
                    graphics.drawRect(0,0, WIDTH, 0.33 * HEIGHT);
                    graphics.drawRect(0,HEIGHT - 0.33 * HEIGHT, WIDTH, 0.33 * HEIGHT);
                    graphics.endFill();
                    break;

                default:
                    graphics.clear();
            }
        }

        public function get tendency():uint {
            return _tendency;
        }

        public function set tendency(value:uint):void {
            _tendency = value;
            update();
        }
    }
}
