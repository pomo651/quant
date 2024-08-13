#property copyright "some right"
#property link "xxx.com"
#property version "1.00"

#include <Trader\Trade.mqh>
CTrade trade;

# Input
input group "EA 基础设置"
sinput int MagicNumber = 8888; // 魔术号，不需要被优化，所以用sinput
sinput int SlType = 1; // 固定金额
sinput int SlParam = 100; // 止损依据


input group "均线设置"
input int FastMA = 50;
input int slowMA = 100;


input group "止损止盈"
input int TakeProfitPoints = 100;
input int StopLossPoints = 100;


int fastMAHandle;
int slowMAHandle;

double fastMABuffer[];
double slowMABuffer[];


int OnInit() {
	fastMAHandle = iMA(_Symbol, PERIOD_CURRENT, FastMA, 0, MODE_SMA, PRICE_CLOSE);
	slowMAHandle = iMA(_Symbol, PERIOD_CURRENT, SlowMA, 0, MODE_SMA, PRICE_CLOSE);

	trade.SetExpertMagicNumber(MagicNumber);

	return INIT_SUCCEEDED;
}

void OnTick() {
	
	double Ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
	double Bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);

	int result = maCrossStates();

	if(PositionTotal() == 0) {
		if(result == 1) {
			trade.Buy(0.01, _Symbol, Ask, Ask - StopLossPoints*_Point, Ask + TakeProfitPoints*_Point, '双均线系统 - BUY')
		} 
		else if(result == -1) {
			trade.Sell(0.01, _Symbol, Bid, Bid + StopLossPoints*_Point, Bid - TakeProfitPoints*_Point, '双均线系统 - SELL')
		}
	}

}

int maCrossStates(){
	
	CopyBuffer(fastMAHandle, 0, 0, 2, fastMABuffer);
	CopyBuffer(slowMAHandle, 0, 0, 2, slowMABuffer);

	if(fastMABuffer[1] > slowMABuffer[1] && fastMABuffer[0] < slowMABuffer[0]) {
		return 1;
	} 
	else if(fastMABuffer[1] < slowMABuffer[1] && fastMABuffer[0] > slowMABuffer[0]) {
		return -1;
	}
	else {
		return 0;
	}
}