// Copyright (C) 2023  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 22.1std.1 Build 917 02/14/2023 SC Lite Edition"
// CREATED		"Thu Dec  5 16:49:48 2024"

module toplvl(
	Reset,
	CLK_50MHz,
	Bin,
	Gin,
	Rin,
	Hsync,
	Vsync,
	RGBout
);


input wire	Reset;
input wire	CLK_50MHz;
input wire	[1:0] Bin;
input wire	[1:0] Gin;
input wire	[1:0] Rin;
output wire	Hsync;
output wire	Vsync;
output wire	[11:0] RGBout;

wire	[15:0] address;
wire	[11:0] BGNDRGB;
wire	CLK;
wire	CompAND;
wire	[9:0] DisplayColumn;
wire	[9:0] DisplayRow;
wire	[11:0] muxtoVGA;
wire	RST;
wire	[15:0] spriteout;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;





VGA_Driver	b2v_inst(
	.CLK_50MHz(CLK),
	.Reset(RST),
	.RGBin(muxtoVGA),
	.Hsync(Hsync),
	.Vsync(Vsync),
	.DisplayColumn(DisplayColumn),
	.DisplayRow(DisplayRow),
	.RGBout(RGBout));


comparator	b2v_inst1(
	.a(DisplayRow),
	
	
	.lt(SYNTHESIZED_WIRE_1)
	
	
	);
	defparam	b2v_inst1.b = 256;
	defparam	b2v_inst1.N = 10;


comparator	b2v_inst10(
	.a(DisplayColumn),
	
	
	.lt(SYNTHESIZED_WIRE_0)
	
	
	);
	defparam	b2v_inst10.b = 328;
	defparam	b2v_inst10.N = 10;


rom1	b2v_inst11(
	.clock(CLK),
	.address(address),
	.q(spriteout));


address_converter	b2v_inst12(
	.column(DisplayColumn),
	.row(DisplayRow),
	.address(address));
	defparam	b2v_inst12.N = 16;
	defparam	b2v_inst12.ROWVALUE = 256;


muxN	b2v_inst15(
	.s(CompAND),
	.d0(BGNDRGB),
	.d1(spriteout[11:0]),
	.y(muxtoVGA));
	defparam	b2v_inst15.N = 12;


decoder2_4	b2v_inst3(
	.a(Rin),
	.y(BGNDRGB[11:8]));


decoder2_4	b2v_inst4(
	.a(Gin),
	.y(BGNDRGB[7:4]));


decoder2_4	b2v_inst5(
	.a(Bin),
	.y(BGNDRGB[3:0]));

assign	CompAND = SYNTHESIZED_WIRE_0 & SYNTHESIZED_WIRE_1;

assign	CLK = CLK_50MHz;
assign	RST = Reset;

endmodule
