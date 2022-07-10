module Get_score(
	input clk,
	input rst_n,
	input in_H_SYNC,
	input in_V_SYNC,
	input in_data_en,
	input V_SYNC,
	
	input TVALID_in,
	input [10:0] width,
	input [10:0] height,
	
	input Feature_val,
	input [7:0] abs_df1,
	input [7:0] abs_df2,
	input [7:0] abs_df3,
	input [7:0] abs_df4,
	input [7:0] abs_df5,
	input [7:0] abs_df6,
	input [7:0] abs_df7,
	input [7:0] abs_df8,
	input [7:0] abs_df9,
	input [7:0] abs_df10,
	input [7:0] abs_df11,
	input [7:0] abs_df12,
	input [7:0] abs_df13,
	input [7:0] abs_df14,
	input [7:0] abs_df15,
	input [7:0] abs_df16,
	
	output o_H_SYNC,
	output o_V_SYNC,
	output o_data_en,
	output [7:0] score
);
	//////////////////////////////////////////////
	function [15:0] Get_threshold_flag(
		input [7:0] abs_df1,
		input [7:0] abs_df2,
		input [7:0] abs_df3,
		input [7:0] abs_df4,
		input [7:0] abs_df5,
		input [7:0] abs_df6,
		input [7:0] abs_df7,
		input [7:0] abs_df8,
		input [7:0] abs_df9,
		input [7:0] abs_df10,
		input [7:0] abs_df11,
		input [7:0] abs_df12,
		input [7:0] abs_df13,
		input [7:0] abs_df14,
		input [7:0] abs_df15,
		input [7:0] abs_df16,
		input [7:0] th
	);
	begin
		Get_threshold_flag[0] = abs_df1 >= th ? 1 : 0;
		Get_threshold_flag[1] = abs_df2 >= th ? 1 : 0;
		Get_threshold_flag[2] = abs_df3 >= th ? 1 : 0;
		Get_threshold_flag[3] = abs_df4 >= th ? 1 : 0;
		Get_threshold_flag[4] = abs_df5 >= th ? 1 : 0;
		Get_threshold_flag[5] = abs_df6 >= th ? 1 : 0;
		Get_threshold_flag[6] = abs_df7 >= th ? 1 : 0;
		Get_threshold_flag[7] = abs_df8 >= th ? 1 : 0;
		Get_threshold_flag[8] = abs_df9 >= th ? 1 : 0;
		Get_threshold_flag[9] = abs_df10 >= th ? 1 : 0;
		Get_threshold_flag[10]= abs_df11 >= th ? 1 : 0;
		Get_threshold_flag[11]= abs_df12 >= th ? 1 : 0;
		Get_threshold_flag[12]= abs_df13 >= th ? 1 : 0;
		Get_threshold_flag[13]= abs_df14 >= th ? 1 : 0;
		Get_threshold_flag[14]= abs_df15 >= th ? 1 : 0;
		Get_threshold_flag[15]= abs_df16 >= th ? 1 : 0;
	end
	endfunction 
	
	//////////////////////////////////////////////
	function  Find_Sequence(
		input [15:0] threshold_flag
	);
	reg Sf1; 
	reg Sf2;
	reg Sf3; 
	reg Sf4;
	reg Sf5; 
	reg Sf6; 
	reg Sf7; 
	reg Sf8;
	reg Sf9; 
	reg Sf10;
	reg Sf11;
	reg Sf12;
	reg Sf13;
	reg Sf14;
	reg Sf15;
	reg Sf16;
	parameter s1 = 16'b1111111110000000,
				 s2 = 16'b0111111111000000,
				 s3 = 16'b0011111111100000,
				 s4 = 16'b0001111111110000,
				 s5 = 16'b0000111111111000,
				 s6 = 16'b0000011111111100,
				 s7 = 16'b0000001111111110,
				 s8 = 16'b0000000111111111,
				 s9 = 16'b1000000011111111,
				 s10= 16'b1100000001111111,
				 s11= 16'b1110000000111111,
				 s12= 16'b1111000000011111,
				 s13= 16'b1111100000001111,
				 s14= 16'b1111110000000111,
				 s15= 16'b1111111000000011,
				 s16= 16'b1111111100000001;
	begin
		Sf1 =  (threshold_flag & s1) == s1 ? 1:0;
		Sf2 =  (threshold_flag & s2) == s2 ? 1:0;
		Sf3 =  (threshold_flag & s3) == s3 ? 1:0;
		Sf4 =  (threshold_flag & s4) == s4 ? 1:0;
		Sf5 =  (threshold_flag & s5) == s5 ? 1:0;
		Sf6 =  (threshold_flag & s6) == s6 ? 1:0;
		Sf7 =  (threshold_flag & s7) == s7 ? 1:0;
		Sf8 =  (threshold_flag & s8) == s8 ? 1:0;
		Sf9 =  (threshold_flag & s9) == s9 ? 1:0;
		Sf10=  (threshold_flag & s10) == s10 ? 1:0;
		Sf11=  (threshold_flag & s11) == s11 ? 1:0;
		Sf12=  (threshold_flag & s12) == s12 ? 1:0;
		Sf13=  (threshold_flag & s13) == s13 ? 1:0;
		Sf14=  (threshold_flag & s14) == s14 ? 1:0;
		Sf15=  (threshold_flag & s15) == s15 ? 1:0;
		Sf16=  (threshold_flag & s16) == s16 ? 1:0;
		
		Find_Sequence = Sf1 | Sf2 | Sf3 | Sf4 |
									  Sf5 | Sf6 | Sf7 | Sf8 |
									  Sf9 | Sf10| Sf11| Sf12|
									  Sf13| Sf14| Sf15| Sf16;
	end
	endfunction

	//////////////////////////////////////////////
	function [7:0] Find_max(
		input [7:0] data1,
		input [7:0] data2
	);
	begin
		if(data1 >= data2)
			Find_max = data1;
		else
			Find_max = data2;
	end
	endfunction
	//////////////////////////////////////////////
	reg [15:0] threshold_flag1;
	reg [15:0] threshold_flag2;
	reg [15:0] threshold_flag3;
	reg [15:0] threshold_flag4;
	reg [15:0] threshold_flag5;
	reg [15:0] threshold_flag6;
	reg [15:0] threshold_flag7;
	reg [15:0] threshold_flag8;
	reg [15:0] threshold_flag9;
	reg [15:0] threshold_flag10;
	reg [15:0] threshold_flag11;
	reg [15:0] threshold_flag12;
	reg [15:0] threshold_flag13;
	reg [15:0] threshold_flag14;
	reg [15:0] threshold_flag15;
	reg [15:0] threshold_flag16;
	
	//行、列计数器，使用输出有效信号来同步
