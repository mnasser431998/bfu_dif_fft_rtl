module cos_lut_wr (
    input  [7:0] phi,
    output signed [15:0] fcn_value
  );

  localparam ROM_DEPTH=64;    // number of entries in sine ROM for 0° to 90°
  localparam ROM_WIDTH=8;     // width of sine ROM data
  localparam ROM_FILE="~/Desktop/fft_pipeline/src/cos_table_64x8.txt";  // file to populate ROM
  localparam ADDRW=$clog2(4*ROM_DEPTH);  // full circle is 0° to 360°


  cos_lut #(
      .ROM_DEPTH(ROM_DEPTH),
      .ROM_WIDTH(ROM_WIDTH),
      .ROM_FILE(ROM_FILE)
  ) cos_table_inst (
      .id(phi),
      .data(fcn_value)
  );



endmodule