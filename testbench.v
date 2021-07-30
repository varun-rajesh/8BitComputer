`include "flops.v"
`include "latches.v"
`include "register.v"
`include "counter.v"
`include "mux.v"
`include "arithmetic.v"

module testbench;

  reg[7:0] a, b;
  wire sign;
  wire[7:0] c;


  // always begin
  //   #10 clk = ~clk;
  // end

  initial begin

    $dumpfile("testbench.vcd");
    $dumpvars;

    a = 8'h6f;
    b = 8'had;

    // #1 reset = 1;

    #10000 $finish;
  end

  subtract s(a, b, c, sign);

endmodule
