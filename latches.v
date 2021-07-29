//set, reset, preset, clear are active low
module sr_latch(input set, reset, preset, clear, output q, q_bar);
  assign q = ~(set & preset & q_bar);
  assign q_bar = ~(reset & clear & q);
endmodule

//enable, set, and reset are active high; preset and clear are active low
module gated_sr_latch(input enable, set, reset, preset, clear, output q, q_bar);
  sr_latch sr(
      .set (~(set & enable)),
      .reset (~(reset & enable)),
      .preset (preset),
      .clear (clear),
      .q (q),
      .q_bar (q_bar)
  );
endmodule
