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

    wire [2:0] number0 [0:4];
    wire [2:0] number1 [0:4];
    wire [2:0] number2 [0:4];
    wire [2:0] number3 [0:4];
    wire [2:0] number4 [0:4];
    wire [2:0] number5 [0:4];
    wire [2:0] number6 [0:4];
    wire [2:0] number7 [0:4];
    wire [2:0] number8 [0:4];
    wire [2:0] number9 [0:4];

    assign number0[0] = 3'b111;
    assign number0[1] = 3'b101;
    assign number0[2] = 3'b101;
    assign number0[3] = 3'b101;
    assign number0[4] = 3'b111;

    assign number1[0] = 3'b001;
    assign number1[1] = 3'b001;
    assign number1[2] = 3'b001;
    assign number1[3] = 3'b001;
    assign number1[4] = 3'b001;

    assign number2[0] = 3'b111;
    assign number2[1] = 3'b001;
    assign number2[2] = 3'b111;
    assign number2[3] = 3'b100;
    assign number2[4] = 3'b111;

    assign number3[0] = 3'b111;
    assign number3[1] = 3'b001;
    assign number3[2] = 3'b111;
    assign number3[3] = 3'b001;
    assign number3[4] = 3'b111;

    assign number4[0] = 3'b101;
    assign number4[1] = 3'b101;
    assign number4[2] = 3'b111;
    assign number4[3] = 3'b001;
    assign number4[4] = 3'b001;

    assign number5[0] = 3'b111;
    assign number5[1] = 3'b100;
    assign number5[2] = 3'b111;
    assign number5[3] = 3'b001;
    assign number5[4] = 3'b111;

    assign number6[0] = 3'b111;
    assign number6[1] = 3'b100;
    assign number6[2] = 3'b111;
    assign number6[3] = 3'b101;
    assign number6[4] = 3'b111;

    assign number7[0] = 3'b111;
    assign number7[1] = 3'b001;
    assign number7[2] = 3'b001;
    assign number7[3] = 3'b001;
    assign number7[4] = 3'b001;

    assign number8[0] = 3'b111;
    assign number8[1] = 3'b101;
    assign number8[2] = 3'b111;
    assign number8[3] = 3'b101;
    assign number8[4] = 3'b111;
    
    assign number9[0] = 3'b111;
    assign number9[1] = 3'b101;
    assign number9[2] = 3'b111;
    assign number9[3] = 3'b001;
    assign number9[4] = 3'b001;

    reg [2:0] selected_number [0:4];

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

    wire [2:0] selected_number_row;
    assign selected_number_row = selected_number[y];
    wire selected_number_pixel;
    assign selected_number_pixel = selected_number_row[2 - x];

    assign visible = in_area && selected_number_pixel;
    assign rgb = COLOR;

endmodule
