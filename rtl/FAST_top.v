module FAST(
	input clk,
	input rst_n,
	input in_H_SYNC,
	input in_V_SYNC,
	input in_data_en,
	input [7:0] data_in,
//    input ACLK_in,
//    input ARESTN_in,
//    input [7:0] TDATA_in,
//    input TSTRB_in,
//    input TLAST_in,
//    input TVALID_in,
//    input TUSER_in,
//    output reg TREADY_out,
    
	input FAST_EN,//
	input [10:0] width_in,
	input [10:0] height_in,
	input [7:0] threshold,

	output o_H_SYNC,
	output o_V_SYNC,
	output o_data_en,
	output [7:0] data_out,
	output reg TREADY_out
//	output [10:0] o_x,
//	output [10:0] o_y,
//	output xy_val,
//    output ACLK_out,
//    output ARESTN_out,
//    output [7:0] TDATA_out,
//    output TSTRB_out,
//    output TLAST_out,
//    output TVALID_out,
//    output TUSER_out,
//    input TREADY_in
);
	//
//    wire clk;
//    wire rst_n;
//    wire [8 - 1:0] data_in;
//    wire in_H_SYNC;
//    wire in_V_SYNC;
//    wire in_data_en;
//    assign clk = ACLK_in;
//    assign rst_n = ARESTN_in;
//    AXI2VGA AXI2VGA_init(
//        .ACLK(ACLK_in),
//        .ARESTN(ARESTN_in),
//        .TDATA(TDATA_in),
//        .TSTRB(TSTRB_in),
//        .TLAST(TLAST_in),
//        .TVALID(TVALID_in),
//        .TUSER(TUSER_in),
//        //.TREADY(TREADY_out),
       
        
//        .H_SYNC(in_H_SYNC),
//        .V_SYNC(in_V_SYNC),
//        .DATA_EN(in_data_en),
//        .pixel(data_in)
//    );
    //assign TREADY_out = (gaussian_EN == 1)? 1:0;
	//模块使能
	reg start_FAST;
	reg [10:0] width;
	reg [10:0] height;
	wire clk_FAST;
	always@(*)
	begin
		if(~rst_n)
		begin
			start_FAST = 0;
			width = 0;
			height = 0;
		end
		else if(in_V_SYNC == 1 && FAST_EN == 1)
		begin
			start_FAST = 1;
			width = width_in;
			height = height_in;
		end
		else if(in_V_SYNC == 1 && FAST_EN == 0)
			start_FAST = 0;
		else
			start_FAST = start_FAST;
			
	    if(FAST_EN == 1)
	       TREADY_out = 1;
	    else
	       TREADY_out = 0;
	       
	end
	 
	assign clk_FAST = start_FAST & clk;

	parameter data_width = 8;
