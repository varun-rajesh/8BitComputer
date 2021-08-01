module mux(input a, b, sel, output out);
  assign out = (sel & a) | (~sel & b);
endmodule

module byte_mux(input[7:0] a, b, input sel, output[7:0] out);
  mux mux[7:0](
    .a (a),
    .b (b),
    .sel (sel),
    .out (out)
  );
endmodule

//sel0 = 1: a or c; sel1 = 1: a or b
module quad_byte_mux(input[7:0] a, b, c, d, input sel0, sel1, output[7:0] out);
  wire[7:0] mux0_p, mux1_p;

  byte_mux mux0(
    .a (a),
    .b (b),
    .sel (sel0),
    .out (mux0_p)
  );

  byte_mux mux1(
    .a (c),
    .b (d),
    .sel (sel0),
    .out (mux1_p)
  );

  byte_mux mux2(
    .a (mux0_p),
    .b (mux1_p),
    .sel (sel1),
    .out (out)
  );

endmodule
