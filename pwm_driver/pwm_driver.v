`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// pwm_driver
//////////////////////////////////////////////////////////////////////////////////

module pwm_driver(
	input clk_in,
	input [7:0] duty_cycle, //0-255
	output reg pwm_out
   );
	
	initial duty_cnt <= 0;
	reg [7:0] duty_cnt; // duty cycle counter

always @ (posedge clk_in) begin
	duty_cnt <= duty_cnt + 8'b1;
	if (duty_cycle > duty_cnt) begin
		pwm_out <= 1;
	end if (duty_cycle <= duty_cnt) begin
		pwm_out <= 0;
	end
	
end

endmodule
