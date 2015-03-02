/**
 * Created by Akira on 02/03/2015.
 */
package com.bytesfromouterspace.stockbrokers.model {

    public class InvestorsModel extends BaseModel {

        public var kingpins:Vector.<KingpinModel>;

        public function InvestorsModel() {
            super();
            kingpins = new Vector.<KingpinModel>(4, true);
            kingpins[0] = new KingpinModel(0, 1, 0.1, 200000);
            kingpins[1] = new KingpinModel(1, 3, 0.08, 400000);
            kingpins[2] = new KingpinModel(2, 6, 0.05, 650000);
            kingpins[3] = new KingpinModel(3, 10, 0.04, 900000);
        }
    }
}
