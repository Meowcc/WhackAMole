`include "vga_defines.v"

module vga_driver(
    input clk,
    input rst,
    output reg hsync,
    output reg vsync,
    output reg [9:0] hcounter,
    output reg [9:0] vcounter
);

    reg [9:0] hcounter_next;
    reg [9:0] vcounter_next;

    always @(posedge clk ) begin
        if (rst) begin
            hcounter <= 10'd0;
            vcounter <= 10'd0;
        end else begin
            hcounter <= hcounter_next;
            vcounter <= vcounter_next;
        end
    end

    always @(*) begin
        if (hcounter == `H_TOTAL - 1) begin
            hcounter_next = 10'd0;
        end else begin
            hcounter_next = hcounter + 1;
        end
    end

    always @(*) begin
        if (hcounter == `H_TOTAL - 1) begin
            if (vcounter == `V_TOTAL - 1) begin
                vcounter_next = 10'd0;
            end else begin
                vcounter_next = vcounter + 1;
            end
        end else begin
            vcounter_next = vcounter;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            vsync <= 1'b1;
        end
        if (hcounter == `H_ACTIVE + `H_FRONT_PORCH - 1) begin
            hsync <= 1'b0;
        end else if (hcounter == `H_ACTIVE + `H_FRONT_PORCH + `H_SYNC_PULSE - 1) begin
            hsync <= 1'b1;
        end else begin
            hsync <= hsync;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            vsync <= 1'b1;
        end
        if (vcounter == `V_ACTIVE + `V_FRONT_PORCH - 1) begin
            vsync <= 1'b0;
        end else if (vcounter == `V_ACTIVE + `V_FRONT_PORCH + `V_SYNC_PULSE - 1) begin
            vsync <= 1'b1;
        end else begin
            vsync <= vsync;
        end
    end



endmodule
