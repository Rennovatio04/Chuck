MidiOut mout;
MidiMsg msg;
5 => int portNum; // Puerto MIDI número 5

mout.open(portNum); // Abrir el puerto MIDI

// Bucle para generar la secuencia de bajo
while (true) {
    0x90 => msg.data1; // Mensaje "Note On"
    Std.rand2(70, 80) => msg.data2; // Nota aleatoria dentro del rango
    Std.rand2(60, 100) => msg.data3; // Velocidad aleatoria
    
    mout.send(msg); // Enviar mensaje MIDI
    
    0.25::second => now; // Esperar la duración de la nota
    
    0x80 => msg.data1; // Mensaje "Note Off"
    msg.data2 => msg.data3; // Configurar la velocidad a 0
    
    mout.send(msg); // Enviar mensaje MIDI de "Note Off"
    
    0.25::second => now; // Esperar antes de la próxima nota
}
