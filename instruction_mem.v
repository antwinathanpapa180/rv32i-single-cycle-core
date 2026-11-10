// Instruction Memory (ROM)
module instruction_mem (
    input  wire [31:0] pc,
    output wire [31:0] instruction
);

    reg [31:0] rom [0:63]; // 64-word instruction memory

    initial begin
        // Program Code (Autonomous Loop)
        rom[0] = 32'h00f00093; // addi x1, x0, 15  (x1 = 15)
        rom[1] = 32'h00a00113; // addi x2, x0, 10  (x2 = 10)
        rom[2] = 32'h002081b3; // add  x3, x1, x2  (x3 = 25)
        rom[3] = 32'h40218233; // sub  x4, x3, x2  (x4 = 15)
        rom[4] = 32'h0011f2b3; // and  x5, x3, x1  (x5 = 25 & 15 = 9)
    end

    // Fetch instruction based on word address (PC / 4)
    assign instruction = rom[pc[31:2]];

endmodule
