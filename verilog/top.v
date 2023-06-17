module top(
    input wire clk,
    input wire rst,
    input wire [3:0] key_index,
    input wire start,
    input wire key_en,
    output wire hsync,
    output wire vsync,
    output reg [7:0] red,
    output reg [7:0] green,
    output reg [7:0] blue,
    output wire video_de
);

    wire [9:0] hcounter;
    wire [9:0] vcounter;
    wire [23:0] rgb;
    wire game_over;
    wire [1:0] round_level;
    wire [2:0] round_score;

    vga_driver vga_inst(
        .clk(clk),
        .rst(rst),
        .hsync(hsync),
        .vsync(vsync),
        .hcounter(hcounter),
        .vcounter(vcounter)
    );

    wire [23:0] moles_rgb;
    wire moles_visible;

    wire mole_appear;
    wire [3:0] mole_index;
    wire hit_success;

    moles moles_inst(
        // .clk(clk),
        // .rst(rst),
        .hcounter(hcounter),
        .vcounter(vcounter),
        .key_en(key_en),
        .key_index(key_index),
        .mole_appear(mole_appear),
        .mole_index(mole_index),
        .rgb(moles_rgb),
        .visible(moles_visible)
    );

    control control_inst(
        .clk(clk),
        .rst(rst),
        .game_start(start),
        .hit(key_en),
        .hit_index(key_index),
        .mole_appear(mole_appear),
        .mole_index(mole_index),
        .hit_success(hit_success),
        .game_over(game_over),
        .round_level(round_level),
        .round_score(round_score)
    );

    // /* TEMPOARY */
    // wire number_visible;
    // wire [23:0] number_rgb;
    // single_number #(10'd40, 10'd320, 24'hff0000)
    // single_number_inst(
    //     .number(4'd6),
    //     .hcounter(hcounter),
    //     .vcounter(vcounter),
    //     .visible(number_visible),
    //     .rgb(number_rgb)
    // );

    wire score_visible;
    wire [23:0] score_rgb;

    score #(10'd32, 10'd320)
    score_inst(
        .clk(clk),
        .rst(rst),
        .hit_success(hit_success),
        .round_score(round_score),
        .hcounter(hcounter),
        .vcounter(vcounter),
        .visible(score_visible),
        .rgb(score_rgb)
    );

    wire round_visible;
    wire [23:0] round_rgb;

    round_disp #(10'd40, 10'd80)
    round_disp_inst(
        .round(round_level),
        .hcounter(hcounter),
        .vcounter(vcounter),
        .visible(round_visible),
        .rgb(round_rgb)
    );

    wire [23:0] layer3_rgb;
    assign layer3_rgb = round_visible ? round_rgb : score_rgb;


    wire background;
    assign background = (hcounter < 640) && (vcounter < 480);
    wire round_board;
    assign round_board = (hcounter > 10) && (hcounter < 160) && (vcounter > 60) && (vcounter < 180);
    wire score_board;
    assign score_board = (hcounter > 10) && (hcounter < 160) && (vcounter > 300) && (vcounter < 420);
    assign video_de = background;

    layer layer_inst(
        .in_display(background),
        .layer0_rgb(24'hb7ae8f),
        .layer0_valid(1),
        .layer1_rgb(moles_rgb),
        .layer1_valid(moles_visible),
        .layer2_rgb(24'hf7e8aa),
        .layer2_valid(score_board||round_board),
        .layer3_rgb(layer3_rgb),
        .layer3_valid(score_visible || round_visible),
        .rgb(rgb)
    );

    assign red   = rgb[23:16];
    assign green = rgb[15:8];
    assign blue  = rgb[7:0];

endmodule
