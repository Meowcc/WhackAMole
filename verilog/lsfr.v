module lsfr (
    input  wire clk,
    input  wire rst,
    output wire [7:0] out
);

    wire [7:0] value_next;
    wire feedback = value[7] ^ value[5] ^ value[4] ^ value[3];
    reg [7:0] value;

    always @(posedge clk) begin
        if (rst) begin
            value <= 8'h01;
        end else begin
            value <= value_next;
        end
    end 

    assign out = value;
    assign value_next = {value[6:0], feedback};

endmodule
