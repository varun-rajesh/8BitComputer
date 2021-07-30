module counter(input clk, reset, input[7:0] limit, output[7:0] count);

  wire[7:0] n;
  wire[7:0] count_bar;
  wire[7:0] count_p;

  d_ff dff[7:0](
    .clk (clk),
    .d (n),
    .preset (1'b1),
    .clear (reset),
    .q (count),
    .q_bar (count_bar)
  );

  increment i(
    .in (count),
    .out (count_p)
  );

  byte_mux m(
    .a (8'b00000000),
    .b (count_p),
    .sel (count_p == limit),
    .out (n)
  );

endmodule

module increment(input[7:0] in, output[7:0] out);

  wire[7:0] flip;

  assign flip[0] = 1'b1;
  assign out[0] = flip[0] ^ in[0];

  assign flip[1] = flip[0] & in[0];
  assign out[1] = flip[1] ^ in[1];

  assign flip[2] = flip[1] & in[1];
  assign out[2] = flip[2] ^ in[2];

  assign flip[3] = flip[2] & in[2];
  assign out[3] = flip[3] ^ in[3];

  assign flip[4] = flip[3] & in[3];
  assign out[4] = flip[4] ^ in[4];

  assign flip[5] = flip[4] & in[4];
  assign out[5] = flip[5] ^ in[5];

  assign flip[6] = flip[5] & in[5];
  assign out[6] = flip[6] ^ in[6];

  assign flip[7] = flip[6] & in[6];
  assign out[7] = flip[7] ^ in[7];
endmodule
