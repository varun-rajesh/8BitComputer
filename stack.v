module stack(input clk, write_enable, read_enable, reset, input[7:0] bus, output[7:0] out);

  wire[7:0] sp, mux_out, sp_plus, sp_minus, rw_sp;

  quad_byte_mux bm(
    .a (sp),
    .b (sp_minus),
    .c (sp_plus),
    .d (sp),
    .sel0 (write_enable),
    .sel1 (read_enable),
    .out (mux_out)
  );

  byte_mux rw_bm(
    .a (sp),
    .b (mux_out),
    .sel (write_enable),
    .out (rw_sp)
  );

  byte_register sp_reg(
    .clk (clk),
    .enable_in (write_enable | read_enable),
    .enable_out (1'b1),
    .reset (reset),
    .data (mux_out),
    .out (sp)
  );

  memory mem(
    .clk (clk),
    .read_enable (read_enable),
    .write_enable (write_enable),
    .reset (reset),
    .address (rw_sp),
    .data (bus),
    .out (out)
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
