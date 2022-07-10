module Bresenham_16point_8bit(
   input clk,
   input rst_n,
   input in_H_SYNC,
   input in_V_SYNC,
   input [8 - 1:0] data_in,
	input [10:0] width,
	input [10:0] height,
	input in_data_en,
	output reg o_H_SYNC,
   output reg o_V_SYNC,
	output reg o_data_en,
	
	//矩阵输出，输出为补码，point1-16为正数补码，center取负数
   output reg [8:0] signed_point1,
	output reg [8:0] signed_point2,
	output reg [8:0] signed_point3,
	output reg [8:0] signed_point4,
	output reg [8:0] signed_point5,
	output reg [8:0] signed_point6,
	output reg [8:0] signed_point7,
	output reg [8:0] signed_point8,
	output reg [8:0] signed_point9,
	output reg [8:0] signed_point10,
	output reg [8:0] signed_point11,
	output reg [8:0] signed_point12,
	output reg [8:0] signed_point13,
	output reg [8:0] signed_point14,
	output reg [8:0] signed_point15,
	output reg [8:0] signed_point16,
	
	output reg [8:0] signed_center
    );
    parameter data_width = 8;
//    parameter delay_time = 4*data_num - 3;
    
    parameter reg_size_720 = data_width*1280;
    parameter dalay_time_720 = 4*1280 - 3 + 2;
	 
	 parameter reg_size_480 = data_width*640;
    parameter dalay_time_480 = 4*640 - 3 + 2;
	 
	 //状态机
	 reg [1:0] resolution;
	 parameter res_640x480 = 2'b01;
	 parameter res_1280x720 = 2'b10;
	 always@(posedge clk or negedge rst_n)
	 begin
		if(~rst_n)
			resolution <= 0;
		else
		begin
			if(width == 640 && height == 480)
				resolution <= res_640x480;
			else if(width == 1280 && height == 720)
				resolution <= res_1280x720;
			else;
		end
	 end
	 
    reg [7:0] data_in_r;
	 always@(posedge clk or negedge rst_n)
	 begin
		if(~rst_n)
			data_in_r <= 0;
		else
		    if(in_data_en)
			     data_in_r <= data_in;
			else
			     data_in_r <= data_in_r;
	 end
	 
    reg [reg_size_720 - 1:0] shift720_buf1;
	 reg [reg_size_720 - 1:0] shift720_buf2;
	 reg [reg_size_720 - 1:0] shift720_buf3;
	 reg [reg_size_720 - 1:0] shift720_buf4;
	 reg [reg_size_720 - 1:0] shift720_buf5;
	 reg [reg_size_720 - 1:0] shift720_buf6;
	 reg [reg_size_720 - 1:0] shift720_buf7;
	 
	 reg [reg_size_480 - 1:0] shift480_buf1;
	 reg [reg_size_480 - 1:0] shift480_buf2;
	 reg [reg_size_480 - 1:0] shift480_buf3;
	 reg [reg_size_480 - 1:0] shift480_buf4;
	 reg [reg_size_480 - 1:0] shift480_buf5;
	 reg [reg_size_480 - 1:0] shift480_buf6;
	 reg [reg_size_480 - 1:0] shift480_buf7;
	 
	 always@(posedge clk or negedge rst_n)
	 begin
		if(~rst_n)
		begin
			shift720_buf1 <= 0;
			shift720_buf2 <= 0;
			shift720_buf3 <= 0;
			shift720_buf4 <= 0;
			shift720_buf5 <= 0;
			shift720_buf6 <= 0;
			shift720_buf7 <= 0;
			
			shift480_buf1 <= 0;
			shift480_buf2 <= 0;
			shift480_buf3 <= 0;
			shift480_buf4 <= 0;
			shift480_buf5 <= 0;
			shift480_buf6 <= 0;
			shift480_buf7 <= 0;
		end
		else
		begin
		    if(in_data_en)
		    begin
			shift480_buf1 <= {shift480_buf1[reg_size_480 -1 - data_width:0],data_in_r};
			shift480_buf2 <= {shift480_buf2[reg_size_480 -1 - data_width:0],shift480_buf1[reg_size_480 - 1:reg_size_480 -data_width]};
			shift480_buf3 <= {shift480_buf3[reg_size_480 -1 - data_width:0],shift480_buf2[reg_size_480 - 1:reg_size_480 -data_width]};
			shift480_buf4 <= {shift480_buf4[reg_size_480 -1 - data_width:0],shift480_buf3[reg_size_480 - 1:reg_size_480 -data_width]};
			shift480_buf5 <= {shift480_buf5[reg_size_480 -1 - data_width:0],shift480_buf4[reg_size_480 - 1:reg_size_480 -data_width]};
			shift480_buf6 <= {shift480_buf6[reg_size_480 -1 - data_width:0],shift480_buf5[reg_size_480 - 1:reg_size_480 -data_width]};
			shift480_buf7 <= {shift480_buf7[reg_size_480 -1 - data_width:0],shift480_buf6[reg_size_480 - 1:reg_size_480 -data_width]};
			
			shift720_buf1 <= {shift720_buf1[reg_size_720 -1 - data_width:0],data_in_r};
			shift720_buf2 <= {shift720_buf2[reg_size_720 -1 - data_width:0],shift720_buf1[reg_size_720 - 1:reg_size_720 -data_width]};
			shift720_buf3 <= {shift720_buf3[reg_size_720 -1 - data_width:0],shift720_buf2[reg_size_720 - 1:reg_size_720 -data_width]};
			shift720_buf4 <= {shift720_buf4[reg_size_720 -1 - data_width:0],shift720_buf3[reg_size_720 - 1:reg_size_720 -data_width]};
			shift720_buf5 <= {shift720_buf5[reg_size_720 -1 - data_width:0],shift720_buf4[reg_size_720 - 1:reg_size_720 -data_width]};
			shift720_buf6 <= {shift720_buf6[reg_size_720 -1 - data_width:0],shift720_buf5[reg_size_720 - 1:reg_size_720 -data_width]};
			shift720_buf7 <= {shift720_buf7[reg_size_720 -1 - data_width:0],shift720_buf6[reg_size_720 - 1:reg_size_720 -data_width]};
			end
			else
			begin
			shift480_buf1 <= shift480_buf1;
			shift480_buf2 <= shift480_buf2;
			shift480_buf3 <= shift480_buf3;
			shift480_buf4 <= shift480_buf4;
			shift480_buf5 <= shift480_buf5;
			shift480_buf6 <= shift480_buf6;
			shift480_buf7 <= shift480_buf7;
			
			shift720_buf1 <= shift720_buf1;
			shift720_buf2 <= shift720_buf2;
			shift720_buf3 <= shift720_buf3;
			shift720_buf4 <= shift720_buf4;
			shift720_buf5 <= shift720_buf5;
			shift720_buf6 <= shift720_buf6;
			shift720_buf7 <= shift720_buf7;
			end
		end
	end
	
	always@(posedge clk or negedge rst_n)
	 begin
		if(~rst_n)
		begin
			signed_point1 <= 0;
			signed_point2 <= 0;
			signed_point3 <= 0;
			signed_point4 <= 0;
			signed_point5 <= 0;
			signed_point6 <= 0;
			signed_point7 <= 0;
			signed_point8 <= 0;
			signed_point9 <= 0;
			signed_point10 <= 0;
			signed_point11 <= 0;
			signed_point12 <= 0;
			signed_point13 <= 0;
			signed_point14 <= 0;
			signed_point15 <= 0;
			signed_point16 <= 0;
			signed_center <= 0;
		end
		else
		begin
			case(resolution)
				res_640x480:
				begin
				  signed_point1 <= {1'b0, shift480_buf4[reg_size_480 - 0*data_width - 1 :reg_size_480 - 1*data_width]};//4,1
				  signed_point2 <= {1'b0, shift480_buf3[reg_size_480 - 0*data_width - 1 :reg_size_480 - 1*data_width]};//5,1
				  signed_point3 <= {1'b0, shift480_buf2[reg_size_480 - 1*data_width - 1 :reg_size_480 - 2*data_width]};//6,2
				  signed_point4 <= {1'b0, shift480_buf1[reg_size_480 - 2*data_width - 1 :reg_size_480 - 3*data_width]};//7,3
				  signed_point5 <= {1'b0, shift480_buf1[reg_size_480 - 3*data_width - 1 :reg_size_480 - 4*data_width]};//7,4
				  signed_point6 <= {1'b0, shift480_buf1[reg_size_480 - 4*data_width - 1 :reg_size_480 - 5*data_width]};//7,5
				  signed_point7 <= {1'b0, shift480_buf2[reg_size_480 - 5*data_width - 1 :reg_size_480 - 6*data_width]};//6,6
				  signed_point8 <= {1'b0, shift480_buf3[reg_size_480 - 6*data_width - 1 :reg_size_480 - 7*data_width]};//5,7
				  signed_point9 <= {1'b0, shift480_buf4[reg_size_480 - 6*data_width - 1 :reg_size_480 - 7*data_width]};//4,7
				  signed_point10<= {1'b0, shift480_buf5[reg_size_480 - 6*data_width - 1 :reg_size_480 - 7*data_width]};//3,7
				  signed_point11<= {1'b0, shift480_buf6[reg_size_480 - 5*data_width - 1 :reg_size_480 - 6*data_width]};//2,6
				  signed_point12<= {1'b0, shift480_buf7[reg_size_480 - 4*data_width - 1 :reg_size_480 - 5*data_width]};//1,5
				  signed_point13<= {1'b0, shift480_buf7[reg_size_480 - 3*data_width - 1 :reg_size_480 - 4*data_width]};//1,4
				  signed_point14<= {1'b0, shift480_buf7[reg_size_480 - 2*data_width - 1 :reg_size_480 - 3*data_width]};//1,3
				  signed_point15<= {1'b0, shift480_buf6[reg_size_480 - 1*data_width - 1 :reg_size_480 - 2*data_width]};//2,2
				  signed_point16<= {1'b0, shift480_buf5[reg_size_480 - 0*data_width - 1 :reg_size_480 - 1*data_width]};//3,1
				 
				  signed_center <= {1'b1, (~shift480_buf4[reg_size_480 - 3*data_width - 1 :reg_size_480 - 4*data_width] + 1)};
				end
				res_1280x720:
				begin
				  signed_point1 <= {1'b0, shift720_buf4[reg_size_720 - 0*data_width - 1 :reg_size_720 - 1*data_width]};//4,1
				  signed_point2 <= {1'b0, shift720_buf3[reg_size_720 - 0*data_width - 1 :reg_size_720 - 1*data_width]};//5,1
				  signed_point3 <= {1'b0, shift720_buf2[reg_size_720 - 1*data_width - 1 :reg_size_720 - 2*data_width]};//6,2
				  signed_point4 <= {1'b0, shift720_buf1[reg_size_720 - 2*data_width - 1 :reg_size_720 - 3*data_width]};//7,3
				  signed_point5 <= {1'b0, shift720_buf1[reg_size_720 - 3*data_width - 1 :reg_size_720 - 4*data_width]};//7,4
				  signed_point6 <= {1'b0, shift720_buf1[reg_size_720 - 4*data_width - 1 :reg_size_720 - 5*data_width]};//7,5
				  signed_point7 <= {1'b0, shift720_buf2[reg_size_720 - 5*data_width - 1 :reg_size_720 - 6*data_width]};//6,6
				  signed_point8 <= {1'b0, shift720_buf3[reg_size_720 - 6*data_width - 1 :reg_size_720 - 7*data_width]};//5,7
				  signed_point9 <= {1'b0, shift720_buf4[reg_size_720 - 6*data_width - 1 :reg_size_720 - 7*data_width]};//4,7
				  signed_point10<= {1'b0, shift720_buf5[reg_size_720 - 6*data_width - 1 :reg_size_720 - 7*data_width]};//3,7
				  signed_point11<= {1'b0, shift720_buf6[reg_size_720 - 5*data_width - 1 :reg_size_720 - 6*data_width]};//2,6
				  signed_point12<= {1'b0, shift720_buf7[reg_size_720 - 4*data_width - 1 :reg_size_720 - 5*data_width]};//1,5
				  signed_point13<= {1'b0, shift720_buf7[reg_size_720 - 3*data_width - 1 :reg_size_720 - 4*data_width]};//1,4
				  signed_point14<= {1'b0, shift720_buf7[reg_size_720 - 2*data_width - 1 :reg_size_720 - 3*data_width]};//1,3
				  signed_point15<= {1'b0, shift720_buf6[reg_size_720 - 1*data_width - 1 :reg_size_720 - 2*data_width]};//2,2
				  signed_point16<= {1'b0, shift720_buf5[reg_size_720 - 0*data_width - 1 :reg_size_720 - 1*data_width]};//3,1
				 
				  signed_center <= {1'b1, (~shift720_buf4[reg_size_720 - 3*data_width - 1 :reg_size_720 - 4*data_width] + 1)};
				end
				endcase
		end
	end
 
	 
//	 assign signed_point1 = {1'b0, shift_buf4[reg_size - 0*data_width - 1 :reg_size - 1*data_width]};//4,1
//	 assign signed_point2 = {1'b0, shift_buf3[reg_size - 0*data_width - 1 :reg_size - 1*data_width]};//5,1
//	 assign signed_point3 = {1'b0, shift_buf2[reg_size - 1*data_width - 1 :reg_size - 2*data_width]};//6,2
//	 assign signed_point4 = {1'b0, shift_buf1[reg_size - 2*data_width - 1 :reg_size - 3*data_width]};//7,3
//	 assign signed_point5 = {1'b0, shift_buf1[reg_size - 3*data_width - 1 :reg_size - 4*data_width]};//7,4
//	 assign signed_point6 = {1'b0, shift_buf1[reg_size - 4*data_width - 1 :reg_size - 5*data_width]};//7,5
//	 assign signed_point7 = {1'b0, shift_buf2[reg_size - 5*data_width - 1 :reg_size - 6*data_width]};//6,6
//	 assign signed_point8 = {1'b0, shift_buf3[reg_size - 6*data_width - 1 :reg_size - 7*data_width]};//5,7
//	 assign signed_point9 = {1'b0, shift_buf4[reg_size - 6*data_width - 1 :reg_size - 7*data_width]};//4,7
//	 assign signed_point10= {1'b0, shift_buf5[reg_size - 6*data_width - 1 :reg_size - 7*data_width]};//3,7
//	 assign signed_point11= {1'b0, shift_buf6[reg_size - 5*data_width - 1 :reg_size - 6*data_width]};//2,6
//	 assign signed_point12= {1'b0, shift_buf7[reg_size - 4*data_width - 1 :reg_size - 5*data_width]};//1,5
//	 assign signed_point13= {1'b0, shift_buf7[reg_size - 3*data_width - 1 :reg_size - 4*data_width]};//1,4
//	 assign signed_point14= {1'b0, shift_buf7[reg_size - 2*data_width - 1 :reg_size - 3*data_width]};//1,3
//	 assign signed_point15= {1'b0, shift_buf6[reg_size - 1*data_width - 1 :reg_size - 2*data_width]};//2,2
//	 assign signed_point16= {1'b0, shift_buf5[reg_size - 0*data_width - 1 :reg_size - 1*data_width]};//3,1
//	 
//	 assign signed_center = {1'b1, (~shift_buf4[reg_size - 3*data_width - 1 :reg_size - 4*data_width] + 1)};
	 
	 
	 //信号同步
	 reg [dalay_time_720 - 1:0] H_SYNC_r;
	 reg [dalay_time_720 - 1:0] V_SYNC_r;
	 reg [dalay_time_720 - 1:0] data_en_r;
//	 assign o_H_SYNC = H_SYNC_r[delay_time - 1];
//	 assign o_V_SYNC = V_SYNC_r[delay_time - 1];
//	 assign o_data_en = data_en_r[delay_time - 1];
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
		    if(in_data_en == 0 && signed_center == 9'h000)
		    begin
		         H_SYNC_r <= H_SYNC_r;
			     V_SYNC_r <= V_SYNC_r;
			     data_en_r <= data_en_r;
		    end
		    else
		    begin
			H_SYNC_r <= {H_SYNC_r[dalay_time_720 - 2:0],in_H_SYNC};
			V_SYNC_r <= {V_SYNC_r[dalay_time_720 - 2:0],in_V_SYNC};
			data_en_r <= {data_en_r[dalay_time_720 - 2:0],in_data_en};
			end
		end
	 end
	 
	 always@(*)
	 begin
		case(resolution)
			res_640x480:
			begin
				o_H_SYNC = H_SYNC_r[dalay_time_480 - 1];
				o_V_SYNC = V_SYNC_r[dalay_time_480 - 1];
				o_data_en = data_en_r[dalay_time_480 - 1];
			end
			res_1280x720:
			begin
				o_H_SYNC = H_SYNC_r[dalay_time_720 - 1];
				o_V_SYNC = V_SYNC_r[dalay_time_720 - 1];
				o_data_en = data_en_r[dalay_time_720 - 1];
			end
			endcase
	 end
endmodule 