module mole
#(
    parameter H_POS = 10'd20,
    parameter V_POS = 10'd20
)
(
    // input wire clk,
    // input wire rst,
    input wire hit,
    input wire appear,
    input wire [9:0] hcounter,
    input wire [9:0] vcounter,
    output wire visible,
    output wire [23:0] rgb
);
    
    wire mole_h = (hcounter >= H_POS) && (hcounter < H_POS + 100);
    wire mole_v = (vcounter >= V_POS) && (vcounter < V_POS + 100); 

    assign visible = mole_h && mole_v;

    reg [7:0] red;
    reg [7:0] green;
    reg [7:0] blue;

    always @(*) begin
        if (visible) begin
            if (hit) begin
                red  = 239;
                green = 111;
                blue = 72;
            end else if (appear) begin
                red  = 255;
                green = 255;
                blue = 255;
            end else begin
                red  = 251;
                green = 226;
                blue = 81;
            end
        end else begin
            red = 0;
            green = 0;
            blue = 0;
        end
    end

    assign rgb = {red, green, blue};

endmodule
