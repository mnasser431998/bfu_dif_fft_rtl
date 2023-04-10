module cos_lut #(
    parameter ROM_DEPTH=64,  // number of entries in sine ROM for 0° to 90°
    parameter ROM_WIDTH=8,   // width of sine ROM data in bits
    parameter ROM_FILE="cos_table_64x8",   // sine table file to populate ROM
    parameter ADDRW=$clog2(4*ROM_DEPTH)  // full circle is 0° to 360°
    ) (
    input  wire logic [ADDRW-1:0] id,  // table ID to lookup
    output      logic signed [2*ROM_WIDTH-1:0] data  // answer (fixed-point)
    );
    

    // sine table ROM: 0°-90°
    logic [$clog2(ROM_DEPTH)-1:0] tab_id;
    logic [ROM_WIDTH-1:0] tab_data;
    rom_async #(
        .WIDTH(ROM_WIDTH),
        .DEPTH(ROM_DEPTH),
        .INIT_F(ROM_FILE)
    ) sine_rom (
        .addr(tab_id),
        .data(tab_data)
    );

    logic [1:0] quad;  // quadrant we're in: I, II, III, IV
    always_comb begin
        quad = id[ADDRW-1:ADDRW-2];
        case (quad)
            2'b00: tab_id = id[ADDRW-3:0];                //  I:    0° to  90°
            2'b01: tab_id = 2*ROM_DEPTH - id[ADDRW-3:0];  // II:   90° to 180°
            2'b10: tab_id = id[ADDRW-3:0] - 2*ROM_DEPTH;  // III: 180° to 270°
            2'b11: tab_id = 4*ROM_DEPTH - id[ADDRW-3:0];  // IV:  270° to 360°
        endcase
    end

    always_comb begin
        if (id == 0) begin  // cos(0) = +1.0
            data = {{ROM_WIDTH-1{1'b0}}, 1'b1, {ROM_WIDTH{1'b0}}};
        end else if (id == 2*ROM_DEPTH) begin  // cos(180�) = -1.0
            data = {{ROM_WIDTH{1'b1}}, {ROM_WIDTH{1'b0}}};
        end else if (id == ROM_DEPTH) begin  // cos(90�) = 0
            data = {2*ROM_WIDTH{1'b0}};
        end else if (id == 3*ROM_DEPTH) begin  // cos(270�) = 0
            data = {2*ROM_WIDTH{1'b0}};    
        end else begin
            if ((quad == 'd3) || (quad == 'd0)) begin  // positive in quadrant I and IV
                data = {{ROM_WIDTH{1'b0}}, tab_data};
            end else begin
                data = {2*ROM_WIDTH{1'b0}} - {{ROM_WIDTH{1'b0}}, tab_data};
            end
        end
    end
endmodule