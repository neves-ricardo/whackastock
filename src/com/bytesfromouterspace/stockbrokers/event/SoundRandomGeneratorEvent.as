/**
 * Created by Akira on 02/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.event {
    import flash.events.Event;

    public class SoundRandomGeneratorEvent extends Event {

        public static const START:String = "start";
        public static const CHANGE:String = "change";

        public var number:Number;

        public function SoundRandomGeneratorEvent(type:String, number:Number = 0, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
            this.number = number;
        }

        public override function clone():Event {
            return new SoundRandomGeneratorEvent(type, number, bubbles, cancelable);
        }

        public override function toString():String {
            return formatToString("SoundRandomGeneratorEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

    }
}