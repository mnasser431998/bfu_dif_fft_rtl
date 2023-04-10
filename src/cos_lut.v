module cos_lut (
	id,
	data
);
	parameter ROM_DEPTH = 64;
	parameter ROM_WIDTH = 8;
	parameter ROM_FILE = "~/Desktop/fft_pipeline/src/cos_table_64x8.txt";
	parameter ADDRW = $clog2(4 * ROM_DEPTH);
	input wire [ADDRW - 1:0] id;
	output reg signed [(2 * ROM_WIDTH) - 1:0] data;
	reg [$clog2(ROM_DEPTH) - 1:0] tab_id;
	wire [ROM_WIDTH - 1:0] tab_data;
	rom_async #(
		.WIDTH(ROM_WIDTH),
		.DEPTH(ROM_DEPTH),
		.INIT_F(ROM_FILE)
	) sine_rom(
		.addr(tab_id),
		.data(tab_data)
	);
	reg [1:0] quad;
	always @(*) begin
		quad = id[ADDRW - 1:ADDRW - 2];
		case (quad)
			2'b00: tab_id = id[ADDRW - 3:0];
			2'b01: tab_id = (2 * ROM_DEPTH) - id[ADDRW - 3:0];
			2'b10: tab_id = id[ADDRW - 3:0] - (2 * ROM_DEPTH);
			2'b11: tab_id = (4 * ROM_DEPTH) - id[ADDRW - 3:0];
		endcase
	end
	always @(*)
		if (id == 0)
			data = {{ROM_WIDTH - 1 {1'b0}}, 1'b1, {ROM_WIDTH {1'b0}}};
		else if (id == (2 * ROM_DEPTH))
			data = {{ROM_WIDTH {1'b1}}, {ROM_WIDTH {1'b0}}};
		else if (id == ROM_DEPTH)
			data = {2 * ROM_WIDTH {1'b0}};
		else if (id == (3 * ROM_DEPTH))
			data = {2 * ROM_WIDTH {1'b0}};
		else if ((quad == 'd3) || (quad == 'd0))
			data = {{ROM_WIDTH {1'b0}}, tab_data};
		else
			data = {2 * ROM_WIDTH {1'b0}} - {{ROM_WIDTH {1'b0}}, tab_data};
endmodule