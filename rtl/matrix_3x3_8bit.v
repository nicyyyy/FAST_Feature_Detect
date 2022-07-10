module matrix_3x3_8bit(
	input clk,
   input rst_n,
   input in_H_SYNC,
   input in_V_SYNC,
   input [7:0] data_in,
	input in_data_en,
	input [10:0] width,
	input [10:0] height,
	input TVALID_in,
	output reg o_H_SYNC,
   output reg o_V_SYNC,
	output reg o_data_en,
	
	output reg [7:0] mat_11,
	output reg [7:0] mat_12,
	output reg [7:0] mat_13,
	output reg [7:0] mat_21,
	output reg [7:0] mat_22,
	output reg [7:0] mat_23,
	output reg [7:0] mat_31,
	output reg [7:0] mat_32,
	output reg [7:0] mat_33
);
	
	parameter data_width = 8;
//	parameter delay_time = 2*data_num - 1;
	
	parameter reg_size_720 = data_width*1280;
   parameter delay_time_720 = 2*1280 - 1 + 2;
	 
	parameter reg_size_480 = data_width*640;
    parameter delay_time_480 = 2*640 - 1 + 2;
	 
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
		    if(TVALID_in)
			     data_in_r <= data_in;
			else
			     data_in_r <= data_in_r;
	 end
	//提取3*3模板
	reg [reg_size_720 - 1:0] shift720_buf1;
	reg [reg_size_720 - 1:0] shift720_buf2;
	reg [reg_size_720 - 1:0] shift720_buf3;
	
	reg [reg_size_480 - 1:0] shift480_buf1;
	reg [reg_size_480 - 1:0] shift480_buf2;
	reg [reg_size_480 - 1:0] shift480_buf3;
	
	always@(posedge clk or negedge rst_n)
	 begin
		if(~rst_n)
		begin
			shift720_buf1 <= 0;
			shift720_buf2 <= 0;
			shift720_buf3 <= 0;
			
			shift480_buf1 <= 0;
			shift480_buf2 <= 0;
			shift480_buf3 <= 0;
		end
		else
		begin
		    if(TVALID_in)
		    begin
			shift720_buf1 <= {shift720_buf1[reg_size_720 -1 - data_width:0],data_in_r};
			shift720_buf2 <= {shift720_buf2[reg_size_720 -1 - data_width:0],shift720_buf1[reg_size_720 - 1:reg_size_720 - data_width]};
			shift720_buf3 <= {shift720_buf3[reg_size_720 -1 - data_width:0],shift720_buf2[reg_size_720 - 1:reg_size_720 - data_width]};
			
			shift480_buf1 <= {shift480_buf1[reg_size_480 -1 - data_width:0],data_in_r};
			shift480_buf2 <= {shift480_buf2[reg_size_480 -1 - data_width:0],shift480_buf1[reg_size_480 - 1:reg_size_480 - data_width]};
			shift480_buf3 <= {shift480_buf3[reg_size_480 -1 - data_width:0],shift480_buf2[reg_size_480 - 1:reg_size_480 - data_width]};
		    end
		    else;
		end
	 end
	 
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
		begin
			mat_11 <= 0;
			mat_12 <= 0;
			mat_13 <= 0;
			
			mat_21 <= 0;
			mat_22 <= 0;
			mat_23 <= 0;
			
			mat_31 <= 0;
			mat_32 <= 0;
			mat_33 <= 0;
		end
		else
		begin
			case(resolution)
			res_640x480:
			begin
				  mat_11 <= shift480_buf3[reg_size_480 - 1 -0*data_width:reg_size_480 - 1*data_width];
				  mat_12 <= shift480_buf3[reg_size_480 - 1 -1*data_width:reg_size_480 - 2*data_width];
				  mat_13 <= shift480_buf3[reg_size_480 - 1 -2*data_width:reg_size_480 - 3*data_width];
				 
				  mat_21 <= shift480_buf2[reg_size_480 - 1 -0*data_width:reg_size_480 - 1*data_width];
				  mat_22 <= shift480_buf2[reg_size_480 - 1 -1*data_width:reg_size_480 - 2*data_width];
				  mat_23 <= shift480_buf2[reg_size_480 - 1 -2*data_width:reg_size_480 - 3*data_width];
				 
				  mat_31 <= shift480_buf1[reg_size_480 - 1 -0*data_width:reg_size_480 - 1*data_width];
				  mat_32 <= shift480_buf1[reg_size_480 - 1 -1*data_width:reg_size_480 - 2*data_width];
				  mat_33 <= shift480_buf1[reg_size_480 - 1 -2*data_width:reg_size_480 - 3*data_width];
			end
			res_1280x720:
			begin
				  mat_11 <= shift720_buf3[reg_size_720 - 1 -0*data_width:reg_size_720 - 1*data_width];
				  mat_12 <= shift720_buf3[reg_size_720 - 1 -1*data_width:reg_size_720 - 2*data_width];
				  mat_13 <= shift720_buf3[reg_size_720 - 1 -2*data_width:reg_size_720 - 3*data_width];
				
				  mat_21 <= shift720_buf2[reg_size_720 - 1 -0*data_width:reg_size_720 - 1*data_width];
				  mat_22 <= shift720_buf2[reg_size_720 - 1 -1*data_width:reg_size_720 - 2*data_width];
				  mat_23 <= shift720_buf2[reg_size_720 - 1 -2*data_width:reg_size_720 - 3*data_width];
			
				  mat_31 <= shift720_buf1[reg_size_720 - 1 -0*data_width:reg_size_720 - 1*data_width];
				  mat_32 <= shift720_buf1[reg_size_720 - 1 -1*data_width:reg_size_720 - 2*data_width];
				  mat_33 <= shift720_buf1[reg_size_720 - 1 -2*data_width:reg_size_720 - 3*data_width];
			end
			endcase
		end
	end
