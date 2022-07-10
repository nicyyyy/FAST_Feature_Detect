module Get_Feature_point(
	input clk,
	input rst_n,
	input in_H_SYNC,
	input in_V_SYNC,
	input in_data_en,
	input [7:0] threshold,
	
	input TVALID_in,
	
	input [8:0] signed_point1,
	input [8:0] signed_point2,
	input [8:0] signed_point3,
	input [8:0] signed_point4,
	input [8:0] signed_point5,
	input [8:0] signed_point6,
	input [8:0] signed_point7,
	input [8:0] signed_point8,
	input [8:0] signed_point9,
	input [8:0] signed_point10,
	input [8:0] signed_point11,
	input [8:0] signed_point12,
	input [8:0] signed_point13,
	input [8:0] signed_point14,
	input [8:0] signed_point15,
	input [8:0] signed_point16,
	input [8:0] signed_center,
	
	output o_H_SYNC,
	output o_V_SYNC,
	output o_data_en,
	output Feature_val,
	
	output [7:0] o_abs_df1,
	output [7:0] o_abs_df2,
	output [7:0] o_abs_df3,
	output [7:0] o_abs_df4,
	output [7:0] o_abs_df5,
	output [7:0] o_abs_df6,
	output [7:0] o_abs_df7,
	output [7:0] o_abs_df8,
	output [7:0] o_abs_df9,
	output [7:0] o_abs_df10,
	output [7:0] o_abs_df11,
	output [7:0] o_abs_df12,
	output [7:0] o_abs_df13,
	output [7:0] o_abs_df14,
	output [7:0] o_abs_df15,
	output [7:0] o_abs_df16
);
	
	
	//1.与中心点做差，补码相加
	reg [8:0] signed_df1;
	reg [8:0] signed_df2;
	reg [8:0] signed_df3;
	reg [8:0] signed_df4;
	reg [8:0] signed_df5;
	reg [8:0] signed_df6;
	reg [8:0] signed_df7;
	reg [8:0] signed_df8;
	reg [8:0] signed_df9;
	reg [8:0] signed_df10;
	reg [8:0] signed_df11;
	reg [8:0] signed_df12;
	reg [8:0] signed_df13;
	reg [8:0] signed_df14;
	reg [8:0] signed_df15;
	reg [8:0] signed_df16;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
		begin
			signed_df1 <= 0;
			signed_df2 <= 0;
			signed_df3 <= 0;
			signed_df4 <= 0;
			signed_df5 <= 0;
			signed_df6 <= 0;
			signed_df7 <= 0;
			signed_df8 <= 0;
			signed_df9 <= 0;
			signed_df10 <= 0;
			signed_df11 <= 0;
			signed_df12 <= 0;
			signed_df13 <= 0;
			signed_df14 <= 0;
			signed_df15 <= 0;
			signed_df16 <= 0;
		end
		else
		begin
		    if(TVALID_in)
		    begin
			signed_df1 <= signed_point1 + signed_center;
			signed_df2 <= signed_point2 + signed_center;
			signed_df3 <= signed_point3 + signed_center;
			signed_df4 <= signed_point4 + signed_center;
			signed_df5 <= signed_point5 + signed_center;
			signed_df6 <= signed_point6 + signed_center;
			signed_df7 <= signed_point7 + signed_center;
			signed_df8 <= signed_point8 + signed_center;
			signed_df9 <= signed_point9 + signed_center;
			signed_df10 <= signed_point10 + signed_center;
			signed_df11 <= signed_point11 + signed_center;
			signed_df12 <= signed_point12 + signed_center;
			signed_df13 <= signed_point13 + signed_center;
			signed_df14 <= signed_point14 + signed_center;
			signed_df15 <= signed_point15 + signed_center;
			signed_df16 <= signed_point16 + signed_center;
			end
			else;
		end 
	end
	
	//2.取绝对值
	reg [7:0] abs_df1;
	reg [7:0] abs_df2;
	reg [7:0] abs_df3;
	reg [7:0] abs_df4;
	reg [7:0] abs_df5;
	reg [7:0] abs_df6;
	reg [7:0] abs_df7;
	reg [7:0] abs_df8;
	reg [7:0] abs_df9;
	reg [7:0] abs_df10;
	reg [7:0] abs_df11;
	reg [7:0] abs_df12;
	reg [7:0] abs_df13;
	reg [7:0] abs_df14;
	reg [7:0] abs_df15;
	reg [7:0] abs_df16;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
		begin
			abs_df1 <= 0;
			abs_df2 <= 0;
			abs_df3 <= 0;
			abs_df4 <= 0;
			abs_df5 <= 0;
			abs_df6 <= 0;
			abs_df7 <= 0;
			abs_df8 <= 0;
			abs_df9 <= 0;
			abs_df10 <= 0;
			abs_df11 <= 0;
			abs_df12 <= 0;
			abs_df13 <= 0;
			abs_df14 <= 0;
			abs_df15 <= 0;
			abs_df16 <= 0;
		end
		else
		begin
		    if(TVALID_in)
		    begin
			abs_df1 <= signed_df1[8] == 0 ? signed_df1[7:0] : ~signed_df1[7:0] + 1;
			abs_df2 <= signed_df2[8] == 0 ? signed_df2[7:0] : ~signed_df2[7:0] + 1;
			abs_df3 <= signed_df3[8] == 0 ? signed_df3[7:0] : ~signed_df3[7:0] + 1;
			abs_df4 <= signed_df4[8] == 0 ? signed_df4[7:0] : ~signed_df4[7:0] + 1;
			abs_df5 <= signed_df5[8] == 0 ? signed_df5[7:0] : ~signed_df5[7:0] + 1;
			abs_df6 <= signed_df6[8] == 0 ? signed_df6[7:0] : ~signed_df6[7:0] + 1;
			abs_df7 <= signed_df7[8] == 0 ? signed_df7[7:0] : ~signed_df7[7:0] + 1;
			abs_df8 <= signed_df8[8] == 0 ? signed_df8[7:0] : ~signed_df8[7:0] + 1;
			abs_df9 <= signed_df9[8] == 0 ? signed_df9[7:0] : ~signed_df9[7:0] + 1;
			abs_df10 <= signed_df10[8] == 0 ? signed_df10[7:0] : ~signed_df10[7:0] + 1;
			abs_df11 <= signed_df11[8] == 0 ? signed_df11[7:0] : ~signed_df11[7:0] + 1;
			abs_df12 <= signed_df12[8] == 0 ? signed_df12[7:0] : ~signed_df12[7:0] + 1;
			abs_df13 <= signed_df13[8] == 0 ? signed_df13[7:0] : ~signed_df13[7:0] + 1;
			abs_df14 <= signed_df14[8] == 0 ? signed_df14[7:0] : ~signed_df14[7:0] + 1;
			abs_df15 <= signed_df15[8] == 0 ? signed_df15[7:0] : ~signed_df15[7:0] + 1;
			abs_df16 <= signed_df16[8] == 0 ? signed_df16[7:0] : ~signed_df16[7:0] + 1;
			end
			else;
		end
	end
	//将绝对值缓2个周期
	reg [7:0] abs_df1_r1, abs_df1_r2;
	reg [7:0] abs_df2_r1, abs_df2_r2;
	reg [7:0] abs_df3_r1, abs_df3_r2;
	reg [7:0] abs_df4_r1, abs_df4_r2;
	reg [7:0] abs_df5_r1, abs_df5_r2;
	reg [7:0] abs_df6_r1, abs_df6_r2;
	reg [7:0] abs_df7_r1, abs_df7_r2;
	reg [7:0] abs_df8_r1, abs_df8_r2;
	reg [7:0] abs_df9_r1, abs_df9_r2;
	reg [7:0] abs_df10_r1, abs_df10_r2;
	reg [7:0] abs_df11_r1, abs_df11_r2;
	reg [7:0] abs_df12_r1, abs_df12_r2;
	reg [7:0] abs_df13_r1, abs_df13_r2;
	reg [7:0] abs_df14_r1, abs_df14_r2;
	reg [7:0] abs_df15_r1, abs_df15_r2;
	reg [7:0] abs_df16_r1, abs_df16_r2;
	
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
			
			abs_df1_r2 <= 0;
			abs_df2_r2 <= 0;
			abs_df3_r2 <= 0;
			abs_df4_r2 <= 0;
			abs_df5_r2 <= 0;
			abs_df6_r2 <= 0;
			abs_df7_r2 <= 0;
			abs_df8_r2 <= 0;
			abs_df9_r2 <= 0;
			abs_df10_r2 <= 0;
			abs_df11_r2 <= 0;
			abs_df12_r2 <= 0;
			abs_df13_r2 <= 0;
			abs_df14_r2 <= 0;
			abs_df15_r2 <= 0;
			abs_df16_r2 <= 0;
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
			
			abs_df1_r2 <= abs_df1_r1;
			abs_df2_r2 <= abs_df2_r1;
			abs_df3_r2 <= abs_df3_r1;
			abs_df4_r2 <= abs_df4_r1;
			abs_df5_r2 <= abs_df5_r1;
			abs_df6_r2 <= abs_df6_r1;
			abs_df7_r2 <= abs_df7_r1;
			abs_df8_r2 <= abs_df8_r1;
			abs_df9_r2 <= abs_df9_r1;
			abs_df10_r2 <= abs_df10_r1;
			abs_df11_r2 <= abs_df11_r1;
			abs_df12_r2 <= abs_df12_r1;
			abs_df13_r2 <= abs_df13_r1;
			abs_df14_r2 <= abs_df14_r1;
			abs_df15_r2 <= abs_df15_r1;
			abs_df16_r2 <= abs_df16_r1;
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
			
			abs_df1_r2 <= abs_df1_r2;
			abs_df2_r2 <= abs_df2_r2;
			abs_df3_r2 <= abs_df3_r2;
			abs_df4_r2 <= abs_df4_r2;
			abs_df5_r2 <= abs_df5_r2;
			abs_df6_r2 <= abs_df6_r2;
			abs_df7_r2 <= abs_df7_r2;
			abs_df8_r2 <= abs_df8_r2;
			abs_df9_r2 <= abs_df9_r2;
			abs_df10_r2 <= abs_df10_r2;
			abs_df11_r2 <= abs_df11_r2;
			abs_df12_r2 <= abs_df12_r2;
			abs_df13_r2 <= abs_df13_r2;
			abs_df14_r2 <= abs_df14_r2;
			abs_df15_r2 <= abs_df15_r2;
			abs_df16_r2 <= abs_df16_r2;
			end
		end
	end
	assign o_abs_df1 = abs_df1_r2;
	assign o_abs_df2 = abs_df2_r2;
	assign o_abs_df3 = abs_df3_r2;
	assign o_abs_df4 = abs_df4_r2;
	assign o_abs_df5 = abs_df5_r2;
	assign o_abs_df6 = abs_df6_r2;
	assign o_abs_df7 = abs_df7_r2;
	assign o_abs_df8 = abs_df8_r2;
	assign o_abs_df9 = abs_df9_r2;
	assign o_abs_df10 = abs_df10_r2;
	assign o_abs_df11 = abs_df11_r2;
	assign o_abs_df12 = abs_df12_r2;
	assign o_abs_df13 = abs_df13_r2;
	assign o_abs_df14 = abs_df14_r2;
	assign o_abs_df15 = abs_df15_r2;
	assign o_abs_df16 = abs_df16_r2;
	
	//3.判断每个差是否大于阈值，并存入标志位
	reg [15:0] threshold_flag;//绝对值大于阈值对应位置1，反之置0
