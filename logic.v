module compare(input[7:0] a, b, output equal, greater, lesser);
  wire sign;
  assign equal = (a == b);
  assign greater = sign & ~equal;
  assign lesser = ~sign;

  subtract s(
    .a (a),
    .b (b),
    .c (),
    .sign (sign)
  );
endmodule
