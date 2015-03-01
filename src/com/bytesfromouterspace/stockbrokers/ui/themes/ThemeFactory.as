/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.ui.themes {

    public class ThemeFactory {

        private static var _instance:ThemeFactory = null;

        private var _currentTheme:ITheme;

        public function ThemeFactory(lock:Class) {
            if(lock != FactoryLock) {
                throw new ArgumentError("Invalid singleton access");
            } else {
                _currentTheme = new DefaultTheme();
                _currentTheme.init();
            }
        }

        public static function get instance():ThemeFactory {
            if(_instance == null) {
                _instance = new ThemeFactory(FactoryLock);
            }
            return _instance;
        }

        public function get theme():ITheme {
            return _currentTheme;
        }


    }
}
class FactoryLock{

}