#property copyright "some right"
#property link "xxx.com"
#property version "1.00"

#include <Trader\Trade.mqh>
CTrade trade;

# Input
input int openHour = 22; // Open trade time
input double slPoint = 1000; // Stop loss position
input double tpPoint = 100; // Take profit position

int OnInit() {
	return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason) {
	
}

void OnTick() {
	// current ask price
	double ask = NormalizeDouble(SymboleInfoDouble(_Symbol, SYMBOL_ASK), _Digits);

	// tp price
	double tp = ask + tpPoint * _Point;

	// sl price
	double sl = ask - slPoint * _Point;

	// current time 
	MqlDateTime timenow;
	TimeToStruct(TimeCurrent(), timenow);

	// 开单条件
	// 1.当前没有持仓，避免连续开仓
	// 2.到指定时间开单
	if(PositionsTotal() == 0 && timenow.hour == openHour) {
		// 使用trade类开单
		trade.Buy(1, _Symbol, ask, sl, tp, "some comment")
	}
}