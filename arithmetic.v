module add(input[7:0] a, b, output[7:0] c, output carry);

  wire[7:0] cout;

  sb_add sba0(
    .a (a[0]),
    .b (b[0]),
    .cin (1'b0),
    .c (c[0]),
    .cout (cout[0])
  );

  sb_add sba1(
    .a (a[1]),
    .b (b[1]),
    .cin (cout[0]),
    .c (c[1]),
    .cout (cout[1])
  );

  sb_add sba2(
    .a (a[2]),
    .b (b[2]),
    .cin (cout[1]),
    .c (c[2]),
    .cout (cout[2])
  );

  sb_add sba3(
    .a (a[3]),
    .b (b[3]),
    .cin (cout[2]),
    .c (c[3]),
    .cout (cout[3])
  );

  sb_add sba4(
    .a (a[4]),
    .b (b[4]),
    .cin (cout[3]),
    .c (c[4]),
    .cout (cout[4])
  );

  sb_add sba5(
    .a (a[5]),
    .b (b[5]),
    .cin (cout[4]),
    .c (c[5]),
    .cout (cout[5])
  );

  sb_add sba6(
    .a (a[6]),
    .b (b[6]),
    .cin (cout[5]),
    .c (c[6]),
    .cout (cout[6])
  );

  sb_add sba7(
    .a (a[7]),
    .b (b[7]),
    .cin (cout[6]),
    .c (c[7]),
    .cout (carry)
  );
endmodule

module sb_add(input a, b, cin, output c, cout);
  assign c = cin ^ (a ^ b);
  assign cout = (cin & (a ^ b)) | (a & b);
endmodule

module subtract(input[7:0] a, b, output[7:0] c, output sign);
  wire[7:0] b_p;
  wire carry;

  add a0(
    .a (~b),
    .b (8'b1),
    .c (b_p),
    .carry (carry)
  );

  add a1(
    .a (a),
    .b (b_p),
    .c (c),
    .carry (sign)
  );
endmodule
