localparam int N = 8;
localparam int CLK_FREQ = 50 000 000;
localparam int BR = 9600

logic i_clk = 0;
always #10 i_clk = ~i_clk;

uart_if #(
    .CLK_FREQ(CLK_FREQ), 
    .BR(BR), 
    .N(N)
    ) if(
    .i_clk(i_clk));

uart_tx_rtl #(
    .N(N),
    .BR(BR), 
    .CLK_FREQ(CLK_FREQ) 
    ) DUT(
    .i_data(if.i_data),
    .dv(if.dv),
    .rst(if.rst),
    .i_clk(i_clk),       
    .tx(if.tx),
    .tx_done(if.tx_done),
    .tx_ready(if.tx_ready)
    );
