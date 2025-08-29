//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//Description
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\



module uart_tx_rtl
                 #(parameter N = 8, // data bits 
                   parameter BR = 9600, // baud rate 
                   parameter CLK_FREQ = 50000000 // clock frequency in Hz              
                 )(
                   input [N-1:0] i_data, // data to be sent in LSB
                   input dv, // data valid 
                   input rst, // asycn reset, active H
                   input i_clk, 

                   output reg tx, // serial line 
                   output reg tx_done, // pulse 1 clk cycle after stop 
                   output tx_ready // high when idle 
               );
    
    // bit index of transmitted bits
    reg[$clog2(N)-1:0] bit_idx;
    

    //FSM STATES--------------------  
    localparam [2:0]
        IDLE = 3b'000, 
        START = 3b'001, 
        DATA_BITS = 3b'010, 
        STOP = 3b'011, 
        CLEANUP = 3b'100;

    reg [2:0] state; 
    reg [N - 1:0] shift; 
    assign tx_ready =  (state == IDLE);
    //------------------------------ 

    //BAUD TICKS-------------------- 
    localparam integer clk_per_b = CLK_FREQ/BR; // # of sys clk cycles that make up one bit (clk per bit) 
    localparam integer W = (clk_per_b <= 1) ? 1 : $clog2(clk_per_b); // 
    reg [W - 1:0] bd_cnt;
    wire bt =  (bd_cnt == clk_per_b - 1);
    //------------------------------

    // goes to next state or resets
    always @(posedge RST| posedge i_clk)
        begin 
            if (RST) 
                state <= IDLE;
                tx = 1b'1;
        end 
            case(state)

                IDLE:   begin
                    tx <= 1b'1; 
                    if (dv) begin 
                        shift <= i_data;
                        bit_idx <= 'd0;
                        state <= START;
                    end 
                end

                START:  begin 
                    tx <= 1'b0;
                    if (bt) begin
                        state <= DATA_BITS; 
                    end
                end 
                DATA_BITS:  begin
                    tx <= shift[0]; 
                    if (bt) begin 
                        shift <= {1'b0, shift[N-1:1]};
                        if (bit_idx == N-1) begin 
                            state <= STOP; 
                        end else begin  
                            bit_idx <= bit_idx + 1'b1;
                        end
                    end 
                end 
                STOP:   begin
                    tx <= 1b'1;
                    if (bt) begin
                        state <= CLEAN_UP;
                    end
                end

                CLEAN_UP:   
                begin    
                    tx_done <= 1'b1;
                    state <= IDLE;
                        
                end
                default:    state <= IDLE;
            endcase
        end
endmodule