//	always@(posedge clk or negedge rst_n)//1
//    begin
//        if(~rst_n)
//            shift_buf1 <= 0;
//        else
//            shift_buf1 <= {shift_buf1[reg_size -1 - data_width:0],data_in};
//    end
//	 
//	 always@(posedge clk or negedge rst_n)//2
//    begin
//        if(~rst_n)
//            shift_buf2 <= 0;
//        else
//            shift_buf2 <= {shift_buf2[reg_size -1 - data_width:0],shift_buf1[reg_size - 1:reg_size - data_width]};
//    end
//	 
//	 always@(posedge clk or negedge rst_n)//3
//    begin
//        if(~rst_n)
//            shift_buf3 <= 0;
//        else
//            shift_buf3 <= {shift_buf3[reg_size -1 - data_width:0],shift_buf2[reg_size - 1:reg_size - data_width]};
//    end
	 
//	 assign mat_11 = shift_buf3[reg_size - 1 -0*data_width:reg_size - 1*data_width];
//	 assign mat_12 = shift_buf3[reg_size - 1 -1*data_width:reg_size - 2*data_width];
//	 assign mat_13 = shift_buf3[reg_size - 1 -2*data_width:reg_size - 3*data_width];
//	 
//	 assign mat_21 = shift_buf2[reg_size - 1 -0*data_width:reg_size - 1*data_width];
//	 assign mat_22 = shift_buf2[reg_size - 1 -1*data_width:reg_size - 2*data_width];
//	 assign mat_23 = shift_buf2[reg_size - 1 -2*data_width:reg_size - 3*data_width];
//	 
//	 assign mat_31 = shift_buf1[reg_size - 1 -0*data_width:reg_size - 1*data_width];
//	 assign mat_32 = shift_buf1[reg_size - 1 -1*data_width:reg_size - 2*data_width];
//	 assign mat_33 = shift_buf1[reg_size - 1 -2*data_width:reg_size - 3*data_width];
	 
	 //信号同步
	 reg [delay_time_720 - 1:0] H_SYNC_r;
	 reg [delay_time_720 - 1:0] V_SYNC_r;
	 reg [delay_time_720 - 1:0] data_en_r;
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
		    if(TVALID_in == 0)
		    begin
		         H_SYNC_r <= H_SYNC_r;
			     V_SYNC_r <= V_SYNC_r;
			     data_en_r <= data_en_r;
		    end
		    else
		    begin
			H_SYNC_r <= {H_SYNC_r[delay_time_720 - 2:0],in_H_SYNC};
			V_SYNC_r <= {V_SYNC_r[delay_time_720 - 2:0],in_V_SYNC};
			data_en_r <= {data_en_r[delay_time_720 - 2:0],in_data_en};
			end
		end
	 end
	 
	 always@(*)
	 begin
		case(resolution)
			res_640x480:
			begin
				o_H_SYNC = H_SYNC_r[delay_time_480 - 1];
				o_V_SYNC = V_SYNC_r[delay_time_480 - 1];
				o_data_en = data_en_r[delay_time_480 - 1];
			end
			res_1280x720:
			begin
				o_H_SYNC = H_SYNC_r[delay_time_720 - 1];
				o_V_SYNC = V_SYNC_r[delay_time_720 - 1];
				o_data_en = data_en_r[delay_time_720 - 1];
			end
			endcase
	 end
endmodule 