//	parameter height = 720;
//	parameter width = 1280;
	reg [10:0] height_cnt;
	reg [10:0] width_cnt;
	reg [11:0] cnt; 
	wire cnt_data_en;
	always@(posedge clk or negedge rst_n)
	begin
	   if(~rst_n)
	       cnt <= 0;
	   else if(V_SYNC == 0)
	       cnt <= 0;
	   else
	   begin
	       if(in_data_en)
	       begin
	           if(cnt <= (4*width - 3 + 2 + 4))
	               cnt <= cnt + 1;
	           else
	               cnt <= cnt;
	       end
	       else
	           cnt <= cnt;
	   end
	end
	assign cnt_data_en = cnt >= (4*width - 3 + 2 + 4)? 1 : 0;
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
			width_cnt <= 1;
		else if(cnt_data_en == 1)
		begin
			if(width_cnt < width)
				width_cnt <= width_cnt + 1;
			else
				width_cnt <= 1;
		end
		else
			width_cnt <= width_cnt;
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
			height_cnt <= 1;
		else if(cnt_data_en == 1)
		begin
			if(width_cnt == width)
			begin
				if(height_cnt < height)
					height_cnt <= height_cnt + 1;
				else
					height_cnt <= 1;
			end
			else
				height_cnt <= height_cnt;
		end
		else
			height_cnt <= height_cnt;
	end
	
	// 1
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
		begin
			threshold_flag1 <= 0;
			threshold_flag2 <= 0;
			threshold_flag3 <= 0;
			threshold_flag4 <= 0;
			threshold_flag5 <= 0;
			threshold_flag6 <= 0;
			threshold_flag7 <= 0;
			threshold_flag8 <= 0;
			threshold_flag9 <= 0;
			threshold_flag10<= 0;
			threshold_flag11<= 0;
			threshold_flag12<= 0;
			threshold_flag13<= 0;
			threshold_flag14<= 0;
			threshold_flag15<= 0;
			threshold_flag16<= 0;
		end
		else
		begin
		    if(TVALID_in)
		    begin
			threshold_flag1 <= Get_threshold_flag(abs_df1, abs_df2, abs_df3, abs_df4, 
															  abs_df5, abs_df6, abs_df7, abs_df8,
															  abs_df9, abs_df10,abs_df11,abs_df12,
															  abs_df13,abs_df14,abs_df15,abs_df16,abs_df1);
			threshold_flag2 <= Get_threshold_flag(abs_df1, abs_df2, abs_df3, abs_df4, 
															  abs_df5, abs_df6, abs_df7, abs_df8,
															  abs_df9, abs_df10,abs_df11,abs_df12,
															  abs_df13,abs_df14,abs_df15,abs_df16,abs_df2);
			threshold_flag3 <= Get_threshold_flag(abs_df1, abs_df2, abs_df3, abs_df4, 
															  abs_df5, abs_df6, abs_df7, abs_df8,
															  abs_df9, abs_df10,abs_df11,abs_df12,
															  abs_df13,abs_df14,abs_df15,abs_df16,abs_df3);
			threshold_flag4 <= Get_threshold_flag(abs_df1, abs_df2, abs_df3, abs_df4, 
															  abs_df5, abs_df6, abs_df7, abs_df8,
															  abs_df9, abs_df10,abs_df11,abs_df12,
															  abs_df13,abs_df14,abs_df15,abs_df16,abs_df4);
			threshold_flag5 <= Get_threshold_flag(abs_df1, abs_df2, abs_df3, abs_df4, 
															  abs_df5, abs_df6, abs_df7, abs_df8,
															  abs_df9, abs_df10,abs_df11,abs_df12,
															  abs_df13,abs_df14,abs_df15,abs_df16,abs_df5);
			threshold_flag6 <= Get_threshold_flag(abs_df1, abs_df2, abs_df3, abs_df4, 
															  abs_df5, abs_df6, abs_df7, abs_df8,
															  abs_df9, abs_df10,abs_df11,abs_df12,
															  abs_df13,abs_df14,abs_df15,abs_df16,abs_df6);
			threshold_flag7 <= Get_threshold_flag(abs_df1, abs_df2, abs_df3, abs_df4, 
															  abs_df5, abs_df6, abs_df7, abs_df8,
															  abs_df9, abs_df10,abs_df11,abs_df12,
															  abs_df13,abs_df14,abs_df15,abs_df16,abs_df7);
			threshold_flag8 <= Get_threshold_flag(abs_df1, abs_df2, abs_df3, abs_df4, 
															  abs_df5, abs_df6, abs_df7, abs_df8,
															  abs_df9, abs_df10,abs_df11,abs_df12,
															  abs_df13,abs_df14,abs_df15,abs_df16,abs_df8);
			threshold_flag9 <= Get_threshold_flag(abs_df1, abs_df2, abs_df3, abs_df4, 
															  abs_df5, abs_df6, abs_df7, abs_df8,
															  abs_df9, abs_df10,abs_df11,abs_df12,
															  abs_df13,abs_df14,abs_df15,abs_df16,abs_df9);
			threshold_flag10<= Get_threshold_flag(abs_df1, abs_df2, abs_df3, abs_df4, 
															  abs_df5, abs_df6, abs_df7, abs_df8,
															  abs_df9, abs_df10,abs_df11,abs_df12,
															  abs_df13,abs_df14,abs_df15,abs_df16,abs_df10);
			threshold_flag11<= Get_threshold_flag(abs_df1, abs_df2, abs_df3, abs_df4, 
															  abs_df5, abs_df6, abs_df7, abs_df8,
															  abs_df9, abs_df10,abs_df11,abs_df12,
															  abs_df13,abs_df14,abs_df15,abs_df16,abs_df11);
			threshold_flag12<= Get_threshold_flag(abs_df1, abs_df2, abs_df3, abs_df4, 
															  abs_df5, abs_df6, abs_df7, abs_df8,
															  abs_df9, abs_df10,abs_df11,abs_df12,
															  abs_df13,abs_df14,abs_df15,abs_df16,abs_df12);
			threshold_flag13<= Get_threshold_flag(abs_df1, abs_df2, abs_df3, abs_df4, 
															  abs_df5, abs_df6, abs_df7, abs_df8,
															  abs_df9, abs_df10,abs_df11,abs_df12,
															  abs_df13,abs_df14,abs_df15,abs_df16,abs_df13);
			threshold_flag14<= Get_threshold_flag(abs_df1, abs_df2, abs_df3, abs_df4, 
															  abs_df5, abs_df6, abs_df7, abs_df8,
															  abs_df9, abs_df10,abs_df11,abs_df12,
															  abs_df13,abs_df14,abs_df15,abs_df16,abs_df14);
			threshold_flag15<= Get_threshold_flag(abs_df1, abs_df2, abs_df3, abs_df4, 
															  abs_df5, abs_df6, abs_df7, abs_df8,
															  abs_df9, abs_df10,abs_df11,abs_df12,
															  abs_df13,abs_df14,abs_df15,abs_df16,abs_df15);
			threshold_flag16<= Get_threshold_flag(abs_df1, abs_df2, abs_df3, abs_df4, 
															  abs_df5, abs_df6, abs_df7, abs_df8,
															  abs_df9, abs_df10,abs_df11,abs_df12,
															  abs_df13,abs_df14,abs_df15,abs_df16,abs_df16);
			end
			else;
		end
	end
	
	///将绝对值缓存一个周期?
	reg [7:0] abs_df1_r1;
	reg [7:0] abs_df2_r1;
	reg [7:0] abs_df3_r1;
	reg [7:0] abs_df4_r1;
	reg [7:0] abs_df5_r1;
	reg [7:0] abs_df6_r1;
	reg [7:0] abs_df7_r1;
	reg [7:0] abs_df8_r1;
	reg [7:0] abs_df9_r1;
	reg [7:0] abs_df10_r1;
	reg [7:0] abs_df11_r1;
	reg [7:0] abs_df12_r1;
	reg [7:0] abs_df13_r1;
	reg [7:0] abs_df14_r1;
	reg [7:0] abs_df15_r1;
	reg [7:0] abs_df16_r1;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
		begin
			abs_df1_r1 <= 0;
			abs_df2_r1 <= 0;
			abs_df3_r1 <= 0;
			abs_df4_r1 <= 0;
			abs_df5_r1 <= 0;
			abs_df6_r1 <= 0;
			abs_df7_r1 <= 0;
			abs_df8_r1 <= 0;
			abs_df9_r1 <= 0;
			abs_df10_r1 <= 0;
			abs_df11_r1 <= 0;
			abs_df12_r1 <= 0;
			abs_df13_r1 <= 0;
			abs_df14_r1 <= 0;
			abs_df15_r1 <= 0;
			abs_df16_r1 <= 0;
		end
		else
		begin
		    if(TVALID_in)
		    begin
			abs_df1_r1 <= abs_df1;
			abs_df2_r1 <= abs_df2;
			abs_df3_r1 <= abs_df3;
			abs_df4_r1 <= abs_df4;
			abs_df5_r1 <= abs_df5;
			abs_df6_r1 <= abs_df6;
			abs_df7_r1 <= abs_df7;
			abs_df8_r1 <= abs_df8;
			abs_df9_r1 <= abs_df9;
			abs_df10_r1 <= abs_df10;
			abs_df11_r1 <= abs_df11;
			abs_df12_r1 <= abs_df12;
			abs_df13_r1 <= abs_df13;
			abs_df14_r1 <= abs_df14;
			abs_df15_r1 <= abs_df15;
			abs_df16_r1 <= abs_df16;
			end
			else
			begin
			abs_df1_r1 <= abs_df1_r1;
			abs_df2_r1 <= abs_df2_r1;
			abs_df3_r1 <= abs_df3_r1;
			abs_df4_r1 <= abs_df4_r1;
			abs_df5_r1 <= abs_df5_r1;
			abs_df6_r1 <= abs_df6_r1;
			abs_df7_r1 <= abs_df7_r1;
			abs_df8_r1 <= abs_df8_r1;
			abs_df9_r1 <= abs_df9_r1;
			abs_df10_r1 <= abs_df10_r1;
			abs_df11_r1 <= abs_df11_r1;
			abs_df12_r1 <= abs_df12_r1;
			abs_df13_r1 <= abs_df13_r1;
			abs_df14_r1 <= abs_df14_r1;
			abs_df15_r1 <= abs_df15_r1;
			abs_df16_r1 <= abs_df16_r1;
			end
		end
	end
	
	// 2
	reg [15:0] sequence_flag;
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
			sequence_flag <= 0;
		else
		begin
		    if(TVALID_in)
		    begin
			sequence_flag[0] <= Find_Sequence(threshold_flag1);
			sequence_flag[1] <= Find_Sequence(threshold_flag2);
			sequence_flag[2] <= Find_Sequence(threshold_flag3);
			sequence_flag[3] <= Find_Sequence(threshold_flag4);
			sequence_flag[4] <= Find_Sequence(threshold_flag5);
			sequence_flag[5] <= Find_Sequence(threshold_flag6);
			sequence_flag[6] <= Find_Sequence(threshold_flag7);
			sequence_flag[7] <= Find_Sequence(threshold_flag8);
			sequence_flag[8] <= Find_Sequence(threshold_flag9);
			sequence_flag[9] <= Find_Sequence(threshold_flag10);
			sequence_flag[10] <= Find_Sequence(threshold_flag11);
			sequence_flag[11] <= Find_Sequence(threshold_flag12);
			sequence_flag[12] <= Find_Sequence(threshold_flag13);
			sequence_flag[13] <= Find_Sequence(threshold_flag14);
			sequence_flag[14] <= Find_Sequence(threshold_flag15);
			sequence_flag[15] <= Find_Sequence(threshold_flag16);
			end
			else;
		end
	end
	//两两比较，判断满足条件的最大值
	//3
	reg [7:0] cmp1_1;
	reg [7:0] cmp1_2;
	reg [7:0] cmp1_3;
	reg [7:0] cmp1_4;
	reg [7:0] cmp1_5;
	reg [7:0] cmp1_6;
	reg [7:0] cmp1_7;
	reg [7:0] cmp1_8;
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
		begin
			cmp1_1 <= 0;
			cmp1_2 <= 0;
			cmp1_3 <= 0;
			cmp1_4 <= 0;
			cmp1_5 <= 0;
			cmp1_6 <= 0;
			cmp1_7 <= 0;
			cmp1_8 <= 0;
		end
		else
		begin
		    if(TVALID_in)
		    begin
			cmp1_1 <= Find_max((abs_df1_r1 * sequence_flag[0]), (abs_df2_r1 * sequence_flag[1]) );
			cmp1_2 <= Find_max((abs_df3_r1 * sequence_flag[2]), (abs_df4_r1 * sequence_flag[3]) );   
			cmp1_3 <= Find_max((abs_df5_r1 * sequence_flag[4]), (abs_df6_r1 * sequence_flag[5]) );   
			cmp1_4 <= Find_max((abs_df7_r1 * sequence_flag[6]), (abs_df8_r1 * sequence_flag[7]) );   
			cmp1_5 <= Find_max((abs_df9_r1 * sequence_flag[8]), (abs_df10_r1 * sequence_flag[9]) );   
			cmp1_6 <= Find_max((abs_df11_r1 * sequence_flag[10]), (abs_df12_r1 * sequence_flag[11]) );   
			cmp1_7 <= Find_max((abs_df13_r1 * sequence_flag[12]), (abs_df14_r1 * sequence_flag[13]) );   
			cmp1_8 <= Find_max((abs_df15_r1 * sequence_flag[14]), (abs_df16_r1 * sequence_flag[15]) );   
			end
			else;
		end
	end
	//4
	reg [7:0] cmp2_1;
	reg [7:0] cmp2_2;
	reg [7:0] cmp2_3;
	reg [7:0] cmp2_4;
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
		begin
			cmp2_1 <= 0;
			cmp2_2 <= 0;
			cmp2_3 <= 0;
			cmp2_4 <= 0;
		end
		else
		begin
		    if(TVALID_in)
		    begin
			cmp2_1 <= Find_max(cmp1_1, cmp1_2);
			cmp2_2 <= Find_max(cmp1_3, cmp1_4);
			cmp2_3 <= Find_max(cmp1_5, cmp1_6);
			cmp2_4 <= Find_max(cmp1_7, cmp1_8);
			end
			else;
		end
	end
	//5
	reg [7:0] cmp3_1;
	reg [7:0] cmp3_2;
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
		begin
			cmp3_1 <= 0;
			cmp3_2 <= 0;
		end
		else
		begin
		    if(TVALID_in)
		    begin
			cmp3_1 <= Find_max(cmp2_1, cmp2_2);
			cmp3_2 <= Find_max(cmp2_3, cmp2_4);
			end
			else;
		end
	end
	
	// Feature_val延迟5个周期
	reg Feature_val_r1, Feature_val_r2,
		 Feature_val_r3, Feature_val_r4, Feature_val_r5;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
		begin
			Feature_val_r1 <= 0;
			Feature_val_r2 <= 0;
			Feature_val_r3 <= 0;
			Feature_val_r4 <= 0;
			Feature_val_r5 <= 0;
		end
		else
		begin
		    if(TVALID_in)
		    begin
			Feature_val_r1 <= Feature_val;
			Feature_val_r2 <= Feature_val_r1;
			Feature_val_r3 <= Feature_val_r2;
			Feature_val_r4 <= Feature_val_r3;
			Feature_val_r5 <= Feature_val_r4;
			end
			else
			begin
			Feature_val_r1 <= Feature_val_r1;
			Feature_val_r2 <= Feature_val_r2;
			Feature_val_r3 <= Feature_val_r3;
			Feature_val_r4 <= Feature_val_r4;
			Feature_val_r5 <= Feature_val_r5;
			end
		end
	end
	
	//6
	reg [7:0] o_score;
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
			o_score <= 0;
		else
		begin
			if((height_cnt <= 3) || (height_cnt > height - 3) ||//判断是否为边界点
				(width_cnt <= 3) || (width_cnt > width - 3))
				o_score <= 0;
			else
				o_score <= Feature_val_r5 == 1? Find_max(cmp3_1, cmp3_2) : 0;
		end
	end
	assign score = o_score;
	
	//信号同步
	 parameter delay_time = 6;//输出延迟为6个周期
	
	 reg [delay_time - 1:0] H_SYNC_r;
	 reg [delay_time - 1:0] V_SYNC_r;
//	 reg [delay_time - 1:0] data_en_r;
	 assign o_H_SYNC = H_SYNC_r[delay_time - 1];
	 assign o_V_SYNC = V_SYNC_r[delay_time - 1];
//	 assign o_data_en = data_en_r[delay_time - 1];
//	 assign cnt_data_en = data_en_r[4];
	 always@(posedge clk or negedge rst_n)
	 begin
		if(~rst_n)
		begin
			H_SYNC_r <= 0;
			V_SYNC_r <= 0;
//			data_en_r <= 0;
		end
		else
		begin
		    if(TVALID_in == 0)
		    begin
		         H_SYNC_r <= H_SYNC_r;
			     V_SYNC_r <= V_SYNC_r;
//			     data_en_r <= data_en_r;
		    end
		    else
		    begin
			H_SYNC_r <= {H_SYNC_r[delay_time - 2:0],in_H_SYNC};
			V_SYNC_r <= {V_SYNC_r[delay_time - 2:0],in_V_SYNC};
//			data_en_r <= {data_en_r[delay_time - 2:0],in_data_en};
			end
		end
	 end
	
endmodule 