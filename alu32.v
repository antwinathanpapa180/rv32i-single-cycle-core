// 32-Bit Arithmetic Logic Unit (ALU)
module alu32 (
    input  wire [31:0] a,           // 32-bit Input Operand A
    input  wire [31:0] b,           // 32-bit Input Operand B
    input  wire [2:0]  alu_control, // 3-bit Operation Selector
    output reg  [31:0] alu_result,  // 32-bit Output Result
    output wire        zero         // Zero Flag (High if result == 0)
);

    // Combinational logic block for operations
    always @(*) begin
        case (alu_control)
            3'b000:  alu_result = a & b;                 // Bitwise AND
            3'b001:  alu_result = a | b;                 // Bitwise OR
            3'b010:  alu_result = a + b;                 // Addition
            3'b110:  alu_result = a - b;                 // Subtraction
            3'b111:  alu_result = (a < b) ? 32'd1 : 32'd0; // Set on Less Than
            3'b100:  alu_result = a ^ b;                 // Bitwise XOR
            default: alu_result = 32'd0;
        endcase
    end

    // Zero flag output: 1 if alu_result is 0, else 0
    assign zero = (alu_result == 32'd0) ? 1'b1 : 1'b0;

endmodule