module round 
(
    input wire clk,
    input wire rst,
    input wire hit,
    input wire [3:0] hit_index,
    output wire mole_appear,
    output reg [3:0] mole_index,
    input wire round_start,
    output wire round_over,
    output wire hit_success,

    /* Round Configuration */
    input wire [26:0] interval,
    input wire [26:0] duration,
    input wire [2:0] molenum
);

reg [2:0] mole_count;

localparam IDLE = 3'd0;
localparam MOLE_INTERVAL = 3'd1;
localparam MOLE_APPEAR = 3'd2;

reg [2:0] cur_state;
reg [2:0] next_state;

reg [26:0] interval_counter;
reg [26:0] duration_counter;
reg [2:0] mole_count_next;

reg [26:0] interval_reg;
reg [26:0] duration_reg;
reg [2:0] molenum_reg;

wire [7:0] lsfr_output;

lsfr lsfr_inst (
    .clk(clk),
    .rst(rst),
    .out(lsfr_output)
);

always @(posedge clk) begin 
    if(rst) begin
        cur_state <= IDLE;
    end else begin
        cur_state <= next_state;
    end
end

always @(posedge clk) begin
    if (rst) begin
        interval_reg <= 0;
        duration_reg <= 0;
        molenum_reg <= 0;
    end else if (cur_state == IDLE) begin
        interval_reg <= interval;
        duration_reg <= duration;
        molenum_reg <= molenum;
    end else begin
        interval_reg <= interval_reg;
        duration_reg <= duration_reg;
        molenum_reg <= molenum_reg;
    end
end

always @(*) begin 
    mole_count_next = mole_count;
    case(cur_state)
    IDLE :
        if (round_start) begin
            next_state = MOLE_APPEAR;
            mole_count_next = 0;
        end else begin
            next_state = IDLE;
        end
    MOLE_APPEAR :
        if(mole_count == molenum_reg) begin  // mole_count++ when enter MOLE_APPEAR state
            next_state = IDLE;
        end else if (hit_success) begin
            next_state = MOLE_INTERVAL;
        end else begin
            if (duration_counter == duration_reg) begin
                next_state = MOLE_INTERVAL;
            end else begin
                next_state = MOLE_APPEAR;
            end
        end
    MOLE_INTERVAL :
        if(interval_counter == interval_reg) begin
            next_state = MOLE_APPEAR; 
            mole_count_next = mole_count + 1;
        end else begin
            next_state = MOLE_INTERVAL; 
        end
        default: next_state = IDLE;    
    endcase
end

always @(posedge clk) begin
   if (rst) begin
        mole_count <= 3'd0;
    end else begin
        mole_count <= mole_count_next;
   end 
end

always @(posedge clk) begin
    if (rst) begin
        interval_counter <= 27'd0;
        duration_counter <= 27'd0;
    end else begin
        if (cur_state == MOLE_INTERVAL) begin
            interval_counter <= interval_counter + 1;
            duration_counter <= 0;
            mole_index <= lsfr_output[3:0];
        end else if (cur_state <= MOLE_APPEAR) begin
            duration_counter <= duration_counter + 1;
            interval_counter <= 27'd0;
            mole_index <= mole_index;
        end else begin
            interval_counter <= 27'd0;
            duration_counter <= 27'd0;
            mole_index <= mole_index;
        end
    end
end

assign mole_appear = (cur_state == MOLE_APPEAR);
// assign mole_index = 4'd0;

assign round_over = (cur_state == IDLE);

reg has_hit;

always @(posedge clk) begin
    if (rst) begin
        has_hit <= 1'b0;
    end else begin
        if (hit && (cur_state == MOLE_APPEAR) && hit_index == mole_index) begin
            has_hit <= 1'b1;
        end else begin
            has_hit <= 1'b0;
        end
    end
end

assign hit_success = !has_hit && hit && (cur_state == MOLE_APPEAR);
endmodule
