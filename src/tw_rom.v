module tw_rom #(parameter ROM_DEPTH = 4,
                  parameter ROM_WIDTH = 32,
                  parameter ROM_FILE = "tw_rom.mem",
                  parameter A_WIDTH = $clog2(ROM_DEPTH)

                 ) (
                   input [A_WIDTH-1:0] addr,
                   output  signed [15:0] tw_real,
                   output  signed [15:0] tw_img
                 );

  // parameter ROM_DEPTH = 8;
  // parameter ROM_WIDTH = 32;
  // parameter ROM_FILE = "/home/mnasser431998/Desktop/fft_pipeline/src/tw_rom.mem";

  rom_async #(
              .WIDTH(ROM_WIDTH),
              .DEPTH(ROM_DEPTH),
              .INIT_F(ROM_FILE)
            ) tw_rom(
              .addr(addr),
              .data({tw_img, tw_real})
            );

endmodule
