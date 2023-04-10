module cmx_add (
    input [31:0] a,
    input [31:0] b,
    input sub_flag,
    output [31:0] c
  );
  wire signed [15:0] a_real = a[15:0];
  wire signed [15:0] a_img = a[31:16];
  wire signed [15:0] b_real = b[15:0];
  wire signed [15:0] b_img = b[31:16];
  //   wire [15:0] c_real = c[15:0];
  //   wire [15:0] c_img = c[31:16];

  wire [15:0] c_real = (sub_flag)? (a_real - b_real):
       a_real + b_real;

  wire [15:0] c_img = (sub_flag)? (a_img - b_img):
       a_img + b_img;

  assign c = {c_img, c_real};     

endmodule
