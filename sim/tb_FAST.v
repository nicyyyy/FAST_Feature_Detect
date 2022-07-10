`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/13 10:06:30
// Design Name: 
// Module Name: tb_FAST
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


`timescale 1ns / 1ns
module tb_FAST();

    reg ACLK_in;
    reg ARESTN_in;
    reg [7:0] TDATA_in;
    reg TSTRB_in;
    reg TLAST_in;
    reg TVALID_in;
    reg TUSER_in;
    wire TREADY_out;
    
   wire ACLK_out;     
   wire ARESTN_out;    
   wire [7:0] TDATA_out; 
   wire TSTRB_out;      
   wire TLAST_out;       
   wire TVALID_out;      
   wire TUSER_out;       
   reg TREADY_in;       
  reg FAST_EN;
  reg [10:0] width_in;
  reg [10:0] height_in;
  reg [7:0] threshold;
    
    reg [7:0] temp8b;
    integer fd1;
    integer stop_flag;
    integer pixel_cnt;
    integer V_cnt;
    integer H_cnt;
    integer V_next;
    integer start_num, pause_num;

    parameter period = 500;
    parameter data_depth = 8;


    FAST_AXI #(
    .data_depth(data_depth)
    )FAST_AXI_init(
    .ACLK_in(ACLK_in),
    .ARESTN_in(ARESTN_in),
    .TDATA_in(TDATA_in),
    .TSTRB_in(TSTRB_in),
    .TLAST_in(TLAST_in),
    .TVALID_in(TVALID_in),
    .TUSER_in(TUSER_in),
    .TREADY_out(TREADY_out),
    
    .FAST_EN(FAST_EN),  
    .width_in(width_in),
    .height_in(height_in),
    .threshold(threshold),
    
    .ACLK_out(ACLK_out),      
    .ARESTN_out(ARESTN_out),   
    .TDATA_out(TDATA_out),
    .TSTRB_out(TSTRB_out),   
    .TLAST_out(TLAST_out),   
    .TVALID_out(TVALID_out),   
    .TUSER_out(TUSER_out),   
    .TREADY_in(TREADY_in)   
    );

    initial
    begin
    FAST_EN = 1;
    height_in = 720;
    width_in = 1280;
    threshold = 60;
    ARESTN_in = 0;
    TVALID_in = 0;
    TREADY_in = 1;
    #(period);
    ARESTN_in = 1;
    #(period);
    TVALID_in = 1;
    #(period);
    while(pixel_cnt < 32'd921600)
    begin
    start_num = {$random}%721 + 2;
    pause_num = {$random}%11 + 2;
    while(start_num > 1)
    begin
    start_num = start_num - 1;
    #(period);
    end
    while(pause_num > 1)
    begin
    pause_num = pause_num - 1;
    TVALID_in = 0;
    #(period);
    end
    TVALID_in = 1;
    end
    TVALID_in = 0;
    end

    //读
    initial
    begin
    stop_flag = 0;
    pixel_cnt = 0;
    V_next = 0;
    V_cnt = 1;
    H_cnt = 1;
    fd1 = $fopen("E:/my_verilog/prev.bin", "rb");
    #(3*period);

    while(pixel_cnt < 32'd921600)
    begin
    if(TREADY_out == 1'b1 && TVALID_in == 1'b1)
    begin
    $fread(temp8b, fd1, , 1);
    TDATA_in = temp8b;
    pixel_cnt = pixel_cnt + 1;

    if(V_cnt == 1 && V_next == 0)
    begin
    TUSER_in = 1;
    V_next = 1;
    end
    else if(H_cnt == 720)
    TLAST_in = 1;
    else;

    if(V_cnt < 1280)
    V_cnt = V_cnt + 1;
    else
    V_cnt = 1;

    if(H_cnt < 720)
    H_cnt = H_cnt + 1;
    else
    H_cnt = 1;

    #(period/2);
    TUSER_in = 0;
    TLAST_in = 0;
    #(period/2);
    end
    else
    begin
    pixel_cnt = pixel_cnt;
    H_cnt = H_cnt;
    V_cnt = V_cnt;
    #(period);
    end
    if(pixel_cnt == 32'd921600)
    V_next = 0;
    end
    $fclose(fd1);
    stop_flag = 1;
    pixel_cnt = pixel_cnt + 1;
    TVALID_in = 0;
    #(period);
    //		$stop;
    end

    //写
    integer fd2;
    initial
    begin
    fd2 = $fopen("E:/my_verilog/AXI/FAST/FAST/score.bin", "wb");

    while(1)
    begin
    if(TVALID_out == 1)
    begin
    $fwrite(fd2,"%02x",TDATA_out);
    end
    else if(TVALID_out == 0 && stop_flag == 1)
    begin
    $fclose(fd2);
    $stop;
    end
    #(period);
    end
    end



    initial
    begin
    ACLK_in = 0;
    forever #(period/2) ACLK_in = ~ACLK_in;
    end

endmodule 