//	parameter threshold = 60;

	//提取圆周上16点
	wire [8:0] signed_point1;
	wire [8:0] signed_point2;
	wire [8:0] signed_point3;
	wire [8:0] signed_point4;
	wire [8:0] signed_point5;
	wire [8:0] signed_point6;
	wire [8:0] signed_point7;
	wire [8:0] signed_point8;
	wire [8:0] signed_point9;
	wire [8:0] signed_point10;
	wire [8:0] signed_point11;
	wire [8:0] signed_point12;
	wire [8:0] signed_point13;
	wire [8:0] signed_point14;
	wire [8:0] signed_point15;
	wire [8:0] signed_point16;
	wire [8:0] signed_center;
	
	
	wire point_H_SYNC;
	wire point_V_SYNC;
	wire point_data_en;
	
	//提取16个圆周上的点以及中心点，并且输出灰度值的补码
	Bresenham_16point_8bit #(
		.data_width(data_width)
	)Bresenham_16point_8bit_init(
		.clk(clk_FAST),
		.rst_n(rst_n),
		.in_H_SYNC(in_H_SYNC),
		.in_V_SYNC(in_V_SYNC),
		.in_data_en(in_data_en),
		.data_in(data_in),
		.width(width),
		.height(height),
		
		.o_H_SYNC(point_H_SYNC),
		.o_V_SYNC(point_V_SYNC),
		.o_data_en(point_data_en),
		
		.signed_point1(signed_point1),
		.signed_point2(signed_point2),
		.signed_point3(signed_point3),
		.signed_point4(signed_point4),
		.signed_point5(signed_point5),
		.signed_point6(signed_point6),
		.signed_point7(signed_point7),
		.signed_point8(signed_point8),
		.signed_point9(signed_point9),
		.signed_point10(signed_point10),
		.signed_point11(signed_point11),
		.signed_point12(signed_point12),
		.signed_point13(signed_point13),
		.signed_point14(signed_point14),
		.signed_point15(signed_point15),
		.signed_point16(signed_point16),
		.signed_center(signed_center)
	);
	
	//根据输出的补码，计算每个点与中心点的绝对值之差，判断特征点
	wire feature_V_SYNC;
	wire feature_H_SYNC;
	wire feature_data_en;
	wire Feature_val;
	
	wire [7:0] abs_df1;
	wire [7:0] abs_df2;
	wire [7:0] abs_df3;
	wire [7:0] abs_df4;
	wire [7:0] abs_df5;
	wire [7:0] abs_df6;
	wire [7:0] abs_df7;
	wire [7:0] abs_df8;
	wire [7:0] abs_df9;
	wire [7:0] abs_df10;
	wire [7:0] abs_df11;
	wire [7:0] abs_df12;
	wire [7:0] abs_df13;
	wire [7:0] abs_df14;
	wire [7:0] abs_df15;
	wire [7:0] abs_df16;
	
	Get_Feature_point Get_Feature_point(
		.clk(clk_FAST),
		.rst_n(rst_n),
		.in_H_SYNC(point_H_SYNC),
		.in_V_SYNC(point_V_SYNC),
		.in_data_en(in_data_en),
		.threshold(threshold),
		.signed_point1(signed_point1),
		.signed_point2(signed_point2),
		.signed_point3(signed_point3),
		.signed_point4(signed_point4),
		.signed_point5(signed_point5),
		.signed_point6(signed_point6),
		.signed_point7(signed_point7),
		.signed_point8(signed_point8),
		.signed_point9(signed_point9),
		.signed_point10(signed_point10),
		.signed_point11(signed_point11),
		.signed_point12(signed_point12),
		.signed_point13(signed_point13),
		.signed_point14(signed_point14),
		.signed_point15(signed_point15),
		.signed_point16(signed_point16),
		.signed_center(signed_center),
		
		.TVALID_in(in_data_en),
		.o_H_SYNC(feature_H_SYNC),
		.o_V_SYNC(feature_V_SYNC),
		.o_data_en(feature_data_en),
		.Feature_val(Feature_val),
		
		.o_abs_df1(abs_df1),
		.o_abs_df2(abs_df2),
		.o_abs_df3(abs_df3),
		.o_abs_df4(abs_df4),
		.o_abs_df5(abs_df5),
		.o_abs_df6(abs_df6),
		.o_abs_df7(abs_df7),
		.o_abs_df8(abs_df8),
		.o_abs_df9(abs_df9),
		.o_abs_df10(abs_df10),
		.o_abs_df11(abs_df11),
		.o_abs_df12(abs_df12),
		.o_abs_df13(abs_df13),
		.o_abs_df14(abs_df14),
		.o_abs_df15(abs_df15),
		.o_abs_df16(abs_df16)
	);
	
	
	//对特征点打分
	wire score_V_SYNC;
	wire score_H_SYNC;
	wire score_data_en;
	wire [7:0] score;
	
	Get_score Get_score_init(
		.clk(clk_FAST),
		.rst_n(rst_n),
		.in_H_SYNC(feature_H_SYNC),
		.in_V_SYNC(feature_V_SYNC),
		.in_data_en(feature_data_en),
		.Feature_val(Feature_val),
		.TVALID_in(in_data_en),
		.width(width),
		.height(height),
		.V_SYNC(in_V_SYNC),
		
		.abs_df1(abs_df1),
		.abs_df2(abs_df2),
		.abs_df3(abs_df3),
		.abs_df4(abs_df4),
		.abs_df5(abs_df5),
		.abs_df6(abs_df6),
		.abs_df7(abs_df7),
		.abs_df8(abs_df8),
		.abs_df9(abs_df9),
		.abs_df10(abs_df10),
		.abs_df11(abs_df11),
		.abs_df12(abs_df12),
		.abs_df13(abs_df13),
		.abs_df14(abs_df14),
		.abs_df15(abs_df15),
		.abs_df16(abs_df16),
		
		.o_H_SYNC(score_H_SYNC),
		.o_V_SYNC(score_V_SYNC),
		.o_data_en(o_data_en),
		.score(score)
	);
	
//     wire [7:0] o_score;
	//非极大值抑制
	NMS #(
		.data_width(8)
	)NMS(
		.clk(clk_FAST),
		.rst_n(rst_n),
		.in_H_SYNC(score_H_SYNC),
		.in_V_SYNC(score_V_SYNC),
		.in_data_en(score_data_en),
		.score(score),
		.width(width),
		.height(height),
		.TVALID_in(in_data_en),
		.o_H_SYNC(o_H_SYNC),
		.o_V_SYNC(o_V_SYNC),
//		.o_data_en(o_data_en),
        .o_score(data_out)
	);
	
//	VGA2AXI VGA2AXI_init(
//        .ACLK(ACLK_out),
//        .ARESTN(ARESTN_out),
//        .TDATA(TDATA_out),
//        .TSTRB(TSTRB_out),
//        .TLAST(TLAST_out),
//        .TVALID(TVALID_out),
//        .TUSER(TUSER_out),
//        .TREADY(TREADY_in),
        
//         .TVALID_in(TVALID_in),
//        .width(width),
//		.height(height),
		
//        .clk(clk),
//        .rst_n(rst_n),
//        .H_SYNC(o_H_SYNC),
//        .V_SYNC(o_V_SYNC),
//        .DATA_EN(o_data_en),
//        .pixel(o_score)
//    );
    reg [19:0] cnt;
    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            cnt <= 0;
         else
         begin
            if(in_data_en == 1)
                cnt <= cnt + 1;
            else if(cnt > height*width)
                cnt <= cnt + 1;
            else
                cnt <= cnt;
         end
    end
    assign o_data_en = cnt <= (6*width + 11) ? 0 : 
                           ((cnt < (height*width + 6*width + 11) && cnt > (height*width))? 1 : in_data_en);
endmodule 