/**
 * Created by Akira on 03/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.controller {
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
    import flash.net.SharedObject;

    public class SoundController {

        private static var _instance:SoundController;

        [Embed(source="/assets/audio/cash.mp3")]
        private var cashSoundClass:Class;
        private var cashSound:Sound;
        private var cashSoundChannel:SoundChannel;

        private var _soundsEnabled:Boolean = true;

        [Embed(source="/assets/audio/fail.mp3")]
        private var failSoundClass:Class;
        private var failSound:Sound;
        private var failSoundChannel:SoundChannel;
        private var baseSoundTransform:SoundTransform;

        public function SoundController(lock:Class) {
            if(lock != SoundLock) {
                throw new ArgumentError("Invalid singleton access!");
            } else {
                cashSound = new cashSoundClass() as Sound;
                failSound = new failSoundClass() as Sound;
                var soundPrefs:SharedObject = SharedObject.getLocal("wsSoundPrefs");
                if(soundPrefs.data.soundsEnabled != undefined) {
                    _soundsEnabled = soundPrefs.data.soundsEnabled;
                }
                soundPrefs.close();
                baseSoundTransform = new SoundTransform(0.4);
            }
        }

        public static function get instance():SoundController {
            if(_instance == null) {
                _instance = new SoundController(SoundLock);
            }
            return _instance;
        }

        public function playCash():void {
            if(!_soundsEnabled) {
                return;
            }
            if(failSoundChannel != null) {
                failSoundChannel.stop();
            }
            cashSoundChannel = cashSound.play(0,0,baseSoundTransform);
        }

        public function playFail():void {
            if(!_soundsEnabled) {
                return;
            }
            if(cashSoundChannel != null) {
                cashSoundChannel.stop();
            }
            failSoundChannel = failSound.play(0,0,baseSoundTransform);
        }

        public function get soundsEnabled():Boolean {
            return _soundsEnabled;
        }

        public function set soundsEnabled(value:Boolean):void {
            _soundsEnabled = value;
            var soundPrefs:SharedObject = SharedObject.getLocal("wsSoundPrefs");
            soundPrefs.data.soundsEnabled = _soundsEnabled;
            soundPrefs.flush();
            soundPrefs.close();
        }
    }
}
class SoundLock {
}
