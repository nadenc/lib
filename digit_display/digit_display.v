`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// digit_display
//////////////////////////////////////////////////////////////////////////////////

// Seven Segment Bit Mapping
//		//////0//////
//		//			  //
//		5			  1
//		//			  //
//		//			  //
//		//////6//////
//		//			  //
//		4			  2
//		//			  //	///
//		//			  // //7//
//		//////3////// 	///

module digit_display(
	input [3:0] val1								,	// 0-9 digit value
	input [3:0] val2								,	// 0-9 digit value
	input [3:0] val3								,	// 0-9 digit value
	input clk_disp									,	// clock to rotate through digits
	output reg [2:0] disp_en					,	// display enable
	output reg [7:0] disp_out						// output to seven seg display
);

	initial disp_en <= 0;
	initial disp_out <= 0;
	
	reg [1:0] dig_sel;
	reg [3:0] disp_val;

always @ (posedge clk_disp) begin // rotate through displays
	dig_sel <= dig_sel + 2'b1;
	
	if (dig_sel == 2'b11) begin
		dig_sel <= 2'b01;
	end
end

always begin
	case (dig_sel) // decode display selection
		2'b01: begin
			disp_en[0] <= 0;
			disp_en[1] <= 1;
			disp_en[2] <= 1;
			disp_val <= val1;
		end
		2'b10: begin
			disp_en[0] <= 1;
			disp_en[1] <= 0;
			disp_en[2] <= 1;
			disp_val <= val2;
		end
		2'b11: begin
			disp_en[0] <= 1;
			disp_en[1] <= 1;
			disp_en[2] <= 0;
			disp_val <= val3;
		end
		default: begin
			disp_en[0] <= 1;
			disp_en[1] <= 1;
			disp_en[2] <= 1;
		end
	endcase

	case (disp_val) // decode digit to seven segment display
		4'b0000: disp_out <= 8'b00000011; //0
		4'b0001:	disp_out <= 8'b10011111; //1
		4'b0010:	disp_out <= 8'b00100101; //2
		4'b0011: disp_out <= 8'b00001101; //3
		4'b0100: disp_out <= 8'b10011001; //4
		4'b0101: disp_out <= 8'b01001001; //5
		4'b0110:	disp_out <= 8'b01000001; //6
		4'b0111:	disp_out <= 8'b00011111; //7
		4'b1000:	disp_out <= 8'b00000001; //8
		4'b1001:	disp_out <= 8'b00011001; //9
		default: disp_out <= 8'b11111111; //null
	endcase
end
	
endmodule
