module bfu_dif_top
  #(parameter  Q_POINT = 8,
    parameter  TW_ROM_DEPTH = 4,
    parameter ADDR_W = $clog2(TW_ROM_DEPTH),
    parameter TW_ROM_FILE = "/home/mnasser431998/Desktop/fft_pipeline/src/tw_rom_p_8_st_1_q_8.mem")
   (
     input clk,
     input reset_n,
     input [31:0] a,
     input [31:0] b,
     input [ADDR_W-1:0] tw_addr,
     output [31:0] c_plus,
     output [31:0] c_minus
   );


  wire [31:0] c_plus_wire;
  wire [31:0] c_minus_wire;
  wire signed [15:0] c_minus_real = c_minus_wire[15:0];
  wire signed [15:0] c_minus_img = c_minus_wire[31:16];
  wire signed [32: 0] mult_result_real, mult_result_img;

  initial
  begin
    $dumpfile("wave.vcd");
    $dumpvars(0, bfu_dif_top);
  end

  bfu_internal internal_bfu_add_sub(
                 .a(a),
                 .b(b),
                 .c_plus(c_plus_wire),
                 .c_minus(c_minus_wire)
               );

  delay_buffer delay_buffer_plus_path (

                 .clk(clk),
                 .reset_n(reset_n),
                 .buf_in(c_plus_wire),
                 .buf_out(c_plus)
               );


  wire [15:0] tw_real_wire, tw_img_wire;

  // tw_calc twiddle_factor_generator(
  //           .k_up(tw_k_up),
  //           .n_down(tw_n_down),
  //           .tw_real(tw_real_wire),
  //           .tw_img(tw_img_wire)
  //         );

  tw_rom #(.ROM_DEPTH(TW_ROM_DEPTH),
           .ROM_FILE(TW_ROM_FILE))
         twiddle_factor_generator(
           .addr(tw_addr),
           .tw_real(tw_real_wire),
           .tw_img(tw_img_wire)
         );




  cmx_mult my_multiplier (

             .clk(clk),
             .reset_n(reset_n),

             .ar(c_minus_real),
             .ai(c_minus_img),

             .br(tw_real_wire),
             .bi(tw_img_wire),

             .pr(mult_result_real),
             .pi(mult_result_img)

           );

  wire signed [32:0] scaled_mult_real = (mult_result_real>>Q_POINT);
  wire signed [32:0] scaled_mult_img = (mult_result_img>>Q_POINT);
  assign c_minus = { scaled_mult_img[15:0],  scaled_mult_real[15:0]};



endmodule
