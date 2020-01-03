wait:{[x] system"ping 127.0.0.1 -n ",(string x+1)," > nul"}; // sleep for windows, x = number of seconds (int)
unixts:{floor((`long$.z.p)-`long$1970.01.01D00:00)%1e9};
kdbts:{`timestamp$floor(`long$1970.01.01D00:00 + 1e9 * x)};
echo:{0N!x;};
doesExist:{`$x in key `.;};
UnixTS:{"p"$1970.01.01D+1000000j*x};
fibonacci:{x,sum -2#x}/[;0 1] ;
tounixts:{floor((`long$x)-`long$1970.01.01D00:00)%1e9};