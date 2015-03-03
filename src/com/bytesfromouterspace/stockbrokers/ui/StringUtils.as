/**
 * Created by Akira on 02/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.ui {

    public class StringUtils {

        public static function numPadd(num:int, digits:int = 2, padder:String = "0"):String {
            var ret:String = num.toString();
            while(ret.length < digits) {
                ret = padder + ret;
            }
            return ret;
        }

        public static function formatCurrency(value:Number):String {
            var isNegative:Boolean = value < 0;
            var numString:String = isNegative ? (value*-1).toFixed(0) : value.toFixed(0);
            var result:String = '';

            while (numString.length > 3)  {
                var chunk:String = numString.substr(-3);
                numString = numString.substr(0, numString.length - 3);
                result = ',' + chunk + result;
            }

            if (numString.length > 0) {
                result = numString + result;
            }
            if(isNegative) {
                result = "-" + result;
            }

            return result + "$";
        }
    }
}
