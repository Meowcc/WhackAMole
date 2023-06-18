module control (
    input  wire clk,
    input  wire rst,
    input  wire game_start,
    input  wire hit,
    input  wire [3:0] hit_index,
    output wire mole_appear,
    output wire [3:0] mole_index,
    output wire hit_success,
    output wire game_over,
    output reg  [1:0] round_level,
    output reg  [2:0] round_score
    //output wire score_display
);
    
    // reg  [1:0] round_level;
    wire [1:0] total_rounds = 2'd3;
    // wire new_round;
    reg [2:0] hit_count;

    localparam IDLE = 3'd0;
    localparam ROUND_CONFIG = 3'd1;
    localparam ROUND_RUNNING = 3'd2;
    localparam ROUND_OVER = 3'd3;
    localparam GAME_OVER = 3'd4; 

    wire round_start;
    wire round_over;

    reg [26:0] interval;
    reg [26:0] duration;
    reg [2:0] molenum;

    round round_fsm(
        .clk(clk),
        .rst(rst),
        .hit(hit),
        .hit_index(hit_index),
        .mole_appear(mole_appear),
        .mole_index(mole_index),
        .round_start(round_start),
        .round_over(round_over), // TODO
        .hit_success(hit_success),
        .interval(interval),
        .duration(duration),
        .molenum(molenum)
    );

    reg [2:0] cur_state;
    reg [2:0] next_state;

    always @(posedge clk) begin 
        if(rst) begin
            cur_state <= IDLE;
        end else begin
            cur_state <= next_state;
        end
    end

    always @(*) begin
        interval = 0;
        duration = 0;
        molenum = 0;
        case(cur_state)
            IDLE: begin
                if (game_start) begin
                    next_state = ROUND_CONFIG;
                end else begin
                    next_state = IDLE;
                end
            end
            ROUND_CONFIG: begin
                case (round_level) 
                    2'd0: begin
                        interval = 27'd125000000; // Mult10 when on-board
                        duration = 27'd100000000;
                        molenum = 3'd4;
                    end
                    2'd1: begin
                        interval = 27'd100000000;
                        duration = 27'd75000000;
                        molenum = 3'd6;
                    end
                    2'd2: begin
                        interval = 27'd75000000;
                        duration = 27'd50000000;
                        molenum = 3'd6;
                    end
                    default: begin
                        interval = 27'd0;
                        duration = 27'd0;
                        molenum = 3'd0;
                    end
                endcase
                next_state = ROUND_RUNNING;
            end 
            ROUND_RUNNING: begin
                if (round_over) begin
                    next_state = ROUND_OVER;
                end else begin
                    next_state = ROUND_RUNNING;
                end
            end
            ROUND_OVER: begin
                if (round_level < total_rounds) begin
                    if (hit_count >= 3'd3) begin
                        next_state = ROUND_CONFIG;
                    end else begin
                        next_state = GAME_OVER;
                    end
                end else begin
                    next_state = GAME_OVER;
                end
            end
            GAME_OVER: begin
                next_state = GAME_OVER;
            end
            default: next_state = IDLE;
        endcase
    end
    
    always @(posedge clk) begin
        if (rst) begin
            round_level <= 2'd0;
        end else if (cur_state == ROUND_CONFIG) begin
            round_level <= round_level + 1;
        end else begin
            round_level <= round_level;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            hit_count <= 3'd0;
        end else if (cur_state == ROUND_CONFIG) begin
            hit_count <= 3'd0;
        end else if (cur_state == ROUND_RUNNING && hit_success) begin
            hit_count <= hit_count + 1;
        end else begin
            hit_count <= hit_count;
        end
    end

    assign round_start = (cur_state == ROUND_CONFIG);
    assign game_over = (cur_state == GAME_OVER);

    always @(*) begin
        case (round_level) 
            2'd0: begin
                round_score = 3'd0;
            end
            2'd1: begin
                round_score = 3'd1;
            end
            2'd2: begin
                round_score = 3'd3;
            end
            default: begin
                round_score = 3'd5;
            end
        endcase 
    end 

endmodule
