module d_ff(input clk, d, preset, clear, output q, q_bar);

  wire master_q;
  wire master_q_bar;

  gated_sr_latch master_gsr(
    .enable (clk),
    .set (d),
    .reset (~d),
    .preset (preset),
    .clear (clear),
    .q (master_q),
    .q_bar (master_q_bar)
  );

  gated_sr_latch slave_gsr(
    .enable (~clk),
    .set (master_q),
    .reset (master_q_bar),
    .preset (preset),
    .clear (clear),
    .q (q),
    .q_bar (q_bar)
  );
endmodule
