`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/20 14:28:27
// Design Name: 
// Module Name: FAST_AXI
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FAST_AXI(
     input ACLK_in,
    input ARESTN_in,
    input [7:0] TDATA_in,
    input TSTRB_in,
    input TLAST_in,
    input TVALID_in,
    input TUSER_in,
    output TREADY_out,
    
	input FAST_EN,//
	input [10:0] width_in,
	input [10:0] height_in,
	input [7:0] threshold,
	
	output ACLK_out,
    output ARESTN_out,
    output [7:0] TDATA_out,
    output TSTRB_out,
    output TLAST_out,
    output TVALID_out,
    output TUSER_out,
    input TREADY_in
    );
     wire clk;
    wire rst_n;
    wire [8 - 1:0] data_in;
    wire in_H_SYNC;
    wire in_V_SYNC;
    wire in_data_en;
    assign clk = ACLK_in;
    assign rst_n = ARESTN_in;
    AXI2VGA AXI2VGA_init(
        .ACLK(ACLK_in),
        .ARESTN(ARESTN_in),
        .TDATA(TDATA_in),
        .TSTRB(TSTRB_in),
        .TLAST(TLAST_in),
        .TVALID(TVALID_in),
        .TUSER(TUSER_in),
        //.TREADY(TREADY_out),
       
        
        .H_SYNC(in_H_SYNC),
        .V_SYNC(in_V_SYNC),
        .DATA_EN(in_data_en),
        .pixel(data_in)
    );
    //////////////////////////////
   wire o_H_SYNC;
   wire o_V_SYNC;
   wire o_data_en;
   wire [7:0] data_out;
   parameter data_width = 8;
    FAST #(
        .data_width(data_width)
    )FAST_AXI_init(
       .clk(clk),
	   .rst_n(rst_n),
	   .in_H_SYNC(in_H_SYNC),
	   .in_V_SYNC(in_V_SYNC),
	   .in_data_en(in_data_en),
	   .data_in(data_in),

	   .FAST_EN(FAST_EN),
	   .width_in(width_in),
	   .height_in(height_in),
	   .threshold(threshold),

	   .o_H_SYNC(o_H_SYNC),
	   .o_V_SYNC(o_V_SYNC),
	   .o_data_en(o_data_en),
	   .data_out(data_out),
	   .TREADY_out(TREADY_out)
    );
    /////////////////////////////
    VGA2AXI VGA2AXI_init(
        .ACLK(ACLK_out),
        .ARESTN(ARESTN_out),
        .TDATA(TDATA_out),
        .TSTRB(TSTRB_out),
        .TLAST(TLAST_out),
        .TVALID(TVALID_out),
        .TUSER(TUSER_out),
        .TREADY(TREADY_in),
        
         .TVALID_in(o_data_en),
		
        .clk(clk),
        .rst_n(rst_n),
        .H_SYNC(o_H_SYNC),
        .V_SYNC(o_V_SYNC),
        .DATA_EN(o_data_en),
        .pixel(data_out)
        );
endmodule
