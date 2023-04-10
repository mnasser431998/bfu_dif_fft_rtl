module bfu_internal(
    input [31:0] a,
    input [31:0] b,
    output [31:0] c_plus,
    output [31:0] c_minus
  );

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
  end  

  cmx_add u0_cmx_add_plus(
    .a(a),
    .b(b),
    .sub_flag(1'h0),
    .c(c_plus)
  );


  cmx_add u1_cmx_add_minus(
    .a(a),
    .b(b),
    .sub_flag(1'h1),
    .c(c_minus)
  );




endmodule
