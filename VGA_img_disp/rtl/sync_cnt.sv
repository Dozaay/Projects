module SyncCount (
    input wire clk_25MHz,   		// 25MHz clock input
    input wire rst,         		// Reset input
    output reg Hsync,       		// Horizontal synchronization output
    output reg Vsync,       		// Vertical synchronization output
    output reg Hdisplay,    		// Horizontal display output
    output reg Vdisplay,    		// Vertical display output
    output reg [9:0] DisplayColumn,	// Display Column output
    output reg [9:0] DisplayRow		// Display Row output
);

// Parameters for horizontal and vertical synchronization timing
parameter HsyncPulse = 96;     // Number of clock cycles for Hsync pulse width
parameter HbackPorch = 48;     // Number of clock cycles for horizontal back porch
parameter HdisplayArea = 640;  // Number of clock cycles for horizontal display area
parameter HfrontPorch = 16;    // Number of clock cycles for horizontal front porch
parameter Htotal = HsyncPulse + HbackPorch + HdisplayArea + HfrontPorch; // Total number of horizontal clock cycles

parameter VsyncPulse = 2;      // Number of lines for Vsync pulse width
parameter VbackPorch = 33;     // Number of lines for vertical back porch
parameter VdisplayArea = 480;  // Number of lines for vertical display area
parameter VfrontPorch = 10;    // Number of lines for vertical front porch
parameter Vtotal = VsyncPulse + VbackPorch + VdisplayArea + VfrontPorch; // Total number of vertical lines

// Internal counters for synchronization and display signals
reg [9:0] hCounter = 0;
reg [9:0] vCounter = 0;

always @(posedge clk_25MHz or posedge rst) begin
	if (rst) begin
		// Reset counters and synchronization signals
		hCounter <= 0;
		vCounter <= 0;
      Hsync <= 1;
		Vsync <= 1;
		Hdisplay <= 0;
		Vdisplay <= 0;
		DisplayColumn <= 0;
		DisplayRow <= 0;
	end else begin
		// Horizontal synchronization counter
		if (hCounter < Htotal - 1) begin
			hCounter <= hCounter + 1;
			end else begin
            hCounter <= 0;
            // Increment vertical counter at the end of each horizontal line
            if (vCounter < Vtotal - 1) begin
                vCounter <= vCounter + 1;
            end else begin
                vCounter <= 0;
            end
        end

        // Generate Hsync signal
        if (hCounter < HsyncPulse) begin
            Hsync <= 0;
        end else begin
            Hsync <= 1;
        end

        // Generate Vsync signal
        if (vCounter < VsyncPulse) begin
            Vsync <= 0;
        end else begin
            Vsync <= 1;
        end

        // Generate Hdisplay signal
        if ((hCounter >= (HsyncPulse + HbackPorch)) && (hCounter < (HsyncPulse + HbackPorch + HdisplayArea))) begin
            Hdisplay <= 1;
        end else begin
            Hdisplay <= 0;
        end

        // Generate Vdisplay signal
        if ((vCounter >= (VsyncPulse + VbackPorch)) && (vCounter < (VsyncPulse + VbackPorch + VdisplayArea))) begin
            Vdisplay <= 1;
        end else begin
            Vdisplay <= 0;
        end

	// Update DisplayColumn and DisplayRow based on counters
        DisplayColumn <= hCounter;
        DisplayRow <= vCounter;
    end
end

endmodule
