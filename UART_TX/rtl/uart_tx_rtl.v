
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
                   input RST
                   input i_clk,
                   output tx,
                   output tx_done);
    //FSM STATES 
    localparam IDLE = 3b'001; 
    localparam START = 3b'010; 
    localparam DATA_BITS = 3b'011;
    localparam STOP = 3b'100;
    localparam CLEANUP = 3b'101; 

    //BAUD TICKS 
    localparam integer bd = CLK_FREQ/BR;

    always @(posedge i_clk)
        begin 
            if (RST) begin
            
            end
           
            else begin
            case(){
                IDLE: begin
                
                end
                
                START: begin
                

                end

                DATA_BITS: begin
    
                end 

                STOP: begin 

                end

                CLEANUP: begin 

                end
            }
        end 
endmodule
