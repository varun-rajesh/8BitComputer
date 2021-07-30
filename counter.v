module counter(input clk, reset, input[7:0] limit, output[7:0] count);

  wire[7:0] n;
  wire[7:0] count_bar;
  wire[7:0] count_p;
  wire carry;

  d_ff dff[7:0](
    .clk (clk),
    .d (n),
    .preset (1'b1),
    .clear (reset),
    .q (count),
    .q_bar (count_bar)
  );

  add a(
    .a (count),
    .b (8'b1),
    .c (count_p),
    .carry (carry)
  );

  byte_mux m(
    .a (8'b00000000),
    .b (count_p),
    .sel (count_p == limit),
    .out (n)
  );

endmodule
