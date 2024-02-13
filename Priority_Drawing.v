module Priority_Drawing(
input [31:0] pxl_x,
input [31:0] pxl_y,
input slow_draw,
input [31:0] r_slow,
input [31:0] g_slow,
input [31:0] b_slow,
input draw_state_light,
input [31:0] red_state_light,
input [31:0] green_state_light,
input [31:0] blue_state_light,
input destructed_building_1,
input destructed_building_2,
input clk,
input resetN,
input game_over,

input [3:0] Red_level_gameover,
input [3:0] Green_level_gameover,
input [3:0] Blue_level_gameover,
input [3:0] Red_level_background,
input [3:0] Green_level_background,
input [3:0] Blue_level_background,
input drawing_background,
input [3:0] Red_level_lightning,
input [3:0] Green_level_lightning,
input [3:0] Blue_level_lightning,
input drawing_lightning_1,
input drawing_lightning_2,
input drawing_lightning_3,

input [3:0] Red_level_building,
input [3:0] Green_level_building,
input [3:0] Blue_level_building,
input drawing_building_1,
input drawing_building_2,

input [3:0] Red_level_bird,
input [3:0] Green_level_bird,
input [3:0] Blue_level_bird,
input drawing_bird,
output reg collision_building_1,
output reg collision_building_2,
output reg collision_lightning_1,
output reg collision_lightning_2,
output reg collision_lightning_3,
output reg collision_bird,
output reg [3:0] Red_level,
output reg [3:0] Green_level,
output reg [3:0] Blue_level);



	
	
	


always @(posedge clk or negedge resetN) begin
	//collision_bird<=0; to fix?
	if (!resetN) begin
		Red_level <= 4'hF;
		Green_level <= 4'hF;
		Blue_level <= 4'hF;
		collision_building_1<=0;// to fix? what's the value when not in reset?
		collision_building_2<=0;
		collision_lightning_1<=0;
		collision_lightning_2<=0;
		collision_lightning_3<=0;
		collision_bird<=0;
		

	end
	else begin
	
		if (game_over) begin
		Red_level<=Red_level_gameover;
		Green_level<=Green_level_gameover;
		Blue_level<=Blue_level_gameover;
		
		end
		else begin
			if (destructed_building_1==0 && collision_building_1) begin
				collision_building_1<=0;
				
				
			end
			if (destructed_building_2==0 && collision_building_2) begin
				collision_building_2<=0;
			end
			if (drawing_building_1 && (drawing_lightning_1)) begin
				collision_building_1<=1;
				collision_lightning_1<=1;
			
			end
			
			if (drawing_building_1 && (drawing_lightning_2)) begin
				collision_building_1<=1;
				collision_lightning_2<=1;
			
			end
			
			if (drawing_building_1 && (drawing_lightning_3)) begin
				collision_building_1<=1;
				collision_lightning_3<=1;
			
			end
			
			if (drawing_building_2 && (drawing_lightning_1)) begin
				collision_building_2<=1;
				collision_lightning_1<=1;
			
			end
			
			if (drawing_building_2 && (drawing_lightning_2)) begin
				collision_building_2<=1;
				collision_lightning_2<=1;
			
			end
			
			if (drawing_building_2 && (drawing_lightning_3)) begin
				collision_building_2<=1;
				collision_lightning_3<=1;
			
			end
			
			if (drawing_bird && drawing_building_1) begin
				collision_building_1<=1;
				collision_bird<=1;
			end	
			if (drawing_bird && drawing_building_2) begin
				collision_building_2<=1;
				collision_bird<=1;
			end
			begin
			
				if ((slow_draw )&& (r_slow!=4'hF) && (g_slow!=4'hF)&&(b_slow!=4'hF)&& ((pxl_x>=460) && (pxl_x<500) && (pxl_y>=20) && (pxl_y<60))) begin
					Red_level <= r_slow;
					Green_level <= g_slow;
					Blue_level <= b_slow;
				end
				
				else if (draw_state_light) begin
					Red_level <= red_state_light;
					Green_level <= green_state_light;
					Blue_level <= blue_state_light;
				end
				
				
				else if (drawing_bird) begin
					
					Red_level <= Red_level_bird;
					Green_level <= Green_level_bird;
					Blue_level <= Blue_level_bird;
				end
				else if (drawing_building_1 || drawing_building_2) begin
					Red_level <= Red_level_building;
					Green_level <= Green_level_building;
					Blue_level <= Blue_level_building;
				end
				else if (drawing_lightning_1 || drawing_lightning_2 || drawing_lightning_3) begin
					Red_level <= Red_level_lightning;
					Green_level <= Green_level_lightning;
					Blue_level <= Blue_level_lightning;
				end
			
			
				else begin
					Red_level <= Red_level_background;
					Green_level <= Green_level_background;
					Blue_level <= Blue_level_background;
			
				end
			end
		end
	end
end
endmodule
	
