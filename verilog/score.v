module score 
#(
    parameter H_POS = 10'd40,
    parameter V_POS = 10'd320
)
(
    input wire clk,
    input wire rst,
    input wire hit_success,
    input wire [2:0] round_score,
    input wire [9:0] hcounter,
    input wire [9:0] vcounter,

    output reg visible,
    output reg [23:0] rgb
    // output reg [6:0] total_score
);

    reg [3:0] scores [0:1];

    reg [2:0] add_buffer;

    always @(posedge clk) begin
        if (rst) begin
            scores[0] <= 4'b0000;
            scores[1] <= 4'b0000;
            add_buffer <= 3'b000;
        end else begin
            if (hit_success) begin
                add_buffer <= round_score;
            end else begin
                if (add_buffer != 0) begin
                    if (scores[0] == 4'd9) begin
                        scores[0] <= 4'b0000;
                        scores[1] <= scores[1] + 4'd1;
                    end else begin
                        scores[0] <= scores[0] + 4'd1;
                    end
                    add_buffer <= add_buffer - 3'd1;
                end
            end 
        end
    end

    wire number0_visible;
    wire number1_visible;
    wire [23:0] number0_rgb;
    wire [23:0] number1_rgb;

    single_number #(
        .H_POS(H_POS + 10'd60),
        .V_POS(V_POS),
        .COLOR(24'hff0000)
    ) score0 (
        .number(scores[0]),
        .hcounter(hcounter),
        .vcounter(vcounter),
        .visible(number0_visible),
        .rgb(number0_rgb)
    );

    single_number #(
        .H_POS(H_POS),
        .V_POS(V_POS),
        .COLOR(24'hff0000)
    ) score1 (
        .number(scores[1]),
        .hcounter(hcounter),
        .vcounter(vcounter),
        .visible(number1_visible),
        .rgb(number1_rgb)
    );

    always @(*) begin
        if (number0_visible) begin
            visible = 1'b1;
            rgb = number0_rgb;
        end else if (number1_visible) begin
            visible = 1'b1;
            rgb = number1_rgb;
        end else begin
            visible = 1'b0;
            rgb = 24'b0;
        end
    end

endmodule
