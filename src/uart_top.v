module uart_top
    # ( 
    parameter NB_BITS = 8, // # cantidad de bits por dato 
    parameter SB_TICK = 16, // # ticks para stop bits 
    parameter N_COUNT = 163
    )
    ( 
    input wire clk,
    input wire reset, 
    input wire tx_start,
    input wire [NB_BITS - 1:0] ParamEnviar,
    output wire [NB_BITS - 1:0] RESULTADO,
    output wire datoListorti 
    );


    //wires
    wire tick;
    wire tx1;
    wire tx2;
    wire rx_done1;
    wire rx_done2;
    wire tx_start_res;
    wire [NB_BITS - 1:0] ParamRec;
    wire [NB_BITS - 1:0] A;
    wire [NB_BITS - 1:0] B;
    wire [NB_BITS - 1:0] OP;
    wire [NB_BITS - 1:0] RES;
    wire [NB_BITS - 1:0] resuRec;
    

    baudrategen #(
    .N_BITS(NB_BITS),
    .N_COUNT(N_COUNT)
    )
    u_baudrategen(
        .clock(clk),
        .reset(reset),
        .tick(tick)
    );

    uart_tx #(
    .DBIT(NB_BITS),
    .SB_TICK(16)
    )
    u_uart_tx1(
        .clk(clk),
        .reset(reset),
        .tx_start(tx_start),
        .s_tick(tick),
        .din(ParamEnviar),
        .tx_done_tick(),
        .tx(tx1)
    );

    uart_rx #(
        .NB_BIT(NB_BITS),
        .SB_TICK(16)
    )
    u_uart_rx2(
        .clk(clk),
        .reset(reset),
        .rx(tx1),
        .s_tick(tick),
        .rx_done_tick(rx_done2),
        .dout(ParamRec)
    );

    uart_interface #(
    .NB_BITS(NB_BITS)
    )
    u_uart_interface(
        .clk(clk),
        .reset(reset),
        .i_dato_Recv(ParamRec),
        .i_dato_Recv_valid(rx_done2),
        .o_tx_start(tx_start_res),
        .o_A(A),
        .o_B(B),
        .o_OP(OP)
    );

    ALU #(
    .N_BITS(NB_BITS),
    .N_LEDS(NB_BITS)
    )
    u_ALU(
        .o_res(RES),
        .i_A(A),
        .i_B(B),
        .i_Op(OP)
    );


    uart_tx #(
    .DBIT(NB_BITS),
    .SB_TICK(16)
    )
    u_uart_tx2(
        .clk(clk),
        .reset(reset),
        .tx_start(tx_start_res),
        .s_tick(tick),
        .din(RES),
        .tx_done_tick(),
        .tx(tx2)
    );


    uart_rx #(
    .NB_BIT(NB_BITS),
    .SB_TICK(16)
    )
    u_uart_rx1(
        .clk(clk),
        .reset(reset),
        .rx(tx2),
        .s_tick(tick),
        .rx_done_tick(datoListorti),
        .dout(RESULTADO)
    );


endmodule