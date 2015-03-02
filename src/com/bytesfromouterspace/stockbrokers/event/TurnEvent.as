/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.event {
    import flash.events.Event;

    public class TurnEvent extends Event {

        public static const TIMER_START:String = "timerStarted";
        public static const TIMER_ENDED:String = "timerEnded";
        public static const TIMER_TICK:String = "timerTick";
        public static const RESET_CHANGE:String = "resetChange";

        public function TurnEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
        }

        public override function clone():Event {
            return new TurnEvent(type, bubbles, cancelable);
        }

        public override function toString():String {
            return formatToString("TurnEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

    }
}