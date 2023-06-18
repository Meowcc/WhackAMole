module single_number
#(
    parameter H_POS = 10'd30,
    parameter V_POS = 10'd30,
    parameter COLOR = 24'hff0000
)
(
    input  wire [3:0] number,
    input  wire [9:0] hcounter,
    input  wire [9:0] vcounter,

    output wire visible,
    output wire [23:0] rgb
);

    wire [14:0] number0;
    wire [14:0] number1;
    wire [14:0] number2;
    wire [14:0] number3;
    wire [14:0] number4;
    wire [14:0] number5;
    wire [14:0] number6;
    wire [14:0] number7;
    wire [14:0] number8;
    wire [14:0] number9;

    // wire [2:0] number0 [0:4];
    // wire [2:0] number1 [0:4];
    // wire [2:0] number2 [0:4];
    // wire [2:0] number3 [0:4];
    // wire [2:0] number4 [0:4];
    // wire [2:0] number5 [0:4];
    // wire [2:0] number6 [0:4];
    // wire [2:0] number7 [0:4];
    // wire [2:0] number8 [0:4];
    // wire [2:0] number9 [0:4];

    assign number0[2:0] = 3'b111;
    assign number0[5:3] = 3'b101;
    assign number0[8:6] = 3'b101;
    assign number0[11:9] = 3'b101;
    assign number0[14:12] = 3'b111;

    assign number1[2:0] = 3'b001;
    assign number1[5:3] = 3'b001;
    assign number1[8:6] = 3'b001;
    assign number1[11:9] = 3'b001;
    assign number1[14:12] = 3'b001;

    assign number2[2:0] = 3'b111;
    assign number2[5:3] = 3'b001;
    assign number2[8:6] = 3'b111;
    assign number2[11:9] = 3'b100;
    assign number2[14:12] = 3'b111;

    assign number3[2:0] = 3'b111;
    assign number3[5:3] = 3'b001;
    assign number3[8:6] = 3'b111;
    assign number3[11:9] = 3'b001;
    assign number3[14:12] = 3'b111;

    assign number4[2:0] = 3'b101;
    assign number4[5:3] = 3'b101;
    assign number4[8:6] = 3'b111;
    assign number4[11:9] = 3'b001;
    assign number4[14:12] = 3'b001;

    assign number5[2:0] = 3'b111;
    assign number5[5:3] = 3'b100;
    assign number5[8:6] = 3'b111;
    assign number5[11:9] = 3'b001;
    assign number5[14:12] = 3'b111;

    assign number6[2:0] = 3'b111;
    assign number6[5:3] = 3'b100;
    assign number6[8:6] = 3'b111;
    assign number6[11:9] = 3'b101;
    assign number6[14:12] = 3'b111;

    assign number7[2:0] = 3'b111;
    assign number7[5:3] = 3'b001;
    assign number7[8:6] = 3'b001;
    assign number7[11:9] = 3'b001;
    assign number7[14:12] = 3'b001;

    assign number8[2:0] = 3'b111;
    assign number8[5:3] = 3'b101;
    assign number8[8:6] = 3'b111;
    assign number8[11:9] = 3'b101;
    assign number8[14:12] = 3'b111;
    
    assign number9[2:0] = 3'b111;
    assign number9[5:3] = 3'b101;
    assign number9[8:6] = 3'b111;
    assign number9[11:9] = 3'b001;
    assign number9[14:12] = 3'b001;

    reg [14:0] selected_number;

    always @(*) begin
        case (number)
            4'b0000: selected_number = number0;
            4'b0001: selected_number = number1;
            4'b0010: selected_number = number2;
            4'b0011: selected_number = number3;
            4'b0100: selected_number = number4;
            4'b0101: selected_number = number5;
            4'b0110: selected_number = number6;
            4'b0111: selected_number = number7;
            4'b1000: selected_number = number8;
            4'b1001: selected_number = number9;
            default: selected_number = number0;
        endcase
    end

    wire in_area;
    assign in_area = (hcounter >= H_POS) && (hcounter < H_POS + 48) && (vcounter >= V_POS) && (vcounter < V_POS + 80);

    wire [1:0] x;
    wire [2:0] y;

    wire [9:0] h_offset;
    wire [9:0] v_offset;

    assign h_offset = hcounter - H_POS;
    assign v_offset = vcounter - V_POS;

    assign x = h_offset[5:4];
    assign y = v_offset[6:4];

    reg [2:0] selected_number_row;

    always @(*) begin
        case (y)
            3'd0: selected_number_row = selected_number[2:0];
            3'd1: selected_number_row = selected_number[5:3];
            3'd2: selected_number_row = selected_number[8:6];
            3'd3: selected_number_row = selected_number[11:9];
            3'd4: selected_number_row = selected_number[14:12];
            default: selected_number_row = selected_number[2:0];
        endcase
    end

    wire selected_number_pixel;
    assign selected_number_pixel = selected_number_row[2 - x];

    assign visible = in_area && selected_number_pixel;
    assign rgb = COLOR;

endmodule
