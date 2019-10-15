// q script to take a snapshot of 10 biggest trusted spot exchanges for Bitcoin / USD market

\p 5010
\l reQ/req.q
\ tools.q

candleweekly:([] sym:`$();time:`timestamp$(); open:`float$();high:`float$();low:`float$();close:`float$();volume:`float$());

CanInfo: 0N! .j.k .Q.hg ":https://api.cryptowat.ch/markets/coinbase-pro/btcusd/ohlc?periods=604800";
candata: flip CanInfo[`result][`604800];

times: kdbts[candata[0]];
opens: candata[1];
highs:candata[2];
lows:candata[3];
closes:candata[4];
volumes:candata[5];
cancount:count times;

`candleweekly insert( sym:cancount#`BTCUSD; time:times; open:opens;high:highs;low:lows;close:closes;volume:volumes);

// analysis
// candles
select from candleweekly
// MAs
select  time,ma10:mavg[10; close],ma30:mavg[30; close],ma50:mavg[50; close],ma70:mavg[70; close],ma200:mavg[200; close],price:close from candleweekly 
// MACD  
select  time,macd:(mavg[14;close])-mavg[27;close],  macdsignal:mavg[10;(mavg[14;close])-mavg[27;close]] from candleweekly
// RSI   
mavg1:{a:sum[x#y]%x; b:(x-1)%x; a,a b\(x+1)_y%x};
calcRsi:{100*rs%1+rs:mavg1[x;y*y>0]%mavg1[x;abs y*(y:y-prev y)<0]};
select  time,20,80,  rsi:((10#0Nf),calcRsi[10;close])from candleweekly 