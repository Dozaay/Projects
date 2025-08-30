module address_converter #(parameter N = 16,ROWVALUE= 256)(
    input logic [9:0] row,      // 8-bit row input (0 to 255)
    input logic [9:0] column,   // 8-bit column input (0 to 255)
    output logic [N-1:0] address // 16-bit address output (0 to 65535)
);

    always_comb begin
        address = ((row) * ROWVALUE) + (column+144);
    end

endmodule
