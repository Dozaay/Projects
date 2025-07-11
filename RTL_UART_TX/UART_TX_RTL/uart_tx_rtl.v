
//BAUD_TICKS = SYS_CLK_FREQ/BAUD_RATE, 
module uart_tx_rtl
                //Params: bits per trans(B_PER_T = 8 by default),
                //... BAUD RATE(BR) = 9600 by default
                //... SYS_CLK_FREQ(CLK_FREQ)
                 #(parameter B_PER_T = 8, 
                   parameter BR = 9600, 
                   parameter CLK_FREQ)              
                //inputs: system clk,rst, n data inp, valid data inp,
                //ouputs: tx, tx_ready 
                  (input [B_PER_T-1:0] i_data,
                   input DV,
                   input i_clk,
                   output tx,
                   output tx_done);
    //FSM STATES 
    parameter START;
    parameter STOP;
    parameter IDLE;
    parameter DATA_BITS;

