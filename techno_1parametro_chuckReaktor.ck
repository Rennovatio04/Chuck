MidiOut mout;
MidiMsg msg;
5 => int portNum; // Puerto MIDI número 5

mout.open(portNum); // Abrir el puerto MIDI

// Bucle para generar la secuencia de bajo y controlar parámetros
while (true) {
    // Nota aleatoria dentro del rango
    0x90 => msg.data1; // Mensaje "Note On"
    Std.rand2(60, 72) => msg.data2; // Nota aleatoria
    Std.rand2(40, 100) => msg.data3; // Velocidad aleatoria
    
    mout.send(msg); // Enviar mensaje MIDI de "Note On"
    
    // Controlar parámetros de Monark
    0xB0 => msg.data1; // Mensaje de Control Change (CC)
    1 => msg.data2; // Número de CC (ajustar según el parámetro)
    Std.rand2(40, 82) => msg.data3; // Valor de CC aleatorio (ajustar según el rango del parámetro)
    
    mout.send(msg); // Enviar mensaje MIDI CC
    
    0.15::second => now; // Esperar la duración de la nota
    
    0x80 => msg.data1; // Mensaje "Note Off"
    msg.data2 => msg.data3; // Configurar la velocidad a 0
    
    mout.send(msg); // Enviar mensaje MIDI de "Note Off"
    
    0.15::second => now; // Esperar antes de la próxima nota
}
