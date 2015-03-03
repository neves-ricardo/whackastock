/**
 * Created by Akira on 03/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {
    import flash.events.Event;

    public class TransactionLogModel extends BaseModel {

        private var _logs:Vector.<String>;
        private var _numLogs:int;
        private var _logCapacity:int;

        public function TransactionLogModel(logCapacity:int) {
            super();
            _logCapacity = logCapacity;
            _logs = new Vector.<String>();
            _numLogs = 0;
        }

        public function log(what:String):void {
            if(_numLogs > _logCapacity) {
                _logs.pop();
            }
            _logs.unshift(what);
            _numLogs++;
            dispatchEvent(new Event(Event.CHANGE));
        }

        public function get lastMessage():String {
            if(_numLogs > 0) {
                return _logs[0];
            }
            return " ";
        }
    }
}
