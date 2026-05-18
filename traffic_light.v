`define TRUE    1'b1
`define FALSE   1'b0

`define RED     2'd0
`define YELLOW  2'd1
`define GREEN   2'd2

// State definitions
`define S0 3'd0
`define S1 3'd1
`define S2 3'd2
`define S3 3'd3
`define S4 3'd4

module sig_control (
    output reg [1:0] hwy,
    output reg [1:0] cntry,
    input X,
    input clock,
    input clear
);

    reg [2:0] state;
    reg [2:0] next_state;

    // State register
    always @(posedge clock) begin
        if (clear)
            state <= `S0;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            `S0: begin
                hwy   = `GREEN;
                cntry = `RED;
            end

            `S1: begin
                hwy   = `YELLOW;
                cntry = `RED;
            end

            `S2: begin
                hwy   = `RED;
                cntry = `RED;
            end

            `S3: begin
                hwy   = `RED;
                cntry = `GREEN;
            end

            `S4: begin
                hwy   = `RED;
                cntry = `YELLOW;
            end

            default: begin
                hwy   = `RED;
                cntry = `RED;
            end
        endcase
    end

    // Next-state logic
    always @(*) begin
        if (clear)
            next_state = `S0;
        else begin
            case (state)

                `S0:
                    next_state = (X) ? `S1 : `S0;

                `S1:
                    next_state = `S2;

                `S2:
                    next_state = `S3;

                `S3:
                    next_state = (X) ? `S3 : `S4;

                `S4:
                    next_state = `S0;

                default:
                    next_state = `S0;

            endcase
        end
    end

endmodule