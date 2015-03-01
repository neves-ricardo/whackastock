/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.ui.themes {
    import flash.utils.Dictionary;

    public class StyleGroup {

        private var _properties:Dictionary;
        private var _name:String;

        public function StyleGroup(name:String, props:Object) {
            this._name = name;
            _properties = new Dictionary();
            if(props) {
                for(var key:String in props) {
                    _properties[key] = props[key];
                }
            }
        }

        public function getStyle(key:String, defaultValue: *):* {
            if(_properties && _properties[key]) {
                return _properties[key];
            }
            return defaultValue;
        }
    }
}
