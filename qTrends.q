
\p 5010
\l reQ/req.q
\l tools.q

load`candleweekly;
delete from `candleweekly where  time~'next time;
if[00:00:00.000000 > .z.p - last candleweekly[`time];delete from `candleweekly where i = -1 + count candleweekly];
lastweeklytime: 0N! last candleweekly[`time];
load`candledaily;
delete from `candledaily where  time~'next time;
if[00:00:00.000000 > .z.p - last candledaily[`time];delete from `candledaily where i = -1 + count candledaily];
lastdailytime: 0N! last candledaily[`time];
load`candlehourly;
delete from `candlehourly where  time~'next time;
if[00:00:00.000000 > .z.p - last candlehourly[`time];delete from `candlehourly where i = -1 + count candlehourly];
lasthourlytime: 0N! last candlehourly[`time];
load`candleminutely;
delete from `candleminutely where  time~'next time;
if[00:00:00.000000 > .z.p - last candleminutely[`time];delete from `candleminutely where i = -1 + count candleminutely];
lastminutelytime: 0N! last candleminutely[`time];


unixlasttime:tounixts[lastweeklytime];
CanInfo: 0N! .j.k .Q.hg ":https://api.cryptowat.ch/markets/coinbase-pro/btcusd/ohlc?periods=604800&after=",string unixlasttime;
candata: flip CanInfo[`result][`604800];

times: kdbts[candata[0]];
opens: candata[1];
highs:candata[2];
lows:candata[3];
closes:candata[4];
volumes:candata[5];
cancount:count times;
`candleweekly insert( sym:cancount#`BTCUSD; time:times; open:opens;high:highs;low:lows;close:closes;volume:volumes);

unixlasttime:tounixts[lastdailytime];
CanInfo: 0N! .j.k .Q.hg ":https://api.cryptowat.ch/markets/coinbase-pro/btcusd/ohlc?periods=86400&after=",string unixlasttime;
candata: flip CanInfo[`result][`86400];

times: kdbts[candata[0]];
opens: candata[1];
highs:candata[2];
lows:candata[3];
closes:candata[4];
volumes:candata[5];
cancount:count times;

`candledaily insert( sym:cancount#`BTCUSD; time:times; open:opens;high:highs;low:lows;close:closes;volume:volumes);

unixlasttime:tounixts[lasthourlytime];
CanInfo: 0N! .j.k .Q.hg ":https://api.cryptowat.ch/markets/coinbase-pro/btcusd/ohlc?periods=14400&after=",string unixlasttime;
candata: flip CanInfo[`result][`14400];

times: kdbts[candata[0]];
opens: candata[1];
highs:candata[2];
lows:candata[3];
closes:candata[4];
volumes:candata[5];
cancount:count times;

`candlehourly insert( sym:cancount#`BTCUSD; time:times; open:opens;high:highs;low:lows;close:closes;volume:volumes);

unixlasttime:tounixts[lastminutelytime];
CanInfo: 0N! .j.k .Q.hg ":https://api.cryptowat.ch/markets/coinbase-pro/btcusd/ohlc?periods=900&after=",string unixlasttime;
candata: flip CanInfo[`result][`900];

times: kdbts[candata[0]];
opens: candata[1];
highs:candata[2];
lows:candata[3];
closes:candata[4];
volumes:candata[5];
cancount:count times;

`candleminutely insert( sym:cancount#`BTCUSD; time:times; open:opens;high:highs;low:lows;close:closes;volume:volumes);

delete from `candleweekly where  time~'next time;
if[00:00:00.000000 > .z.p - last candleweekly[`time];delete from `candleweekly where i = -1 + count candleweekly];
delete from `candledaily where  time~'next time;
if[00:00:00.000000 > .z.p - last candledaily[`time];delete from `candledaily where i = -1 + count candledaily];
delete from `candlehourly where  time~'next time;
if[00:00:00.000000 > .z.p - last candlehourly[`time];delete from `candlehourly where i = -1 + count candlehourly];
delete from `candleminutely where  time~'next time;
if[00:00:00.000000 > .z.p - last candleminutely[`time];delete from `candleminutely where i = -1 + count candleminutely];

save`candleweekly
save`candleweekly.csv
save`candledaily
save`candledaily.csv
save`candlehourly
save`candlehourly.csv
save`candleminutely
save`candleminutely.csv


// analysis
// candles
//select from candleweekly
// MAs
//select  time,ma10:mavg[10; close],ma30:mavg[30; close],ma50:mavg[50; close],ma70:mavg[70; close],ma200:mavg[200; close],price:close from candleweekly 
// MACD  
//select  time,macd:(mavg[14;close])-mavg[27;close],  macdsignal:mavg[10;(mavg[14;close])-mavg[27;close]] from candleweekly
// RSI   
//mavg1:{a:sum[x#y]%x; b:(x-1)%x; a,a b\(x+1)_y%x};
//calcRsi:{100*rs%1+rs:mavg1[x;y*y>0]%mavg1[x;abs y*(y:y-prev y)<0]};
//select  time,20,80,  rsi:((10#0Nf),calcRsi[10;close])from candleweekly 