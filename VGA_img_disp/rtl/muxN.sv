module muxN#(
             parameter N = 4  // Default value for N is 4
            )(
             input  logic [N-1:0] d0, d1,  // N input lines
             input  logic s,  		// Single bit selector
            
             output logic [N-1:0]y  // Output
            );

    always_comb begin
        y = s ? d1 : d0;  // Select the input based on the selector value
    end
endmodule
