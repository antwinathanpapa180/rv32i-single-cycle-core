// 32 x 32-bit RISC-V Register File
module regfile32 (
    input  wire        clk,           // System Clock
    input  wire        rst,           // Active-high Reset
    input  wire        reg_write,     // Write Enable Control Signal
    input  wire [4:0]  rs1_addr,      // Read Register 1 Address (0 to 31)
    input  wire [4:0]  rs2_addr,      // Read Register 2 Address (0 to 31)
    input  wire [4:0]  rd_addr,       // Write Register Address (0 to 31)
    input  wire [31:0] write_data,    // 32-bit Data to write into rd
    output wire [31:0] read_data1,    // 32-bit Data output from rs1
    output wire [31:0] read_data2     // 32-bit Data output from rs2
);

    // Array of 32 registers, each 32-bits wide
    reg [31:0] registers [31:0];
    integer i;

    // Async Read Logic: Register 0 is hardwired to 0
    assign read_data1 = (rs1_addr == 5'd0) ? 32'd0 : registers[rs1_addr];
    assign read_data2 = (rs2_addr == 5'd0) ? 32'd0 : registers[rs2_addr];

    // Synchronous Write Logic on Clock Edge
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all registers to 0
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'd0;
            end
        end else if (reg_write && (rd_addr != 5'd0)) begin
            // Write data to targeted register (skipping x0)
            registers[rd_addr] <= write_data;
        end
    end

endmodule