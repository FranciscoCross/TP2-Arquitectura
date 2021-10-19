module baudrategen
    #(
        parameter N_BITS = 8,
        parameter N_COUNT = 163 //Se espera que cada 163 ciclos de clock generar una señal tick para muestrear
    )                           //El valor 163 es para un baudrate de 19200 bauds y un clock de 50MHz (50*10^6 / 19200*16)
    (
        input wire clock,
        input wire reset,
        output reg tick
    );

    reg [N_BITS-1:0] count;

    always @(posedge clock)
    begin : counter
        if(reset)
        begin
            count = 0;
            tick = 0;
        end
        else
        begin
            count = count + 1;
            if(count == N_COUNT) //Cuando el contador alcanza el valor de módulo, se debe reiniciar la cuenta y setear a 1 el tick
            begin
                tick = 1;
                count = 0;
            end
            else
            begin
                tick = 0; //En cualquier otro valor de contador se debe poner a 0 la señal
            end
        end

    end
endmodule