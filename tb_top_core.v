`timescale 1ns / 1ns

module tb_top_core;

    reg        clk;
    reg        rst;
    wire [31:0] pc_out;
    wire [31:0] alu_result;

    datapath uut (
        .clk(clk),
        .rst(rst),
        .pc_out(pc_out),
        .alu_result(alu_result)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("top_core.vcd");
        $dumpvars(0, tb_top_core);

        clk = 0; rst = 1; #10;
        rst = 0; #60;

        $finish;
    end

endmodule