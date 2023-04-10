`timescale 1ns / 1ps

module tw_calc(
    input [7:0] k_up,
    input [7:0] n_down,
    output signed [15:0] tw_real,
    output signed [15:0] tw_img
    );

wire [7:0] div_val = (n_down=='d1)?   'd0 :  
                     (n_down=='d2)?   'd1 :
                     (n_down=='d4)?   'd2 :
                     (n_down=='d8)?   'd3 :
                     (n_down=='d16)?  'd4 :
                     (n_down=='d32)?  'd5 :
                     (n_down=='d64)?  'd6 :
                     (n_down=='d128)? 'd7 :
                     (n_down=='d256)? 'd8 :  'h0;


                     
//wire signed [7:0] phi_tw_real_pre = ('d256 * k_up) >> div_val;  // cosine from sine
wire signed [7:0] phi = ('d256 * k_up) >> div_val;   // sine normal
//wire signed [7:0] phi_tw_real = 'h64 - phi_tw_real_pre;
wire signed [15:0] tw_img_tmp;
  
    
// cos
cos_lut_wr dev1(
    .phi(phi),
    .fcn_value(tw_real)
);

// j * sine
sine_lut_wr dev2(
    .phi(phi),
    .fcn_value(tw_img_tmp)
);

assign tw_img = -tw_img_tmp;
    
endmodule



