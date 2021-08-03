module computer(input clk, reset, input[2047:0] code);

  wire[7:0] code_pointer;
  wire[7:0] instruction, instruction_out;
  wire[7:0] operand1_out, operand2_out;
  wire[7:0] instruction_count;
  wire[7:0] instruction_limit;
  reg[7:0] current_instruction_limit;
  wire instruction_enable_in;
  wire operand1_enable_in, operand2_enable_in;

  reg[7:0] bus;
  wire[7:0] bus_out;

  wire[7:0] instruction_limit_out;

  reg a_enable_in, a_enable_out;
  reg b_enable_in, b_enable_out;
  reg c_enable_in, c_enable_out;
  reg d_enable_in, d_enable_out;

  reg alu_a_enable_in, alu_b_enable_in, alu_c_enable_out, flags_enable_in;
  reg stack_write_enable, stack_read_enable;

  assign instruction[0] = code[{code_pointer, 3'b000}];
  assign instruction[1] = code[{code_pointer, 3'b001}];
  assign instruction[2] = code[{code_pointer, 3'b010}];
  assign instruction[3] = code[{code_pointer, 3'b011}];
  assign instruction[4] = code[{code_pointer, 3'b100}];
  assign instruction[5] = code[{code_pointer, 3'b101}];
  assign instruction[6] = code[{code_pointer, 3'b110}];
  assign instruction[7] = code[{code_pointer, 3'b111}];

  assign instruction_enable_in = (instruction_count == 8'b0);
  assign operand1_enable_in = (instruction_count == 8'b1);
  assign operand2_enable_in = (instruction_count == 8'b10);

  always @ * begin
    $display("t=%0t, instruction=%h, instruction_out=%h, a_enable_in=%b", $time, instruction, instruction_out, a_enable_in);
  end

  always @ * begin
    case(instruction)
      8'h00: current_instruction_limit <= 8'h01;
      8'h01: current_instruction_limit <= 8'h03;
      8'h02: current_instruction_limit <= 8'h03;
      8'h03: current_instruction_limit <= 8'h04;
      8'h04: current_instruction_limit <= 8'h04;
      8'h05: current_instruction_limit <= 8'h04;
      8'h06: current_instruction_limit <= 8'h04;
      8'h07: current_instruction_limit <= 8'h04;
      8'h08: current_instruction_limit <= 8'h04;
      8'h09: current_instruction_limit <= 8'h03;
      8'h0a: current_instruction_limit <= 8'h03;
      8'h0b: current_instruction_limit <= 8'h03;
      8'h0c: current_instruction_limit <= 8'h02;
      8'h0d: current_instruction_limit <= 8'h02;
      8'h0e: current_instruction_limit <= 8'h03;
      8'h0f: current_instruction_limit <= 8'h03;
      default: current_instruction_limit <= 8'h01;
    endcase
  end

  //ain
  always @ * begin
    case(instruction_out)
      8'h01, 8'h02: begin
        a_enable_in <= (instruction_count == 8'h02 & operand1_out == 8'h00) ? 1'b1 : 1'b0;
      end
      8'h03, 8'h04, 8'h05, 8'h06, 8'h07, 8'h08: begin
        a_enable_in <= (instruction_count == 8'h03 & instruction == 8'h00) ? 1'b1 : 1'b0;
      end
      8'h0d: begin
        a_enable_in <= (instruction_count == 8'h01 & instruction == 8'h00) ? 1'b1 : 1'b0;
      end
      8'h10: begin
        a_enable_in <= (instruction_count == 8'h02 & instruction == 8'h00) ? 1'b1 : 1'b0;
      end
      8'h00, 8'h09, 8'h0a, 8'h0b, 8'h0c, 8'h0e, 8'h0f: begin
        a_enable_in <= 1'b0;
      end
      default: a_enable_in = 1'b0;
    endcase
  end

  //aout
  always @ * begin
    case(instruction_out)
      8'h02, 8'h0e: begin
        a_enable_out <= (instruction_count == 8'h02 & instruction == 8'h00) ? 1'b1 : 1'b0;
      end
      8'h03, 8'h06, 8'h09: begin
        a_enable_out <= ((instruction_count == 8'h01 | instruction_count == 8'h02) & instruction == 8'h00) ? 1'b1 : 1'b0;
      end
      8'h04, 8'h07, 8'h0a, 8'h0c: begin
        a_enable_out <= (instruction_count == 8'h01 & instruction == 8'h00) ? 1'b1 : 1'b0;
      end
      8'h00, 8'h01, 8'h05, 8'h08, 8'h0b, 8'h0d, 8'h0f, 8'h10: begin
        a_enable_out <= 1'b0;
      end
      default: a_enable_out = 1'b0;
    endcase
  end

  //bin
  always @ * begin
    case(instruction_out)
      8'h01, 8'h02: begin
        b_enable_in <= (instruction_count == 8'h02 & operand1_out == 8'h01) ? 1'b1 : 1'b0;
      end
      8'h03, 8'h04, 8'h05, 8'h06, 8'h07, 8'h08: begin
        b_enable_in <= (instruction_count == 8'h03 & instruction == 8'h01) ? 1'b1 : 1'b0;
      end
      8'h0d: begin
        b_enable_in <= (instruction_count == 8'h01 & instruction == 8'h01) ? 1'b1 : 1'b0;
      end
      8'h10: begin
        b_enable_in <= (instruction_count == 8'h02 & instruction == 8'h01) ? 1'b1 : 1'b0;
      end
      8'h00, 8'h09, 8'h0a, 8'h0b, 8'h0c, 8'h0e, 8'h0f: begin
        b_enable_in <= 1'b0;
      end
      default: b_enable_in = 1'b0;
    endcase
  end

  //bout
  always @ * begin
    case(instruction_out)
      8'h02, 8'h0e: begin
        b_enable_out <= (instruction_count == 8'h02 & instruction == 8'h01) ? 1'b1 : 1'b0;
      end
      8'h03, 8'h06, 8'h09: begin
        b_enable_out <= ((instruction_count == 8'h01 | instruction_count == 8'h02) & instruction == 8'h01) ? 1'b1 : 1'b0;
      end
      8'h04, 8'h07, 8'h0a, 8'h0c: begin
        b_enable_out <= (instruction_count == 8'h01 & instruction == 8'h01) ? 1'b1 : 1'b0;
      end
      8'h00, 8'h01, 8'h05, 8'h08, 8'h0b, 8'h0d, 8'h0f, 8'h10: begin
        b_enable_out <= 1'b0;
      end
      default: b_enable_out = 1'b0;
    endcase
  end

  //cin
  always @ * begin
    case(instruction_out)
      8'h01, 8'h02: begin
        c_enable_in <= (instruction_count == 8'h02 & operand1_out == 8'h02) ? 1'b1 : 1'b0;
      end
      8'h03, 8'h04, 8'h05, 8'h06, 8'h07, 8'h08: begin
        c_enable_in <= (instruction_count == 8'h03 & instruction == 8'h02) ? 1'b1 : 1'b0;
      end
      8'h0d: begin
        c_enable_in <= (instruction_count == 8'h01 & instruction == 8'h02) ? 1'b1 : 1'b0;
      end
      8'h10: begin
        c_enable_in <= (instruction_count == 8'h02 & instruction == 8'h02) ? 1'b1 : 1'b0;
      end
      8'h00, 8'h09, 8'h0a, 8'h0b, 8'h0c, 8'h0e, 8'h0f: begin
        c_enable_in <= 1'b0;
      end
      default: c_enable_in = 1'b0;
    endcase
  end

  //cout
  always @ * begin
    case(instruction_out)
      8'h02, 8'h0e: begin
        c_enable_out <= (instruction_count == 8'h02 & instruction == 8'h02) ? 1'b1 : 1'b0;
      end
      8'h03, 8'h06, 8'h09: begin
        c_enable_out <= ((instruction_count == 8'h01 | instruction_count == 8'h02) & instruction == 8'h02) ? 1'b1 : 1'b0;
      end
      8'h04, 8'h07, 8'h0a, 8'h0c: begin
        c_enable_out <= (instruction_count == 8'h01 & instruction == 8'h02) ? 1'b1 : 1'b0;
      end
      8'h00, 8'h01, 8'h05, 8'h08, 8'h0b, 8'h0d, 8'h0f, 8'h10: begin
        c_enable_out <= 1'b0;
      end
      default: c_enable_out = 1'b0;
    endcase
  end

  //din
  always @ * begin
    case(instruction_out)
      8'h01, 8'h02: begin
        d_enable_in <= (instruction_count == 8'h02 & operand1_out == 8'h03) ? 1'b1 : 1'b0;
      end
      8'h03, 8'h04, 8'h05, 8'h06, 8'h07, 8'h08: begin
        d_enable_in <= (instruction_count == 8'h03 & instruction == 8'h03) ? 1'b1 : 1'b0;
      end
      8'h0d: begin
        d_enable_in <= (instruction_count == 8'h01 & instruction == 8'h03) ? 1'b1 : 1'b0;
      end
      8'h10: begin
        d_enable_in <= (instruction_count == 8'h02 & instruction == 8'h03) ? 1'b1 : 1'b0;
      end
      8'h00, 8'h09, 8'h0a, 8'h0b, 8'h0c, 8'h0e, 8'h0f: begin
        d_enable_in <= 1'b0;
      end
      default: d_enable_in = 1'b0;
    endcase
  end

  //dout
  always @ * begin
    case(instruction_out)
      8'h02, 8'h0e: begin
        d_enable_out <= (instruction_count == 8'h02 & instruction == 8'h03) ? 1'b1 : 1'b0;
      end
      8'h03, 8'h06, 8'h09: begin
        d_enable_out <= ((instruction_count == 8'h01 | instruction_count == 8'h02) & instruction == 8'h03) ? 1'b1 : 1'b0;
      end
      8'h04, 8'h07, 8'h0a, 8'h0c: begin
        d_enable_out <= (instruction_count == 8'h01 & instruction == 8'h03) ? 1'b1 : 1'b0;
      end
      8'h00, 8'h01, 8'h05, 8'h08, 8'h0b, 8'h0d, 8'h0f, 8'h10: begin
        d_enable_out <= 1'b0;
      end
      default: d_enable_out = 1'b0;
    endcase
  end

  //bus
  always @ * begin
    case(instruction_out)
      8'h01, 8'h0f: begin
        bus <= instruction;
      end
      8'h04, 8'h07, 8'h0a, 8'h0f: begin
        bus <= (instruction_count == 8'h02) ? instruction : bus_out;
      end
      8'h05, 8'h08, 8'hb: begin
        bus <= (instruction_count == 8'h01 | instruction_count == 8'h02) ? instruction : bus_out;
      end
      8'h02, 8'h03, 8'h06, 8'h09, 8'h0c, 8'h0d, 8'h0e, 8'h10: begin
        bus <= bus_out;
      end
      default: bus <= bus_out;
    endcase
  end


  //alu_ain
  always @ * begin
    case(instruction_out)
      8'h03, 8'h04, 8'h05, 8'h06, 8'h07, 8'h08: begin
        alu_a_enable_in <= (instruction_count == 8'h01) ? 1'b1 : 1'b0;
      end
      8'h00, 8'h01, 8'h02, 8'h09, 8'h0a, 8'h0b, 8'h0c, 8'h0d, 8'h0e, 8'h0f, 8'h10: begin
        alu_a_enable_in <= 1'b0;
      end
      default: alu_a_enable_in <= 1'b0;
    endcase
  end

  //alu_bin
  always @ * begin
    case(instruction_out)
      8'h03, 8'h04, 8'h05, 8'h06, 8'h07, 8'h08: begin
        alu_b_enable_in <= (instruction_count == 8'h02) ? 1'b1 : 1'b0;
      end
      8'h00, 8'h01, 8'h02, 8'h09, 8'h0a, 8'h0b, 8'h0c, 8'h0d, 8'h0e, 8'h0f, 8'h10: begin
        alu_b_enable_in <= 1'b0;
      end
      default: alu_b_enable_in <= 1'b0;
    endcase
  end

  //alu_cout
  always @ * begin
    case(instruction_out)
      8'h03, 8'h04, 8'h05, 8'h06, 8'h07, 8'h08: begin
        alu_c_enable_out <= (instruction_count == 8'h03) ? 1'b1 : 1'b0;
      end
      8'h00, 8'h01, 8'h02, 8'h09, 8'h0a, 8'h0b, 8'h0c, 8'h0d, 8'h0e, 8'h0f, 8'h10: begin
        alu_c_enable_out <= 1'b0;
      end
      default: alu_c_enable_out <= 1'b0;
    endcase
  end

  //stack_read_enable
  always @ * begin
    stack_read_enable <= (instruction_count == 8'h01 & instruction_out == 8'h0d) ? 1'b1 : 1'b0;
  end

  //stack_write_enable
  always @ * begin
    stack_write_enable <= (instruction_count == 8'h01 & instruction_out == 8'h0c) ? 1'b1 : 1'b0;
  end

  counter cp(
    .clk (clk),
    .reset (reset),
    .limit (8'hff),
    .count (code_pointer)
  );

  counter instruction_counter(
    .clk (clk),
    .reset (reset),
    .limit ((instruction_enable_in) ? current_instruction_limit: instruction_limit_out),
    .count (instruction_count)
  );

  byte_register instruction_reg(
    .clk (clk),
    .enable_in (instruction_enable_in),
    .enable_out (1'b1),
    .reset (reset),
    .data (instruction),
    .out (instruction_out)
  );

  byte_register instruction_limit_reg(
    .clk (clk),
    .enable_in (instruction_enable_in),
    .enable_out (1'b1),
    .reset (reset),
    .data (current_instruction_limit),
    .out (instruction_limit_out)
  );

  byte_register operand1_reg(
    .clk (clk),
    .enable_in (operand1_enable_in),
    .enable_out (1'b1),
    .reset (reset),
    .data (instruction),
    .out (operand1_out)
  );

  byte_register operand2_reg(
    .clk (clk),
    .enable_in (operand2_enable_in),
    .enable_out (1'b1),
    .reset (reset),
    .data (instruction),
    .out (operand2_out)
  );

  byte_register a_reg(
    .clk (clk),
    .enable_in (a_enable_in),
    .enable_out (a_enable_out),
    .reset (reset),
    .data (bus),
    .out (bus_out)
  );

  byte_register b_reg(
    .clk (clk),
    .enable_in (b_enable_in),
    .enable_out (b_enable_out),
    .reset (reset),
    .data (bus),
    .out (bus_out)
  );

  byte_register c_reg(
    .clk (clk),
    .enable_in (c_enable_in),
    .enable_out (c_enable_out),
    .reset (reset),
    .data (bus),
    .out (bus_out)
  );

  byte_register d_reg(
    .clk (clk),
    .enable_in (d_enable_in),
    .enable_out (d_enable_out),
    .reset (reset),
    .data (bus),
    .out (bus_out)
  );

  alu alu(
    .clk (clk),
    .a_enable_in (alu_a_enable_in),
    .b_enable_in (alu_b_enable_in),
    .c_enable_out (alu_c_enable_out),
    .flags_enable_in (flags_enable_in),
    .reset (reset),
    .operation (instruction_out),
    .in (bus),
    .out (bus_out),
    .equal (),
    .greater (),
    .lesser ()
  );

  stack stack(
    .clk (clk),
    .write_enable (stack_write_enable),
    .read_enable (stack_read_enable),
    .reset (reset),
    .bus (bus),
    .out (bus_out)
  );
endmodule
