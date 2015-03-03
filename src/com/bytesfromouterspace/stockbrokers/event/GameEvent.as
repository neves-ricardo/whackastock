/**
 * Created by Akira on 03/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.event {
    import flash.events.Event;

    public class GameEvent extends Event {

        public static const GAME_OVER:String = "gameOver";

        public function GameEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);

        }

        public override function clone():Event {
            return new GameEvent(type, bubbles, cancelable);
        }

        public override function toString():String {
            return formatToString("GameEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

    }
}