// Definir la dirección IP y el puerto para la conexión OSC
"192.168.100.189" => string hostname; // Cambia esto según tu configuración de red
6449 => int port;

// Crear el objeto OscOut para enviar mensajes
OscOut xmit;

// Configurar la dirección de destino y el puerto del transmisor
xmit.dest(hostname, port);

// Bucle infinito para enviar mensajes OSC
while(true)
{
    // Iniciar el mensaje OSC
    xmit.start("/sndbuf/buf/rate");

    // Generar un valor flotante aleatorio y agregarlo al mensaje
    Math.random2f(0.5, 1.0) => float temp1;
    Math.random2f(0.5, 1.0) => float temp2;
    Math.random2f(0.5, 1.0) => float temp3;
    temp1 => xmit.add;
    temp2 => xmit.add;
    temp3 => xmit.add;

    // Enviar el mensaje OSC
    xmit.send();
    
    // Imprimir el valor enviado en la consola
    <<< "Enviado (vía OSC):", temp1, temp2, temp3 >>>;

    // Esperar un poco antes de enviar el siguiente mensaje
    0.2::second => now;
}