//	parameter threshold = 60;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
			threshold_flag <= 0;
		else
		begin
		    if(TVALID_in)
		    begin
			threshold_flag[0] <= abs_df1 >= threshold ? 1 : 0;
			threshold_flag[1] <= abs_df2 >= threshold ? 1 : 0;
			threshold_flag[2] <= abs_df3 >= threshold ? 1 : 0;
			threshold_flag[3] <= abs_df4 >= threshold ? 1 : 0;
			threshold_flag[4] <= abs_df5 >= threshold ? 1 : 0;
			threshold_flag[5] <= abs_df6 >= threshold ? 1 : 0;
			threshold_flag[6] <= abs_df7 >= threshold ? 1 : 0;
			threshold_flag[7] <= abs_df8 >= threshold ? 1 : 0;
			threshold_flag[8] <= abs_df9 >= threshold ? 1 : 0;
			threshold_flag[9] <= abs_df10 >= threshold ? 1 : 0;
			threshold_flag[10] <= abs_df11 >= threshold ? 1 : 0;
			threshold_flag[11] <= abs_df12 >= threshold ? 1 : 0;
			threshold_flag[12] <= abs_df13 >= threshold ? 1 : 0;
			threshold_flag[13] <= abs_df14 >= threshold ? 1 : 0;
			threshold_flag[14] <= abs_df15 >= threshold ? 1 : 0;
			threshold_flag[15] <= abs_df16 >= threshold ? 1 : 0;
			end
			else;
		end
	end
	
	//4.判断特征点
	reg Sf1, Sf2, Sf3, Sf4,
		 Sf5, Sf6, Sf7, Sf8,
		 Sf9, Sf10,Sf11,Sf12,
		 Sf13,Sf14,Sf15,Sf16;
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
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
		begin
			Sf1 <= 0;
			Sf2 <= 0;
			Sf3 <= 0;
			Sf4 <= 0;
			Sf5 <= 0;
			Sf6 <= 0;
			Sf7 <= 0;
			Sf8 <= 0;
			Sf9 <= 0;
			Sf10<= 0;
			Sf11<= 0;
			Sf12<= 0;
			Sf13<= 0;
			Sf14<= 0;
			Sf15<= 0;
			Sf16<= 0;
		end
		else
		begin
		    if(TVALID_in)
		    begin
			Sf1 <=  (threshold_flag & s1) == s1 ? 1:0;
			Sf2 <=  (threshold_flag & s2) == s2 ? 1:0;
			Sf3 <=  (threshold_flag & s3) == s3 ? 1:0;
			Sf4 <=  (threshold_flag & s4) == s4 ? 1:0;
			Sf5 <=  (threshold_flag & s5) == s5 ? 1:0;
			Sf6 <=  (threshold_flag & s6) == s6 ? 1:0;
			Sf7 <=  (threshold_flag & s7) == s7 ? 1:0;
			Sf8 <=  (threshold_flag & s8) == s8 ? 1:0;
			Sf9 <=  (threshold_flag & s9) == s9 ? 1:0;
			Sf10<=  (threshold_flag & s10) == s10 ? 1:0;
			Sf11<=  (threshold_flag & s11) == s11 ? 1:0;
			Sf12<=  (threshold_flag & s12) == s12 ? 1:0;
			Sf13<=  (threshold_flag & s13) == s13 ? 1:0;
			Sf14<=  (threshold_flag & s14) == s14 ? 1:0;
			Sf15<=  (threshold_flag & s15) == s15 ? 1:0;
			Sf16<=  (threshold_flag & s16) == s16 ? 1:0;
			end
			else;
		end
	end
	assign Feature_val = Sf1 | Sf2 | Sf3 | Sf4 |
								Sf5 | Sf6 | Sf7 | Sf8 |
								Sf9 | Sf10| Sf11| Sf12|
								Sf13| Sf14| Sf15| Sf16;

	
	//信号同步
	 parameter delay_time = 4;//输出延迟为4个周期
	
	 reg [delay_time - 1:0] H_SYNC_r;
	 reg [delay_time - 1:0] V_SYNC_r;
	 reg [delay_time - 1:0] data_en_r;
	 assign o_H_SYNC = H_SYNC_r[delay_time - 1];
	 assign o_V_SYNC = V_SYNC_r[delay_time - 1];
	 assign o_data_en = data_en_r[delay_time - 1];
	 assign cnt_data_en = data_en_r[2];
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
			H_SYNC_r <= {H_SYNC_r[delay_time - 2:0],in_H_SYNC};
			V_SYNC_r <= {V_SYNC_r[delay_time - 2:0],in_V_SYNC};
			data_en_r <= {data_en_r[delay_time - 2:0],in_data_en};
			end
		end
	 end
	 
endmodule 