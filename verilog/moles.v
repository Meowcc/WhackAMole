module moles(
    // input  wire clk,
    // input  wire rst,
    input  wire key_en,
    input  wire [3:0] key_index,
    input  wire [9:0] hcounter,
    input  wire [9:0] vcounter,
    input  wire mole_appear,
    input  wire [3:0] mole_index, // The index of the mole that is appearing
    output reg [23:0] rgb,
    output reg visible
);

wire [23:0] rgbs [0:15];
wire  visibles [0:15]; 

wire appear [0:15];

assign appear[0] = mole_appear && (mole_index == 0);
assign appear[1] = mole_appear && (mole_index == 1);
assign appear[2] = mole_appear && (mole_index == 2);
assign appear[3] = mole_appear && (mole_index == 3);
assign appear[4] = mole_appear && (mole_index == 4);
assign appear[5] = mole_appear && (mole_index == 5);
assign appear[6] = mole_appear && (mole_index == 6);
assign appear[7] = mole_appear && (mole_index == 7);
assign appear[8] = mole_appear && (mole_index == 8);
assign appear[9] = mole_appear && (mole_index == 9);
assign appear[10] = mole_appear && (mole_index == 10);
assign appear[11] = mole_appear && (mole_index == 11);
assign appear[12] = mole_appear && (mole_index == 12);
assign appear[13] = mole_appear && (mole_index == 13);
assign appear[14] = mole_appear && (mole_index == 14);
assign appear[15] = mole_appear && (mole_index == 15);

mole #(170, 10) mole0_inst(
    // .clk(clk),
    // .rst(rst),
    .hit(key_en && (key_index == 0)),
    .hcounter(hcounter),
    .vcounter(vcounter),
    .appear(appear[0]),
    .rgb(rgbs[0]),
    .visible(visibles[0])
);

mole #(290, 10) mole1_inst(
    // .clk(clk),
    // .rst(rst),
    .hit(key_en && (key_index == 1)),
    .hcounter(hcounter),
    .vcounter(vcounter),
    .appear(appear[1]),
    .rgb(rgbs[1]),
    .visible(visibles[1])
);

mole #(410, 10) mole2_inst(
    // .clk(clk),
    // .rst(rst),
    .hit(key_en && (key_index == 2)),
    .hcounter(hcounter),
    .vcounter(vcounter),
    .appear(appear[2]),
    .rgb(rgbs[2]),
    .visible(visibles[2])
);

mole #(530, 10) mole3_inst(
    // .clk(clk),
    // .rst(rst),
    .hit(key_en && (key_index == 3)),
    .hcounter(hcounter),
    .vcounter(vcounter),
    .appear(appear[3]),
    .rgb(rgbs[3]),
    .visible(visibles[3])
);

mole #(170, 130) mole4_inst(
    // .clk(clk),
    // .rst(rst),
    .hit(key_en && (key_index == 4)),
    .hcounter(hcounter),
    .vcounter(vcounter),
    .appear(appear[4]),
    .rgb(rgbs[4]),
    .visible(visibles[4])
);

mole #(290, 130) mole5_inst(
    // .clk(clk),
    // .rst(rst),
    .hit(key_en && (key_index == 5)),
    .hcounter(hcounter),
    .vcounter(vcounter),
    .appear(appear[5]),
    .rgb(rgbs[5]),
    .visible(visibles[5])
);

mole #(410, 130) mole6_inst(
    // .clk(clk),
    // .rst(rst),
    .hit(key_en && (key_index == 6)),
    .hcounter(hcounter),
    .vcounter(vcounter),
    .appear(appear[6]),
    .rgb(rgbs[6]),
    .visible(visibles[6])
);

mole #(530, 130) mole7_inst(
    // .clk(clk),
    // .rst(rst),
    .hit(key_en && (key_index == 7)),
    .hcounter(hcounter),
    .vcounter(vcounter),
    .appear(appear[7]),
    .rgb(rgbs[7]),
    .visible(visibles[7])
);

mole #(170, 250) mole8_inst(
    // .clk(clk),
    // .rst(rst),
    .hit(key_en && (key_index == 8)),
    .hcounter(hcounter),
    .vcounter(vcounter),
    .appear(appear[8]),
    .rgb(rgbs[8]),
    .visible(visibles[8])
);

mole #(290, 250) mole9_inst(
    // .clk(clk),
    // .rst(rst),
    .hit(key_en && (key_index == 9)),
    .hcounter(hcounter),
    .vcounter(vcounter),
    .appear(appear[9]),
    .rgb(rgbs[9]),
    .visible(visibles[9])
);

mole #(410, 250) mole10_inst(
    // .clk(clk),
    // .rst(rst),
    .hit(key_en && (key_index == 10)),
    .hcounter(hcounter),
    .vcounter(vcounter),
    .appear(appear[10]),
    .rgb(rgbs[10]),
    .visible(visibles[10])
);

mole #(530, 250) mole11_inst(
    // .clk(clk),
    // .rst(rst),
    .hit(key_en && (key_index == 11)),
    .hcounter(hcounter),
    .vcounter(vcounter),
    .appear(appear[11]),
    .rgb(rgbs[11]),
    .visible(visibles[11])
);

mole #(170, 370) mole12_inst(
    // .clk(clk),
    // .rst(rst),
    .hit(key_en && (key_index == 12)),
    .hcounter(hcounter),
    .vcounter(vcounter),
    .appear(appear[12]),
    .rgb(rgbs[12]),
    .visible(visibles[12])
);

mole #(290, 370) mole13_inst(
    // .clk(clk),
    // .rst(rst),
    .hit(key_en && (key_index == 13)),
    .hcounter(hcounter),
    .vcounter(vcounter),
    .appear(appear[13]),
    .rgb(rgbs[13]),
    .visible(visibles[13])
);

mole #(410, 370) mole14_inst(
    // .clk(clk),
    // .rst(rst),
    .hit(key_en && (key_index == 14)),
    .hcounter(hcounter),
    .vcounter(vcounter),
    .appear(appear[14]),
    .rgb(rgbs[14]),
    .visible(visibles[14])
);

mole #(530, 370) mole15_inst(
    // .clk(clk),
    // .rst(rst),
    .hit(key_en && (key_index == 15)),
    .hcounter(hcounter),
    .vcounter(vcounter),
    .appear(appear[15]),
    .rgb(rgbs[15]),
    .visible(visibles[15])
);

integer j;
always @(*) begin
    rgb = 0;
    for (j = 0; j < 16; j = j + 1) begin
        if (visibles[j]) begin
            rgb = rgbs[j];
        end
    end
end

assign visible = visibles[0] || visibles[1] || visibles[2] || visibles[3] || visibles[4] || visibles[5] || visibles[6] || visibles[7] || visibles[8] || visibles[9] || visibles[10] || visibles[11] || visibles[12] || visibles[13] || visibles[14] || visibles[15];

endmodule
