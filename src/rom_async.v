module rom_async (
	addr,
	data
);
	parameter WIDTH = 8;
	parameter DEPTH = 256;
	parameter INIT_F = "";
	localparam ADDRW = $clog2(DEPTH);
	input wire [ADDRW - 1:0] addr;
	output reg [WIDTH - 1:0] data;
	reg [WIDTH - 1:0] memory [0:DEPTH - 1];
	initial begin
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < DEPTH; i = i + 1)
				memory[i] = i;
		end
		//if (INIT_F != 0) begin
			$display("Creating rom_async from init file '%s'.", INIT_F);
			$readmemh(INIT_F, memory);
		//end
	end
	always @(*) data = memory[addr];
endmodule