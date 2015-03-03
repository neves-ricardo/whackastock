/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {
    import com.bytesfromouterspace.stockbrokers.event.SoundRandomGeneratorEvent;

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.utils.ByteArray;

    public class SoundRandomGeneratorModel extends EventDispatcher{

        private var _soundPath:String;
        private var _soundData:ByteArray;
        public var numSamples:Number;
        private var _lastSample:Number = 0;
        private var _currentValue:Number;

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
            dispatchEvent(new SoundRandomGeneratorEvent(SoundRandomGeneratorEvent.START));
        }


        public function get _nextAudioSample():Number {
            var sample:Number = 0;
            var numSamples:int = 0;
            var sampleAvg:Number = 0;
            var min:Number = Number.MAX_VALUE;
            var max:Number = Number.MIN_VALUE;
            while(numSamples < 512) {
                while ((sample == 0) || (sample == _lastSample)) {
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
                sampleAvg += sample;
                numSamples++;
            }
            sample = sampleAvg / numSamples;
            //sample -= _lastSample;
            _lastSample = sample;
            //trace(sample.toFixed(2), min.toFixed(2), max.toFixed(2));

            return sample - 0.25; //+0.5;
        }

        public function generateAudioRandom():void {
            currentValue = _nextAudioSample;
        }

        public function get currentValue():Number {
            return _currentValue;
        }

        public function set currentValue(value:Number):void {
            _currentValue = value;
            dispatchEvent(new SoundRandomGeneratorEvent(SoundRandomGeneratorEvent.CHANGE, value));
        }
    }
}
