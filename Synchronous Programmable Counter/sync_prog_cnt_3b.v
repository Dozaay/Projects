module sync_prog_cnt (
                    input rst, clk,
                    input [1:0] sel,
                    output [2:0] cnt

);

    // 8 states for each bit
    parameter   STATE_IDLE = 3'b000;
    parameter   STATE_001 = 3'b001;
    parameter   STATE_010 = 3'b010;
    parameter   STATE_011 = 3'b011;
    parameter   STATE_100 = 3'b100;
    parameter   STATE_101 = 3'b101;
    parameter   STATE_110 = 3'b110;
    parameter   STATE_111 = 3'b111;

//=========================STATE Registers==================================
    reg [2:0] CURR_STATE;
    reg [2:0] NEXT_STATE;
//===========================================================


//=========================RESET H=======================================
    always @(posedge clk) 
    begin
        if(~rst)
            CURR_STATE <= STATE_IDLE;
        else
            CURR_STATE <= NEXT_STATE;  
    end
//============================END of RESET ================================

//==========================FSM navigation==================================
    always @(*) 
    begin
        NEXT_STATE = CURR_STATE; 
        case(CURR_STATE)
            //here we see:
            //sel 11: 000->111
            //every thing else: 000->001
            STATE_IDLE: begin
                if(sel == 2'b11)
                    NEXT_STATE = STATE_111;
                else
                    NEXT_STATE = STATE_001;
            end
// here we see:
// sel 10: 001->011
// sel 00 & 01: 001-> 010
// sel 11 001->000 
            STATE_001: begin
                if(sel == 2'b10)
                    NEXT_STATE = STATE_011;
                else if(sel == 2'b11)
                    NEXT_STATE = STATE_IDLE;
                else
                    NEXT_STATE = STATE_010;
            end
// sel 00: 010 ->011
// sel 01: 010 -> 100
// sel 10: never in this state
// sel 11: 010 -> 001
            STATE_010: begin
                if(sel == 2'b00)
                    NEXT_STATE = STATE_011;
                else if (sel == 2'b11)
                    NEXT_STATE = STATE_001;
                else if(sel == 2'b01)
                    NEXT_STATE = STATE_100;
            end
// sel 00: 011 -> 100
// sel 01: never at this stage
// sel 10:  011-> 111
// sel 11: 011 -> 010
            STATE_011: begin
                if(sel == 2'b00)
                    NEXT_STATE = STATE_100;
                else if(sel == 2'b10)
                    NEXT_STATE = STATE_111;
                else if(sel == 2'b11)
                    NEXT_STATE = STATE_010;
            end

//sel 01:100 -> 001
// sel 11 : 100->011
//sel 00: 100->101
//sel 10 never reaches this state
            STATE_100: begin
                if(sel == 2'b00)
                    NEXT_STATE = STATE_101;
                else if(sel == 2'b01)
                    NEXT_STATE = STATE_001;
                else if(sel == 2'b11)
                    NEXT_STATE = STATE_011;

            end

// sel 00:  101->110
// sel 01:  never goes to this stage
// sel 10:  never goes to this stage
// sel 11:  101->100S
            STATE_101: begin
                if(sel == 2'b00)
                    NEXT_STATE = STATE_110;

                else if(sel == 2'b11)
                    NEXT_STATE = STATE_100;
            end

// sel 00:  110 -> 111
// sel 01: never goes to this stage 
// sel 10: never goes to this stage
// sel 11:  110->101
            STATE_110: begin 
                if(sel == 2'b00)
                    NEXT_STATE = STATE_111;
                else if(sel == 2'b11)
                    NEXT_STATE = STATE_101;
            end

// sel 00:  111->IDLE
// sel 01: never goes to this stage 
// sel 10:  111->001
// sel 11:  111->110
            STATE_111: begin

                    NEXT_STATE = STATE_IDLE;
                else if(sel == 2'b10)
                    NEXT_STATE = STATE_001;
                else if(sel == 2'b11)
                    NEXT_STATE = STATE_110;

            end
            default: NEXT_STATE = STATE_IDLE;
        endcase
    end

//==========================END of FSM navigation===========================

//==========================ASSIGN cnt to the state?===========================
    assign cnt = CURR_STATE;

endmodule

