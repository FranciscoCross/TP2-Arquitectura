`timescale 10ns / 1ps

module tb_bdr;
localparam N_BITS = 8;
localparam N_COUNT = 163;
reg clk;
reg reset;
reg tick;
always #1 clk = ~clk;

initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    clk = 0;
    reset = 0;
    tick = 0;

    #1 reset = 1;

    #1 reset = 0;

end


baudrategen #(
    .N_BITS(N_BITS),
    .N_COUNT(N_COUNT)
)
u_baudrategen(
    .clock(clk),
    .reset(reset),
    .tick(tick)
);

endmodule
