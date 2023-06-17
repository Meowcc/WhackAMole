module board_top(
    input  wire sys_clk,
    input  wire rst,
    input  wire [3:0] r_pin,
    output wire [3:0] c_pin,
    input  wire start,
    output wire tmds_clk_p,
    output wire tmds_clk_n,
    output wire [2:0] tmds_data_p,
    output wire [2:0] tmds_data_n
);

    wire [23:0] rgb;
    wire hsync;
    wire vsync;
    wire key_en;
    wire [3:0] key_index;
    wire video_de;

    /* TODO: Add A Clock Wiz */
    wire clk_pixel, clk_pixel_5x;

    top top_inst(
        .clk(clk_pixel),
        .rst(rst),
        .hsync(hsync),
        .vsync(vsync),
        .red(rgb[23:16]),
        .green(rgb[15:8]),
        .blue(rgb[7:0]),
        .key_en(key_en),
        .key_index(key_index),
        .start(start),
        .video_de(video_de)
    );

    test_key test_key_inst(
        .clk(clk_pixel),
        .rst(rst),
        .r_pin(r_pin),
        .c_pin(c_pin),
        .key_out(key_index),
        .o_key_out_en(key_en)
    );

    dvi_transmitter_top rgb2dvi_inst(
        .pclk(clk_pixel),
        .pclk_x5(clk_pixel_5x),
        .reset_n(!rst),
        .video_din(rgb),
        .video_de(video_de),
        .video_hsync(hsync),
        .video_vsync(vsync),
        .tmds_clk_p(tmds_clk_p),
        .tmds_clk_n(tmds_clk_n),
        .tmds_data_p(tmds_data_p),
        .tmds_data_n(tmds_data_n)
    );
endmodule
