module stack(input clk, write_enable, read_enable, reset, input[7:0] bus, output[7:0] out);

  wire[7:0] sp, mux_out, sp_plus, sp_minus;

  byte_mux bm(
    .a (sp_plus),
    .b (sp_minus),
    .sel (write_enable),
    .out (mux_out)
  );

  byte_register sp_reg(
    .clk (clk),
    .enable_in (write_enable | read_enable),
    .enable_out (1'b1),
    .reset (reset),
    .data (mux_out),
    .out (sp)
  );

  add add(
    .a (sp),
    .b (8'b1),
    .c (sp_plus),
    .carry ()
  );

  subtract sub(
    .a (sp),
    .b (8'b1),
    .c (sp_minus),
    .sign ()
  );
endmodule
