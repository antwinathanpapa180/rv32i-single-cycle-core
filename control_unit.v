// RISC-V Control Unit & Instruction Decoder
module control_unit (
    input  wire [6:0] opcode,      // Instruction Opcode [6:0]
    input  wire [2:0] funct3,      // Instruction Funct3 [14:12]
    input  wire [6:0] funct7,      // Instruction Funct7 [31:25]
    output reg        reg_write,   // Register File Write Enable
    output reg        alu_src,     // ALU Input B Source (0 = Reg, 1 = Immediate)
    output reg  [2:0] alu_control  // ALU Operation Selection
);

    always @(*) begin
        // Default control states
        reg_write   = 1'b0;
        alu_src     = 1'b0;
        alu_control = 3'b000;

        case (opcode)
            // R-Type Instructions (ADD, SUB, AND, OR, XOR, SLT)
            7'b0110011: begin
                reg_write = 1'b1;  // Write result back to register
                alu_src   = 1'b0;  // Use Register B input

                case (funct3)
                    3'b000: begin
                        if (funct7 == 7'b0100000)
                            alu_control = 3'b110; // SUB
                        else
                            alu_control = 3'b010; // ADD
                    end
                    3'b111: alu_control = 3'b000; // AND
                    3'b110: alu_control = 3'b001; // OR
                    3'b100: alu_control = 3'b100; // XOR
                    3'b010: alu_control = 3'b111; // SLT
                    default: alu_control = 3'b000;
                endcase
            end

            // I-Type Instructions (ADDI - Add Immediate)
            7'b0010011: begin
                reg_write = 1'b1;  // Write result back to register
                alu_src   = 1'b1;  // Use Immediate value for input B

                if (funct3 == 3'b000)
                    alu_control = 3'b010; // ADD
            end

            default: begin
                reg_write   = 1'b0;
                alu_src     = 1'b0;
                alu_control = 3'b000;
            end
        endcase
    end

endmodule
