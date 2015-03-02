/**
 * Created by Akira on 02/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.event {
    import flash.events.Event;

    public class ReputationStatusEvent extends Event {

        public static const CHANGE:String = "change";
        public static const LEVEL_UP:String = "levelUp";

        public var level:int;

        public function ReputationStatusEvent(type:String, level:int = 0, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
            this.level = level;
        }

        public override function clone():Event {
            return new ReputationStatusEvent(type, level, bubbles, cancelable);
        }

        public override function toString():String {
            return formatToString("ReputationStatusEvent", "type", "level", "bubbles", "cancelable", "eventPhase");
        }

    }
}