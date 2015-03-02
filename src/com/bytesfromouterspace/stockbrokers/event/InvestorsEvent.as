/**
 * Created by Akira on 02/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.event {

    import com.bytesfromouterspace.stockbrokers.model.KingpinModel;

    import flash.events.Event;

    public class InvestorsEvent extends Event {

        public static const CHANGE:String = "change";
        public static const LOAN_ACCEPTED:String = "loanAccepted";
        public static const LOAN_PAY:String = "loanRequestPay";

        public var loan:KingpinModel;

        public function InvestorsEvent(type:String, loan:KingpinModel = null, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
            this.loan = loan;
        }

        public override function clone():Event {
            return new InvestorsEvent(type, loan, bubbles, cancelable);
        }

        public override function toString():String {
            return formatToString("InvestorsEvent", "type", "loan", "bubbles", "cancelable", "eventPhase");
        }

    }
}