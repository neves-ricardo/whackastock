/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.event {
    import flash.events.Event;

    public class TurnTimerEvent extends Event {

        public static const TIMER_START:String = "timerStarted";
        public static const TIMER_ENDED:String = "timerEnded";
        public static const TIMER_TICK:String = "timerTick";
        public static const TIMER_CHANGE:String = "timerChange";

        public function TurnTimerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
        }

        public override function clone():Event {
            return new TurnTimerEvent(type, bubbles, cancelable);
        }

        public override function toString():String {
            return formatToString("TurnTimerEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

    }
}