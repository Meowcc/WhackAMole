module layer(
    input  wire in_display,

    input  wire [23:0] layer0_rgb,
    input  wire layer0_valid,
    input  wire [23:0] layer1_rgb,
    input  wire layer1_valid,
    input  wire [23:0] layer2_rgb,
    input  wire layer2_valid,
    input  wire [23:0] layer3_rgb,
    input  wire layer3_valid,

    output reg [23:0] rgb
);

    always @(*) begin
        if (in_display) begin
            if (layer3_valid) begin
                rgb = layer3_rgb;
            end else if (layer2_valid) begin
                rgb = layer2_rgb;
            end else if (layer1_valid) begin
                rgb = layer1_rgb;
            end else if (layer0_valid) begin
                rgb = layer0_rgb;
            end else begin
                rgb = 0;
            end
        end else begin
            rgb = 0;
        end
    end

endmodule
