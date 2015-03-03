/**
 * Created by Akira on 03/03/2015.
 */
package com.bytesfromouterspace.stockbrokers {

    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.net.URLRequest;
    import flash.text.TextField;
    import flash.text.TextFormat;

    [SWF(width="924", height="720", backgroundColor="#212121")]
    public class Preloader extends Sprite{

        private var txt:TextField;
        private var ldr:Loader;

        public function Preloader() {

            txt = new TextField();
            txt.width = 200;
            txt.height = 50;
            var tfm:TextFormat = new TextFormat("_typewriter", 14, 0xFFFFFF, null, null, null, null, "center");
            tfm.leading = 10;
            txt.defaultTextFormat = tfm;
            txt.text = "Loading Wack'a'Stock!\nPlease wait...\n";

            txt.x = 362;
            txt.y = 320;
            addChild(txt);

            ldr = new Loader();
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onGameLoaded);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onGameLoadError);
            ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onGameLoadProgress);
            ldr.load(new URLRequest("Main.swf"));
        }

        private function onGameLoaded(event:Event):void {
            ldr.contentLoaderInfo.removeEventListener(Event.COMPLETE, onGameLoaded);
            ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onGameLoadError);
            ldr.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onGameLoadProgress);
            addChild(ldr);
        }

        private function onGameLoadError(event:IOErrorEvent):void {
            ldr.contentLoaderInfo.removeEventListener(Event.COMPLETE, onGameLoaded);
            ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onGameLoadError);
            ldr.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onGameLoadProgress);
            txt.text = "I/O Error!\nUnable to load game... wtf?!";
        }

        private function onGameLoadProgress(event:ProgressEvent):void {
            txt.text = "Loading Wack'a'Stock!\nPlease wait... " + Number((event.bytesLoaded / event.bytesTotal) * 100).toFixed(2) + "%";
        }
    }
}
