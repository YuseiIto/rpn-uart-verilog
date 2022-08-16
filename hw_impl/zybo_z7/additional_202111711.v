`timescale 1ns / 1ps

// University of Tsukuba GB12812 final report submission
// Author: Yusei Ito

module additional_202111711(clk,rx_in,tx_out);
    
    input clk;
    input rx_in;
     
    output tx_out;
    
    wire slow_clk;
    clk_wiz_0 clk_slower (slow_clk,0,,clk);
    rpn_uart_computer computer(slow_clk,rx_in,tx_out);
    
endmodule
