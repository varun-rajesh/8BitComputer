module alu(input clk, a_enable_in, b_enable_in, c_enable_out, reset, input[7:0] operation, input[7:0] in, output[7:0] out, output[3:0] flags);

  wire[7:0] a, b;
  wire[7:0] c_add, c_subtract;
  reg[7:0] out;

  always @ *
    if(operation == 8'h03 | operation == 8'h04 | operation == 8'h05) begin
      out = c_enable_out ? c_add : 8'bZZZZZZZZ;
    end
    else if(operation == 8'h06 | operation == 8'h07 | operation == 8'h08) begin
      out = c_enable_out ? c_subtract : 8'bZZZZZZZZ;
    end
  end

  byte_register a_reg(
    .clk (clk),
    .enable_in (a_enable_in),
    .enable_out (1'b1),
    .reset (reset),
    .data (in),
    .out (a)
  );

  byte_register b_reg(
    .clk (clk),
    .enable_in (b_enable_in),
    .enable_out (1'b1),
    .reset (reset),
    .data (in),
    .out (b)
  );

  add add(
    .a (a),
    .b (b),
    .c (c_add),
    .carry ()
  );

  subtract sub(
    .a (a),
    .b (b),
    .c (c_subtract),
    .sign ()
  );

endmodule
