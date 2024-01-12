// Launch with OSC_recv.ck

// host namen and port
"192.168.100.189" => string hostname; // Change if your are in a network bwt computers 
6449 => int port;

// get command line
//if( me.args()) me.arg(0) => hostname;
//if( me.args() >) me.arg(1) => Std.atoi => port;
    
// Send object
OscOut xmit;

// aim the transmiter
xmit.dest(hostname, port);

// Infinite time loop

while(true)
{
    // Start the message
    xmit.start("sndbuf/buf/rate");
    
    // add float arg
    Math.random2f(.5, 1.0) => float temp => xmit.add; // reaktor works between 0 an 1
    
    // Send
    xmit.send();
    <<< "sent (via OSC):", temp >>>;
    
    // advanced time
    0.2::second => now;
    }