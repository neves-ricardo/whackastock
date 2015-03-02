/**
 * Created by Akira on 02/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.event {
    import flash.events.Event;

    public class KingpinEvent extends Event {

        public static const CHANGE:String = "change";
        public static const LOAN_ACCEPT:String = "loadAccept";
        public static const LOAN_PAY:String = "loadPay";

        public function KingpinEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
        }

        public override function clone():Event {
            return new KingpinEvent(type, bubbles, cancelable);
        }

        public override function toString():String {
            return formatToString("KingpinEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

    }
}