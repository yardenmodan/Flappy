module counter_sec(
input clk,
input resetN,
input game_over,
output reg [31:0] counter_out);
reg [31:0] counter_sec;
reg [31:0] counter_temp;
localparam sec=32'd25_000_000;
always @(posedge clk or negedge resetN) begin
	if (!resetN) begin
		counter_out<=0;
		counter_sec<=0;
		counter_temp<=0;
	
	end
	else begin
		
		if (!game_over) begin
			if (counter_sec>sec) begin
				counter_sec<=0;
				counter_temp<=counter_temp+1;
				counter_out<=counter_out+1;
				
			end
			else begin
				counter_sec<=counter_sec+1;
			end
			
		end
		else begin
			counter_out<=counter_temp;
		end
	end
end
endmodule

