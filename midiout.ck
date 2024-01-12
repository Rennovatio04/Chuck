
MidiOut mout;
MidiMsg msg;
5 => int portNum; // Get from IAC bus. El canal por donde me recibió en monark fue el 5. El canal por donde recibe Push es por el 3

mout.open(portNum); // Open MIDI port

while(true) 
{
    144 => msg.data1; // Note On
    Math.random2(20, 80) => msg.data2; // Choose Pitch Randomly
    Math.random2(60, 64) => msg.data3; // Choose Volume Randomly
    mout.send(msg);
    
    .25::second => now;
}
    