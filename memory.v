module memory(input clk, read_enable, write_enable, reset, input[7:0] address, data, output[7:0] out);

  byte_register mem0(
    .clk (clk),
    .enable_in (write_enable & (address == 8'h00)),
    .enable_out (read_enable & (address == 8'h00)),
    .reset (reset),
    .data (data),
    .out (out)
  );

  byte_register mem1(
    .clk (clk),
    .enable_in (write_enable & (address == 8'h01)),
    .enable_out (read_enable & (address == 8'h01)),
    .reset (reset),
    .data (data),
    .out (out)
  );

  byte_register mem2(
    .clk (clk),
    .enable_in (write_enable & (address == 8'h02)),
    .enable_out (read_enable & (address == 8'h02)),
    .reset (reset),
    .data (data),
    .out (out)
  );

  byte_register mem3(
    .clk (clk),
    .enable_in (write_enable & (address == 8'h03)),
    .enable_out (read_enable & (address == 8'h03)),
    .reset (reset),
    .data (data),
    .out (out)
  );

  byte_register mem4(
    .clk (clk),
    .enable_in (write_enable & (address == 8'h04)),
    .enable_out (read_enable & (address == 8'h04)),
    .reset (reset),
    .data (data),
    .out (out)
  );

  byte_register mem5(
    .clk (clk),
    .enable_in (write_enable & (address == 8'h05)),
    .enable_out (read_enable & (address == 8'h05)),
    .reset (reset),
    .data (data),
    .out (out)
  );

  byte_register mem6(
    .clk (clk),
    .enable_in (write_enable & (address == 8'h06)),
    .enable_out (read_enable & (address == 8'h06)),
    .reset (reset),
    .data (data),
    .out (out)
  );

  byte_register mem7(
    .clk (clk),
    .enable_in (write_enable & (address == 8'h07)),
    .enable_out (read_enable & (address == 8'h07)),
    .reset (reset),
    .data (data),
    .out (out)
  );

  byte_register mem8(
    .clk (clk),
    .enable_in (write_enable & (address == 8'h08)),
    .enable_out (read_enable & (address == 8'h08)),
    .reset (reset),
    .data (data),
    .out (out)
  );
endmodule
