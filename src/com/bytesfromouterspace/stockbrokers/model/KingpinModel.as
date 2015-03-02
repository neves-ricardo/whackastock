/**
 * Created by Akira on 02/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {
    import flash.events.Event;

    public class KingpinModel extends BaseModel{

        public var id:int;
        public var minLevel:int;
        public var rate:Number;
        private var _accepted:Boolean;
        public var amount:int;
        private var _enabled:Boolean;
        private var _paid:Boolean;

        public function KingpinModel(id:int, minLevel:int, rate:Number, amount:int) {
            super();
            this.id = id;
            this.minLevel = minLevel;
            this.rate = rate;
            this.amount = amount;
            _enabled = false;
            _accepted = false;
            _paid = false;
        }

        public function get accepted():Boolean {
            return _accepted;
        }

        public function set accepted(value:Boolean):void {
            _accepted = value;
            dispatchEvent(new Event(Event.CHANGE));
        }

        public function get enabled():Boolean {
            return _enabled;
        }

        public function set enabled(value:Boolean):void {
            _enabled = value;
            dispatchEvent(new Event(Event.CHANGE));
        }

        public function get paid():Boolean {
            return _paid;
        }

        public function set paid(value:Boolean):void {
            _paid = value;
            dispatchEvent(new Event(Event.CHANGE));
        }
    }
}
