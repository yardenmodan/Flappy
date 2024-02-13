module h2d (input clk, input resetN, input [31:0] counter_out, 
output reg [3:0] digit_10000,
output reg [3:0] digit_1000,
output reg [3:0] digit_100,
output reg [3:0] digit_10,
output reg [3:0] digit_1
);

	always @(posedge clk or negedge resetN) begin
	if (!resetN) begin
		digit_10000<=0;
		digit_1000<=0;
		digit_100<=0;
		digit_10<=0;
		digit_1<=0;
	
	end 
	else begin
		digit_10000 = counter_out/10000;
		digit_1000= (counter_out-digit_10000*10000)/1000;
		digit_100= (counter_out-digit_10000*10000-digit_1000*1000)/100;
		digit_10= (counter_out-digit_10000*10000-digit_1000*1000-digit_100*100)/10;
		digit_1= (counter_out-digit_10000*10000-digit_1000*1000-digit_100*100-digit_10*10)/1;
	end
	end
	
endmodule
