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
// CREATED		"Thu Dec  5 14:09:57 2024"

module VGA_Driver(
	Reset,
	CLK_50MHz,
	RGBin,
	Hsync,
	Vsync,
	DisplayColumn,
	DisplayRow,
	RGBout
);


input wire	Reset;
input wire	CLK_50MHz;
input wire	[11:0] RGBin;
output wire	Hsync;
output wire	Vsync;
output wire	[9:0] DisplayColumn;
output wire	[9:0] DisplayRow;
output wire	[11:0] RGBout;

wire	CLK;
wire	HD;
wire	RST;
wire	VD;
reg	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	[0:11] SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;

assign	SYNTHESIZED_WIRE_2 = 0;





SyncCount	b2v_inst1(
	.clk_25MHz(SYNTHESIZED_WIRE_4),
	.rst(SYNTHESIZED_WIRE_0),
	.Hsync(Hsync),
	.Vsync(Vsync),
	.Hdisplay(HD),
	.Vdisplay(VD),
	.DisplayColumn(DisplayColumn),
	.DisplayRow(DisplayRow));
	defparam	b2v_inst1.HbackPorch = 48;
	defparam	b2v_inst1.HdisplayArea = 640;
	defparam	b2v_inst1.HfrontPorch = 16;
	defparam	b2v_inst1.HsyncPulse = 96;
	defparam	b2v_inst1.VbackPorch = 33;
	defparam	b2v_inst1.VdisplayArea = 480;
	defparam	b2v_inst1.VfrontPorch = 10;
	defparam	b2v_inst1.VsyncPulse = 2;

assign	SYNTHESIZED_WIRE_3 =  ~SYNTHESIZED_WIRE_4;


muxN	b2v_inst3(
	.s(SYNTHESIZED_WIRE_1),
	.d0(SYNTHESIZED_WIRE_2),
	.d1(RGBin),
	.y(RGBout));
	defparam	b2v_inst3.N = 12;

assign	SYNTHESIZED_WIRE_0 =  ~RST;

assign	SYNTHESIZED_WIRE_1 = HD & VD;


always@(posedge CLK or negedge RST)
begin
if (!RST)
	begin
	SYNTHESIZED_WIRE_4 <= 0;
	end
else
	begin
	SYNTHESIZED_WIRE_4 <= SYNTHESIZED_WIRE_3;
	end
end

assign	RST = Reset;
assign	CLK = CLK_50MHz;

endmodule
