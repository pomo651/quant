// Source: https://www.youtube.com/watch?v=BKwzsKuWdA4&t=1131s
// Shoule compile successfully


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