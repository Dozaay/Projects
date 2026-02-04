// synchronous programable counter test bench
module SPC_tb();
    
    reg clk,rst;
    reg [1:0] sel;
    
    wire [2:0] cnt;
    
    
    sync_prog_cnt DUT(.rst(rst), .clk(clk), .sel(sel), .cnt(cnt));
    
    always #5 clk = ~clk;
    always #90 sel = sel+1;
    initial begin
        clk = 0;sel = 2'd0; rst = 0;
        repeat(1) @(posedge clk);
        rst = 1;
        #170 rst = 0;
        #5 rst = 1;
        //#85 rst = 0;
        //#5 rst = 1;
        #600 $finish;
    end
    initial $monitor($time, "clk=%b rst=%b sel=%b cnt=%b", clk, rst, sel, cnt);
endmodule
