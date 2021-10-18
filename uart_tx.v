module uart_tx
    #(
        parameter DBIT = 8;     //cantidad de bits de dato
        parameter SB_TICK = 16; // # ticks para stop bits 
    )