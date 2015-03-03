/**
 * Created by Akira on 03/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.controller {
    import flash.media.Sound;
    import flash.media.SoundChannel;

    public class SoundController {

        private static var _instance:SoundController;

        [Embed(source="/assets/audio/cash.mp3")]
        private var cashSoundClass:Class;
        private var cashSound:Sound;
        private var cashSoundChannel:SoundChannel;

        public var soundsEnabled:Boolean = true;

        [Embed(source="/assets/audio/fail.mp3")]
        private var failSoundClass:Class;
        private var failSound:Sound;
        private var failSoundChannel:SoundChannel;

        public function SoundController(lock:Class) {
            if(lock != SoundLock) {
                throw new ArgumentError("Invalid singleton access!");
            } else {
                cashSound = new cashSoundClass() as Sound;
                failSound = new failSoundClass() as Sound;
            }
        }

        public static function get instance():SoundController {
            if(_instance == null) {
                _instance = new SoundController(SoundLock);
            }
            return _instance;
        }

        public function playCash():void {
            if(!soundsEnabled) {
                return;
            }
            if(failSoundChannel != null) {
                failSoundChannel.stop();
            }
            cashSoundChannel = cashSound.play();
        }

        public function playFail():void {
            if(!soundsEnabled) {
                return;
            }
            if(cashSoundChannel != null) {
                cashSoundChannel.stop();
            }
            failSoundChannel = failSound.play();
        }
    }
}
class SoundLock {
}
