module delay_buffer #(
    parameter  BIT_WIDTH = 32,
    parameter  DELAY_STAGES = 6
  ) (
    input clk,
    input reset_n,
    input [BIT_WIDTH-1:0] buf_in,
    output [BIT_WIDTH-1:0] buf_out
  );

  reg [BIT_WIDTH-1:0] r_stages [0:DELAY_STAGES-1];
  integer  i;

  always @(posedge clk or negedge reset_n)
  begin

    if (!reset_n)
    begin

      for (i=0; i<DELAY_STAGES; i=i+1)
      begin

        r_stages[i] <= 'h0;

      end

    end

    else
    begin

      r_stages[0] <= buf_in;

      for (i=0; i<(DELAY_STAGES-1); i=i+1)
      begin

        r_stages[i+1] <= r_stages[i];

      end

    end
  end

  assign buf_out = r_stages[DELAY_STAGES-1];

endmodule
