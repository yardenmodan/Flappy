module led_control(input clk,
input resetN,
input [31:0] stage,
output reg [9:0] led_control);
always @(posedge clk or negedge resetN) begin
	
	if (!resetN) begin
		led_control<=10'b1111111111;
	end
	else begin
	
		case (stage) 
			0: led_control<=10'b0000000001;
			1: led_control<=10'b0000000011;
			2:	led_control<=10'b0000000111;
			3:	led_control<=10'b0000001111;
			4:	led_control<=10'b0000011111;
			5:	led_control<=10'b0000111111;
			6:	led_control<=10'b0001111111;
			7:	led_control<=10'b0011111111;
			8:	led_control<=10'b0111111111;
			9:	led_control<=10'b1111111111;
			default:	led_control<=10'b1111111111;
		
		endcase
	end
end
endmodule