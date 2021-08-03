`include "flops.v"
`include "latches.v"
`include "register.v"
`include "counter.v"
`include "mux.v"
`include "arithmetic.v"
`include "logic.v"
`include "alu.v"
`include "stack.v"
`include "memory.v"
`include "computer.v"

module testbench;

  reg[2047:0] code;
  reg reset, clk;

  always begin
    #10 clk = ~clk;
  end

  initial begin

    $dumpfile("testbench.vcd");
    $dumpvars;

    clk = 0;
    code = {8'ha8, 8'h12, 8'h01, 8'h00, 8'h09, 8'h03, 8'h06, 8'h10, 8'hee, 8'h06, 8'h0f, 8'h02, 8'h00, 8'h0e, 8'h03, 8'h0c, 8'h03, 8'h42, 8'he7, 8'h08, 8'h03, 8'h00, 8'h01, 8'h03, 8'h01, 8'h0d, 8'h00, 8'h0d, 8'h01, 8'h0c, 8'h00, 8'h0c, 8'hfe, 8'h00, 8'h01, 8'h44, 8'h01, 8'h01};
    reset = 0;
    #1 reset = 1;

    #4000 $finish;
  end

  computer computer(clk, reset, code);

endmodule
