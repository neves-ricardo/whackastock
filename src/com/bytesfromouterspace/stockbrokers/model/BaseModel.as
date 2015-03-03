/**
 * Created by ricardo_neves at bytesfromouterspace.com on 28/02/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {

    import flash.events.EventDispatcher;

    public class BaseModel extends EventDispatcher{

        public function BaseModel() {
            super(this);
        }

        public function stat(prop:String, value:Number):void {

        }
    }
}
