/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.utils.ByteArray;

    public class SoundRandomGeneratorModel extends EventDispatcher{

        private var _soundPath:String;
        private var _soundData:ByteArray;
        public var numSamples:Number;

        public function SoundRandomGeneratorModel(path:String) {
            super(this);
            _soundPath = path;
        }

        public function get soundPath():String {
            return _soundPath;
        }

        public function get soundData():ByteArray {
            return _soundData;
        }

        public function set soundData(value:ByteArray):void {
            _soundData = value;
            _soundData.position = int(Math.random() * _soundData.length);
            while(_soundData.position % 4 != 0) {
                _soundData.position--;
            }
            dispatchEvent(new Event(Event.CHANGE));
        }

        private var lastSample:Number = 0;
        public function get audioSample():Number {
            var sample:Number = 0;
            var numSamples:int = 0;
            var sampleAvg:Number = 0;
            var min:Number = Number.MAX_VALUE;
            var max:Number = Number.MIN_VALUE;
            while(numSamples < 1024) {
                while ((sample == 0) || (sample == lastSample)) {
                    if (_soundData.bytesAvailable > 8) {
                        sample = Math.abs(_soundData.readFloat()); //*3200;
                        _soundData.readFloat();// .position += 4;
                    } else {
                        trace("Sound ended");
                        _soundData.position = 0;
                    }
                }
                if(sample < min) {
                    min = sample;
                }
                if(sample > max) {
                    max = sample;
                }
                //lastSample = sample;
                sampleAvg += sample;
                numSamples++;
            }
            sample = sampleAvg / numSamples;
            //trace(sample.toFixed(2), min.toFixed(2), max.toFixed(2));
            return sample+0.5;
        }
    }
}
