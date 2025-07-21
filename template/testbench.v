//  head info

`timescale 1ns/100ps

module testbench_name;

//======================
//  PARAMETER DEFINITION
//======================

parameter   CLK_PERIOD  = 10;


//=====================
//  VARIABLE DEFINITION
//=====================

//  sim ctrl
reg     disp_en = 'b1;
reg     sim_end = 'b0;

//  clock and reset
reg     clk     ;
reg     rst_n   ;


//======================
//  MODULE INSTANTIATION
//======================



//====================
//  SIMULATION CONTROL
//====================

//  clock generator
initial begin:  clk_sim
    # 10
    clk = 'b1;
    forever begin:  clock_gen_dead_loop
        #(CLK_PERIOD / 2) clk = ~clk;
    end
end

initial begin:  init_stimulus
    # 10;
    rst_n   = 'b0;

    # ({$urandom} % 100)
    //  stimulus editing
    rst_n   = 'b1;

    # 50000
    $finish(2);
end


//==================
//  DUT OUTPUT CHECK
//==================



//============================
//  TASK & FUNCTION DEFINITION
//============================



endmodule
