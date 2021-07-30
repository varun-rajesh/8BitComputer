module sb_register(input clk, enable_in, enable_out, reset, data, output out);
  wire q, q_bar;

  assign out = (enable_out) ? q : 1'bZ;

  d_ff dff(
    .clk (clk),
    .d ((enable_in & data) | (~enable_in & q)),
    .preset (1'b1),
    .clear (reset),
    .q (q),
    .q_bar (q_bar)
  );
endmodule

module byte_register(input clk, enable_in, enable_out, reset, input[7:0] data, output[7:0] out);

  sb_register sb[7:0](
    .clk (clk),
    .enable_in (enable_in),
    .enable_out (enable_out),
    .reset (reset),
    .data (data),
    .out (out)
  );

endmodule
