//

// Complex Multiplier (pr+i.pi) = (ar+i.ai)*(br+i.bi)

// file: cmult.v

module cmx_mult # (parameter AWIDTH = 16, BWIDTH = 16)

  (

    input clk,

    input reset_n,

    input signed [AWIDTH-1:0]      ar, ai,

    input signed [BWIDTH-1:0]      br, bi,

    output signed [AWIDTH+BWIDTH:0] pr, pi

  );

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, cmx_mult);
  end

  reg signed [AWIDTH-1:0] ai_d, ai_dd, ai_ddd, ai_dddd   ;

  reg signed [AWIDTH-1:0] ar_d, ar_dd, ar_ddd, ar_dddd   ;

  reg signed [BWIDTH-1:0] bi_d, bi_dd, bi_ddd, br_d, br_dd, br_ddd ;

  reg signed [AWIDTH:0]  addcommon     ;

  reg signed [BWIDTH:0]  addr, addi     ;

  reg signed [AWIDTH+BWIDTH:0] mult0, multr, multi, pr_int, pi_int  ;

  reg signed [AWIDTH+BWIDTH:0] common, commonr1, commonr2   ;


  always @(posedge clk or negedge reset_n)
  begin

    if (!reset_n)
    begin
      ar_d   <= 'h0;

      ar_dd  <= 'h0;

      ai_d   <= 'h0;

      ai_dd  <= 'h0;

      br_d   <= 'h0;

      br_dd  <= 'h0;

      br_ddd <= 'h0;

      bi_d   <= 'h0;

      bi_dd  <= 'h0;

      bi_ddd <= 'h0;
    end

    else
    begin

      ar_d   <= ar;

      ar_dd  <= ar_d;

      ai_d   <= ai;

      ai_dd  <= ai_d;

      br_d   <= br;

      br_dd  <= br_d;

      br_ddd <= br_dd;

      bi_d   <= bi;

      bi_dd  <= bi_d;

      bi_ddd <= bi_dd;

    end

  end

  // Common factor (ar ai) x bi, shared for the calculations of the real and imaginary final products

  //

  always @(posedge clk or negedge reset_n)

  begin

    if (!reset_n)
    begin
      addcommon <= 'h0;

      mult0     <= 'h0;

      common    <= 'h0;
    end
    else
    begin
      addcommon <= ar_d - ai_d;

      mult0     <= addcommon * bi_dd;

      common    <= mult0;
    end



  end

  // Real product

  //

  always @(posedge clk or negedge reset_n)

  begin

    if (!reset_n)
    begin
      ar_ddd   <= 'h0;

      ar_dddd  <= 'h0;

      addr     <= 'h0;

      multr    <= 'h0;

      commonr1 <= 'h0;

      pr_int   <= 'h0;
    end
    else
    begin
      ar_ddd   <= ar_dd;

      ar_dddd  <= ar_ddd;

      addr     <= br_ddd - bi_ddd;

      multr    <= addr * ar_dddd;

      commonr1 <= common;

      pr_int   <= multr + commonr1;
    end



  end

  // Imaginary product

  //

  always @(posedge clk or negedge reset_n)

  begin

    if (!reset_n)
    begin
      ai_ddd   <= 'h0;

      ai_dddd  <= 'h0;

      addi     <= 'h0;

      multi    <= 'h0;

      commonr2 <= 'h0;

      pi_int   <= 'h0;
    end
    else
    begin
      ai_ddd   <= ai_dd;

      ai_dddd  <= ai_ddd;

      addi     <= br_ddd + bi_ddd;

      multi    <= addi * ai_dddd;

      commonr2 <= common;

      pi_int   <= multi + commonr2;
    end



  end

  assign pr = pr_int;

  assign pi = pi_int;

endmodule // cmult
