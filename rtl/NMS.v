module NMS(
	input clk,
   input rst_n,
   input in_H_SYNC,
   input in_V_SYNC,
	input in_data_en,
	input [7:0] score,
	input [10:0] width,
	input [10:0] height,
	input TVALID_in,
	
	output o_H_SYNC,
   output o_V_SYNC,
	output o_data_en,
	output reg [7:0] o_score
//	output [10:0] o_x,
//	output [10:0] o_y,
//	output xy_val
);
	
	parameter data_width = 8;
	
	//提取3*3模板
	wire [7:0] mat_11;
	wire [7:0] mat_12;
	wire [7:0] mat_13;
	wire [7:0] mat_21;
	wire [7:0] mat_22;
	wire [7:0] mat_23;
	wire [7:0] mat_31;
	wire [7:0] mat_32;
	wire [7:0] mat_33;
	
	wire mat_H_SYNC;
	wire mat_V_SYNC;
	wire mat_data_en;
	
	matrix_3x3_8bit #(
		.data_width(data_width)
	)matrix_3x3_8bit(
		.clk(clk),
		.rst_n(rst_n),
		.in_H_SYNC(in_H_SYNC),
		.in_V_SYNC(in_V_SYNC),
		.in_data_en(in_data_en),
		.data_in(score),
		.width(width),
		.height(height),
		.TVALID_in(TVALID_in),
		.o_H_SYNC(mat_H_SYNC),
		.o_V_SYNC(mat_V_SYNC),
		.o_data_en(mat_data_en),
		
		.mat_11(mat_11),
		.mat_12(mat_12),
		.mat_13(mat_13),
		.mat_21(mat_21),
		.mat_22(mat_22),
		.mat_23(mat_23),
		.mat_31(mat_31),
		.mat_32(mat_32),
		.mat_33(mat_33)
	);
	
	//行、列计数器
	// reg [10:0] height_cnt;
	// reg [10:0] width_cnt;
	// always@(posedge clk or negedge rst_n)
	// begin
	// 	if(~rst_n)
	// 		height_cnt <= 1;
	// 	else if(mat_data_en == 1)
	// 	begin
	// 		if(height_cnt < height)
	// 			height_cnt <= height_cnt + 1;
	// 		else
	// 			height_cnt <= 1;
	// 	end
	// 	else
	// 		height_cnt <= 1;
	// end
	
	// always@(posedge clk or negedge rst_n)
	// begin
	// 	if(~rst_n)
	// 		width_cnt <= 1;
	// 	else if(TVALID_in == 1)
	// 	begin
	// 		if(height_cnt == height)
	// 		begin
	// 			if(width_cnt < width)
	// 				width_cnt <= width_cnt + 1;
	// 			else
	// 				width_cnt <= 1;
	// 		end
	// 		else
	// 			width_cnt <= width_cnt;
	// 	end
	// 	else
	// 		width_cnt <= 1;
	// end
	
	//计算非极大值抑制
//	reg [10:0] o_x_reg;
//	reg [10:0] o_y_reg;
//	reg xy_val_reg;
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
		begin
			o_score <= 0;
		end
		else if(TVALID_in == 1)
		begin
			if(mat_22 != 0)
			begin
				if(mat_22 >= mat_21 && mat_22 >= mat_23 && 
					mat_22 >= mat_11 && mat_22 >= mat_12 && mat_22 >= mat_13 &&
					mat_22 >= mat_31 && mat_22 >= mat_32 && mat_22 >= mat_33)
				begin
					o_score <= mat_22;
				end
				else
				begin
					o_score <= 0;
				end
			end
			else
			begin
				o_score <= 0;
			end
		end
		else
		begin
			o_score <= 0;
		end
	end

	
	//同步信号
	parameter delay_time = 2;
	reg [delay_time - 1:0] H_SYNC_r;
	reg [delay_time - 1:0] V_SYNC_r;
   reg [delay_time - 1:0] data_en_r;
	assign o_H_SYNC = H_SYNC_r[delay_time - 1];
	assign o_V_SYNC = V_SYNC_r[delay_time - 1];
	assign o_data_en = data_en_r[delay_time - 1];
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
		begin
			H_SYNC_r <= 0;
			V_SYNC_r <= 0;
			data_en_r <= 0;
		end
		else
		begin
		    if(TVALID_in ==  0)
		    begin
		         H_SYNC_r <= H_SYNC_r;
			     V_SYNC_r <= V_SYNC_r;
			     data_en_r <= data_en_r;
		    end
		    else
		    begin
			H_SYNC_r <= {H_SYNC_r[delay_time - 2:0],mat_H_SYNC};
			V_SYNC_r <= {V_SYNC_r[delay_time - 2:0],mat_V_SYNC};
			data_en_r <= {data_en_r[delay_time - 2:0],mat_data_en};
			end
		end
	end
endmodule 