module Bird_Move /*#(parameter height_bird_in  =56 ,parameter fails_param_in =4)*/(
input collision,
input clk,
input resetN,
input [11:0] wheel,
output  reg [31:0] topLeft_x_bird,
output  reg [31:0] topLeft_y_bird,
output reg game_over);

localparam [31:0]	x_init = 32'd10;

reg [2:0] fails;
//localparam height_bird [31:0]= height_bird_in;
//localparam fails_param [2:0]= fails_param_in;



always @(posedge clk or negedge resetN) begin
	
	if (!resetN) begin 
		game_over<=0;
		fails<=3'd4;
		topLeft_x_bird<= x_init;
		if ({20'd0, wheel}/6 < (32'd480-32'd56/*height_bird*/)) begin
			topLeft_y_bird<={20'd0,wheel}/6;
		end
		else begin
			topLeft_y_bird<=(32'd480-32'd56/*height_bird*/);
		end
	end
	else begin
		topLeft_x_bird<= x_init;

		if ({20'd0, wheel}/6 < (32'd480-32'd56/*height_bird*/)) begin
			topLeft_y_bird<={20'd0,wheel}/6;
		end
		else begin
			topLeft_y_bird<=(32'd480-32'd56/*height_bird*/);
		end
		if (collision) begin
			fails<=fails-2'd1;
		end
		if (fails<=0) begin
			game_over<=1;
		end
	end
end	
		
endmodule
	
		
