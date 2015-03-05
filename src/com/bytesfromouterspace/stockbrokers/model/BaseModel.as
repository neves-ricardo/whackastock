/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {

    import avmplus.getQualifiedClassName;

    import com.bytesfromouterspace.stockbrokers.ui.StringUtils;

    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;

    public class BaseModel extends EventDispatcher{

        public static const STAT_CURRENT:uint = 0;
        public static const STAT_TOTAL:uint = 1;
        public static const STAT_MIN:uint = 2;
        public static const STAT_MAX:uint = 3;

        private var _isStatable:Boolean;
        private var _stats:Dictionary;

        public function BaseModel(isStatable:Boolean = true) {
            super(this);
            _isStatable = isStatable;
            if(_isStatable) {
                _stats = new Dictionary(true);
            }
        }

        public function multiStat(statKey:String, value:Number, ...options):void {
            if(_isStatable && (statKey != null) && (options != null)) {
                var i:int = 0;
                var len:int = options.length;
                var option:int;
                var key:String;
                while(i < len) {
                    option = options[i];
                    switch(option) {
                        case STAT_CURRENT:
                            key = "current" + statKey;
                            _stats[key] = value;
                            break;

                        case STAT_TOTAL:
                            key = "total" + statKey;
                            if(_stats[key] !== undefined) {
                                _stats[key] += value;
                            } else {
                                _stats[key] = value;
                            }
                            break;

                        case STAT_MIN:
                            key = "min" + statKey;
                            if(_stats[key] !== undefined) {
                                if(value < _stats[key]) {
                                    _stats[key] = value;
                                }
                            } else {
                                _stats[key] = value;
                            }
                            break;

                        case STAT_MAX:
                            key = "max" + statKey;
                            if(_stats[key] !== undefined) {
                                if(value > _stats[key]) {
                                    _stats[key] = value;
                                }
                            } else {
                                _stats[key] = value;
                            }
                            break;

                        default:
                            trace("Unknown stat option:", option);
                    }
                    i++;
                }
            }
        }

        public function stat(prop:String, value:Number):void {
            if(_isStatable && (prop != null)) {
                _stats[prop] = value;
            }
        }

        public function statValueAsInt(key:String):String {
            if(_isStatable && (key != null)) {
                return Number(_stats[key]).toFixed(0);
            }
            return "N/A";
        }

        public function statValue(key:String):Number {
            if(_isStatable && (key != null) && (_stats[key] !== undefined)) {
                return Number(_stats[key]);
            }
            return 0;
        }

        public function statValueAsCurrency(key:String):String {
            if(_isStatable && (key != null)) {
                var value:Number = _stats[key];
                if(!isNaN(value)) {
                    return StringUtils.formatCurrency(_stats[key]);
                } else {
                    return "---";
                }
            }
            return "N/A";
        }

        public function incStat(prop:String, value:Number = 1):void {
            if(_isStatable && (prop != null)) {
                if(_stats[prop] !== undefined) {
                    _stats[prop] += value;
                } else {
                    _stats[prop] = value;
                }
            }
        }

        public function dumpStats():void {
            var qcn:String = getQualifiedClassName(this);
            trace("Dumping stats for", qcn);
            var className:String = qcn.substr(qcn.lastIndexOf(":")+1) + ".";
            for(var key:String in _stats) {
                trace(className + key, "-->", _stats[key]);
            }
        }

        public function get stats():Dictionary {
            return _stats;
        }
    }
}
