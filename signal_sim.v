`timescale 1ns / 1ps

module signal_sim;

    // Testbench signals
    wire [1:0] MAIN_SIG, CNTRY_SIG;
    reg CAR_ON_CNTRY_RD;
    reg CLOCK, CLEAR;

    // Instantiate DUT (Device Under Test)
    sig_control SC (
        .hwy(MAIN_SIG),
        .cntry(CNTRY_SIG),
        .X(CAR_ON_CNTRY_RD),
        .clock(CLOCK),
        .clear(CLEAR)
    );

    // Monitor outputs
    initial begin
        $monitor(
            "Time = %0t | Main Sig = %b | Country Sig = %b | Car on Country Road = %b",
            $time,
            MAIN_SIG,
            CNTRY_SIG,
            CAR_ON_CNTRY_RD
        );
    end

    // Clock generation (10 ns period)
    initial begin
        CLOCK = `FALSE;
        forever #5 CLOCK = ~CLOCK;
    end

    // Reset/Clear signal
    initial begin
        CLEAR = `TRUE;

        // Hold reset for 5 negative edges
        repeat (5) @(negedge CLOCK);

        CLEAR = `FALSE;
    end

    // Stimulus
    initial begin
        CAR_ON_CNTRY_RD = `FALSE;

        #200 CAR_ON_CNTRY_RD = `TRUE;
        #100 CAR_ON_CNTRY_RD = `FALSE;

        #200 CAR_ON_CNTRY_RD = `TRUE;
        #100 CAR_ON_CNTRY_RD = `FALSE;

        #200 CAR_ON_CNTRY_RD = `TRUE;
        #100 CAR_ON_CNTRY_RD = `FALSE;

        #100 $stop;
    end

endmodule