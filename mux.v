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
