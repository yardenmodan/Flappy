module Lightning_Move #(parameter height_lightning =30, parameter width_lightning= 60, parameter width_bird= 100)(
input restart_light,
input [31:0] topLeft_x_bird,
input [31:0] topLeft_y_bird,
input clk,
input resetN,
input shootN,
input collision_light_1,
input collision_light_2,
input collision_light_3,
output reg [31:0] topLeft_x_light_1,
output reg [31:0] topLeft_y_light_1,
output reg [31:0] topLeft_x_light_2,
output reg [31:0] topLeft_y_light_2,
output reg [31:0] topLeft_x_light_3,
output reg [31:0] topLeft_y_light_3,
output reg [1:0] light_num,
output reg in_air_1,
output reg in_air_2,
output reg in_air_3);



	reg [31:0]	x_temp_light_1;
	reg  [31:0]	y_temp_light_1;
	reg [31:0]	x_temp_light_2;
	reg [31:0]	y_temp_light_2;
	reg [31:0]	x_temp_light_3;
	reg [31:0]	y_temp_light_3;
	reg [31:0] counter_light_1;
	reg [31:0] counter_light_2;
	reg [31:0] counter_light_3;
	wire shootN_norm;


	
	localparam [31:0]	divider = 32'd60_000;// changing speed 
	localparam [1:0] 	light_num_init= 2'd3;
	localparam [31:0] screen_width=640;

	shooter shootN_normal( .resetN(resetN),.shootN(shootN), .clk(clk),.shootN_norm(shootN_norm));

	

	always @(posedge clk or negedge resetN) begin
		

		
		
		if (!resetN ) begin
			light_num<=light_num_init;
			counter_light_1<=0;
			counter_light_2<=0;
			counter_light_3<=0;
			topLeft_x_light_1<=0;
			topLeft_y_light_1<=0;
			topLeft_x_light_2<=0;
			topLeft_y_light_2<=0;
			topLeft_x_light_3<=0;
			topLeft_y_light_3<=0;
			in_air_1<=0;
			in_air_2<=0;
			in_air_3<=0;
			 x_temp_light_1<=topLeft_x_bird+width_bird;
			 y_temp_light_1<= topLeft_y_bird;
			 x_temp_light_2<= topLeft_x_bird+width_bird;
			 y_temp_light_2<=topLeft_y_bird;
			 x_temp_light_3<=topLeft_x_bird+width_bird;
			 y_temp_light_3<=topLeft_y_bird;
		end
		else if (restart_light==1) begin
			light_num<=light_num_init;
			counter_light_1<=0;
			counter_light_2<=0;
			counter_light_3<=0;
			topLeft_x_light_1<=0;
			topLeft_y_light_1<=0;
			topLeft_x_light_2<=0;
			topLeft_y_light_2<=0;
			topLeft_x_light_3<=0;
			topLeft_y_light_3<=0;
			in_air_1<=0;
			in_air_2<=0;
			in_air_3<=0;
			 x_temp_light_1<=topLeft_x_bird+width_bird;
			 y_temp_light_1<= topLeft_y_bird;
			 x_temp_light_2<= topLeft_x_bird+width_bird;
			 y_temp_light_2<=topLeft_y_bird;
			 x_temp_light_3<=topLeft_x_bird+width_bird;
			 y_temp_light_3<=topLeft_y_bird;
		
		
		end

			
		
		else begin//fix this part, not sure it would work
		 x_temp_light_1<=topLeft_x_bird+width_bird;
		 y_temp_light_1<=topLeft_y_bird;
		 x_temp_light_2<=topLeft_x_bird+width_bird;
		 y_temp_light_2<=topLeft_y_bird;
		 x_temp_light_3<=topLeft_x_bird+width_bird;
		 y_temp_light_3<=topLeft_y_bird;
			if (light_num==3 && !shootN_norm) begin //fix shootN to be pulse
				topLeft_x_light_1<=x_temp_light_1;
				topLeft_y_light_1<=y_temp_light_1;
				in_air_1 <= 1;
				light_num<=2;
			
			end
			if(light_num==2 && !shootN_norm) begin //fix shootN
				
				topLeft_x_light_2<=x_temp_light_2;
				topLeft_y_light_2<=y_temp_light_2;
				in_air_2 <= 1;
				light_num<=1;

			end
			if(light_num==1 && !shootN_norm) begin //fix shootN
				
				topLeft_x_light_3<=x_temp_light_3;
				topLeft_y_light_3<=y_temp_light_3;
				in_air_3 <= 1'b1;
				light_num<=0;

			end
			if (in_air_1) begin
				
				counter_light_1<=counter_light_1+1;
				if (!collision_light_1) begin
					if (counter_light_1>=divider) begin
						counter_light_1<=0;
						if (topLeft_x_light_1<screen_width) begin
							topLeft_x_light_1<=topLeft_x_light_1+1;
						end
						else begin
							
							in_air_1<=0;
						end
					end
				end
				else begin
					in_air_1<=0;
				end
			end
			if (in_air_2) begin
				
				counter_light_2<=counter_light_2+1;
				if (!collision_light_2) begin
					if (counter_light_2>=divider) begin
						counter_light_2<=0;
						if (topLeft_x_light_2<screen_width) begin
							topLeft_x_light_2<=topLeft_x_light_2+1;
						end
						else begin
							in_air_2<=0;
						end
					end
				end
				else begin
					in_air_2<=0;
				end
			end
			if (in_air_3) begin
				
				counter_light_3<=counter_light_3+1;
				if (!collision_light_3) begin
					if (counter_light_3>=divider) begin
						counter_light_3<=0;
						if (topLeft_x_light_3<screen_width) begin
							topLeft_x_light_3<=topLeft_x_light_3+1;
						end
						else begin
							in_air_3<=0;
						end
					end
				end
				else begin
					in_air_3<=0;
				end
			end
		end 
	end
	
	
endmodule 
