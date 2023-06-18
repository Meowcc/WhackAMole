module round_disp
#(
    parameter H_POS = 10'd60,
    parameter V_POS = 10'd80
)
(
    input  wire [1:0] round,
    input  wire [9:0] hcounter,
    input  wire [9:0] vcounter,
    output wire visible,
    output wire [23:0] rgb
);

    single_number #(
        .H_POS(H_POS),
        .V_POS(V_POS),
        .COLOR(24'hfba414)
    ) round0 (
        .number({2'b0, round}),
        .hcounter(hcounter),
        .vcounter(vcounter),
        .visible(visible),
        .rgb(rgb)
    );
endmodule
