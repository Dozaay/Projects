//UART TX interface

interface uart_if 
    #(parameter int CLK_FREQ = 50 000 000, 
      parameter int BR = 9600;
      parameter int N = 8;
      )(input logic i_clk);
    logic rst, dv; // inputs of DUT
    logic [N-1:0] i_data; // input data of DUT
    logic tx, tx_ready, tx_done; // output of DUT
    localparam int clk_per_b = CLK_FREQ/BR; 
    clocking cb@(posedge i_clk)
        input tx, tx_ready, tx_done; // TB -> DUT
        output i_data, rst, dv; // DUT -> TB
    endclocking
endinterface 
    
