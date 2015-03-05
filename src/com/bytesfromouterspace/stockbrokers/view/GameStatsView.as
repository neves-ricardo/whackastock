/**
 * Created by Akira on 03/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.view {

    import com.bytesfromouterspace.stockbrokers.model.GameStatsSessionModel;
    import com.bytesfromouterspace.stockbrokers.ui.StringUtils;
    import com.bytesfromouterspace.stockbrokers.ui.components.BlockerPanel;
    import com.bytesfromouterspace.stockbrokers.ui.components.Button;
    import com.bytesfromouterspace.stockbrokers.ui.components.PriceList;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class GameStatsView extends BlockerPanel {

        protected var content:Sprite;
        protected var btnClose:Button;
        private var _priceListLeft:PriceList;
        private var _priceListRight:PriceList;

        public function GameStatsView(stats:GameStatsSessionModel, contentWidth:Number = 600, contentHeight:Number = 560) {
            super();
            content = new Sprite();
            content.graphics.lineStyle(1, 0xFFFFFF);
            content.graphics.beginFill(0x121212);
            content.graphics.drawRect(0, 0, contentWidth, contentHeight);
            content.graphics.endFill();
            content.x = _width * 0.5 - content.width * 0.5;
            content.y = _height * 0.5 - content.height * 0.5;
            addChild(content);

            _priceListLeft = new PriceList(220, 220, 0.5);
            _priceListLeft.x = 40;
            _priceListLeft.y = 20;
            content.addChild(_priceListLeft);

            _priceListRight = new PriceList(220, 220, 0.5);
            _priceListRight.x = _priceListLeft.width + 100;
            _priceListRight.y = 20;
            content.addChild(_priceListRight);

            _priceListLeft.appendTexts("// Funds");
            _priceListLeft.appendTexts("Current funds", stats.statValueAsCurrency("fund_currentfunds"));
            _priceListLeft.appendTexts("Current loans", stats.statValueAsCurrency("inv_currentLoans"));
            _priceListLeft.appendTexts("Min funds",stats.statValueAsCurrency("fund_minfunds"));
            _priceListLeft.appendTexts("Max funds", stats.statValueAsCurrency("fund_maxfunds"));

            _priceListLeft.appendTexts("\n// Profits and Losses", "\n");
            _priceListLeft.appendTexts("Total profit", stats.statValueAsCurrency("mark_totalProfit"));
            _priceListLeft.appendTexts("Total losses", stats.statValueAsCurrency("mark_totalLoss"));
            _priceListLeft.appendTexts("Total neutral", stats.statValueAsCurrency("mark_totalNeutral"));
            _priceListLeft.appendTexts("Highest loss", stats.statValueAsCurrency("mark_maxLoss"));
            _priceListLeft.appendTexts("Highest profit", stats.statValueAsCurrency("mark_maxProfit"));

            _priceListLeft.appendTexts("\n// Buys and Sells", "\n");
            _priceListLeft.appendTexts("Shares Sold", stats.statValueAsInt("mark_qtdSharesSells"));
            _priceListLeft.appendTexts("Shares Bought", stats.statValueAsInt("mark_qtdSharesBuys"));
            _priceListLeft.appendTexts("Volume Sells", stats.statValueAsCurrency("mark_volumeSells"));
            _priceListLeft.appendTexts("Volume Buys", stats.statValueAsCurrency("mark_volumeBuys"));
            _priceListLeft.appendTexts("Sells performed", stats.statValueAsInt("mark_numSells"));
            _priceListLeft.appendTexts("Buys performed", stats.statValueAsInt("mark_totalBuys"));
            _priceListLeft.appendTexts("Highest sell", stats.statValueAsCurrency("mark_maxSells"));
            _priceListLeft.appendTexts("Highest buy", stats.statValueAsCurrency("mark_maxBuys"));

            _priceListLeft.appendTexts("\n// Owned shares ", "\n");
            _priceListLeft.appendTexts("Max share value", stats.statValueAsCurrency("mark_maxOwnedStocksValue"));
            _priceListLeft.appendTexts("Max share number", stats.statValueAsInt("mark_maxOwnedStocksNumber"));

            _priceListRight.appendTexts("\n// Reputation", "\n");
            _priceListRight.appendTexts("Current level", stats.statValueAsInt("rep_currentReputationLevel") + " / " + stats.statValueAsInt("rep_currentReputationValue"));
            _priceListRight.appendTexts("Max level", stats.statValueAsInt("rep_maxReputationLevel") + " / " + stats.statValueAsInt("rep_maxReputationValue"));
            _priceListRight.appendTexts("Total gained", stats.statValueAsInt("rep_totalRepGained"));
            _priceListRight.appendTexts("Total lost", stats.statValueAsInt("rep_totalRepLost"));
            _priceListRight.appendTexts("Total bonus", stats.statValueAsInt("rep_totalRepBonus"));

            _priceListRight.appendTexts("\n// Market ", "\n");
            _priceListRight.appendTexts("Max value", stats.statValueAsCurrency("mark_maxMarketValue"));
            _priceListRight.appendTexts("Min value", stats.statValueAsCurrency("mark_minMarketValue"));

            _priceListRight.appendTexts("\n// Time ", "\n");
            _priceListRight.appendTexts("Turns", stats.statValueAsInt("turn_numturns"));
            _priceListRight.appendTexts("Bonus", stats.statValueAsInt("turn_bonustime"));
            _priceListRight.appendTexts("Resets", stats.statValueAsInt("turn_resets"));


            var scoreFundsLoans:Number = stats.statValue("fund_currentfunds") + stats.statValue("inv_currentLoans");
            var scoreTurn:Number = stats.statValue("turn_numturns") * 1000;
            var scoreRepValue:Number = stats.statValue("rep_currentReputationValue");
            var scoreRepBonus:Number = stats.statValue("rep_totalRepBonus") * 50;

            var totalScore:Number = scoreFundsLoans + scoreTurn + scoreRepValue + scoreRepBonus;


            _priceListRight.appendTexts("\n// Current score ", "\n");
            _priceListRight.appendTexts("Funds - Loans", StringUtils.formatCurrency(scoreFundsLoans));
            _priceListRight.appendTexts("Turns x 1000$", StringUtils.formatCurrency(scoreTurn));
            _priceListRight.appendTexts("RepValue X 1$", StringUtils.formatCurrency(scoreRepValue));
            _priceListRight.appendTexts("repBonus X 50$", StringUtils.formatCurrency(scoreRepBonus));
            _priceListRight.appendTexts("\nGame Score", "\n" + StringUtils.formatCurrency(totalScore));



            btnClose = new Button(70, 16);
            btnClose.buttonBackgroundNormal = 0x444444;
            btnClose.buttonBorderNormal = 0x999999;
            btnClose.drawBackground();
            btnClose.setLabel("Okidoki", 10, 0xFFFFFF, "visitor1");
            btnClose.x = content.width * 0.5 - btnClose.width * 0.5;
            btnClose.y = content.height - 30;
            btnClose.addEventListener(MouseEvent.CLICK, onCloseClick);
            content.addChild(btnClose);

        }

        protected function set topPadding(value:Number):void {
            _priceListLeft.y = value+20;
            _priceListRight.y = value+20;
        }

        private function onCloseClick(event:MouseEvent):void {
            dispatchEvent(new Event(Event.CLOSE));
        }
    }
}
