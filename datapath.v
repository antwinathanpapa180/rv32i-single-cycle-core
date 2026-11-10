// 32-Bit Autonomous RISC-V Core
module datapath (
    input  wire        clk,
    input  wire        rst,
    output wire [31:0] pc_out,
    output wire [31:0] alu_result
);

    // Program Counter Logic
    reg [31:0] pc;
    always @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 32'b0;
        else
            pc <= pc + 32'd4; // Increment PC by 4 bytes
    end

    assign pc_out = pc;

    // Fetch Instruction from Memory
    wire [31:0] instruction;
    instruction_mem imem (
        .pc(pc),
        .instruction(instruction)
    );

    // Decoded Bit Fields
    wire [6:0] opcode   = instruction[6:0];
    wire [4:0] rd       = instruction[11:7];
    wire [2:0] funct3   = instruction[14:12];
    wire [4:0] rs1      = instruction[19:15];
    wire [4:0] rs2      = instruction[24:20];
    wire [6:0] funct7   = instruction[31:25];
    wire [31:0] imm_i   = {{20{instruction[31]}}, instruction[31:20]};

    // Internal Signals
    wire        reg_write;
    wire        alu_src;
    wire [2:0]  alu_control;
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] alu_in_b;
    wire        zero_flag;

    // Modules
    control_unit ctrl (
        .opcode(opcode), .funct3(funct3), .funct7(funct7),
        .reg_write(reg_write), .alu_src(alu_src), .alu_control(alu_control)
    );

    regfile32 rf (
        .clk(clk), .rst(rst), .reg_write(reg_write),
        .rs1_addr(rs1), .rs2_addr(rs2), .rd_addr(rd),
        .write_data(alu_result), .read_data1(read_data1), .read_data2(read_data2)
    );

    assign alu_in_b = (alu_src) ? imm_i : read_data2;

    alu32 alu (
        .a(read_data1), .b(alu_in_b), .alu_control(alu_control),
        .alu_result(alu_result), .zero(zero_flag)
    );

endmodule
