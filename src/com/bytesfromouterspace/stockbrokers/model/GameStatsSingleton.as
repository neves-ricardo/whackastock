/**
 * Created by Akira on 02/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {
    import flash.utils.Dictionary;

    public class GameStatsSingleton {

        private static var _instance:GameStatsSingleton;

        private var stats:Dictionary;

        public function GameStatsSingleton(lock:Class) {
            if(lock != StatsLock) {
                throw new ArgumentError("Invalid Singleton access!");
            } else {
                stats = new Dictionary();

            }
        }
    }
}
class StatsLock {

}
