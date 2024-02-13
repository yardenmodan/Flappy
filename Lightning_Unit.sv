module Lightning_Unit(
	input restart_light,
	input [31:0] topLeft_x_bird,
	input [31:0] topLeft_y_bird,
	input clk,
	input resetN,
	input shootN,
	input collision_light_1,
	input collision_light_2,
	input collision_light_3,
	input		[31:0]	pxl_x,
	input		[31:0]	pxl_y,
	output 	[1:0] 	light_num,
	output	[3:0]		Red_level,
	output	[3:0]		Green_level,
	output	[3:0]		Blue_level,
	output				drawing_lightning_1,
	output				drawing_lightning_2,
	output				drawing_lightning_3	
	);
	
	wire [31:0] topLeft_x_light_1;
	wire [31:0] topLeft_y_light_1;
	wire [31:0] topLeft_x_light_2;
	wire [31:0] topLeft_y_light_2;
	wire [31:0] topLeft_x_light_3;
	wire [31:0] topLeft_y_light_3;
	wire in_air_1;
	wire in_air_2;
	wire in_air_3;

	Lightning_Move lightning_move(
	.restart_light(restart_light),
	.topLeft_x_bird(topLeft_x_bird),
	.topLeft_y_bird(topLeft_y_bird),
	
	.clk(clk),
	.resetN(resetN),
	.shootN(shootN),
	.collision_light_1(collision_light_1),
	.collision_light_2(collision_light_2),
	.collision_light_3(collision_light_3),
	.topLeft_x_light_1(topLeft_x_light_1),
	.topLeft_y_light_1(topLeft_y_light_1),
	.topLeft_x_light_2(topLeft_x_light_2),
	.topLeft_y_light_2(topLeft_y_light_2),
	.topLeft_x_light_3(topLeft_x_light_3),
	.topLeft_y_light_3(topLeft_y_light_3),
	.light_num(light_num),
	.in_air_1(in_air_1),
	.in_air_2(in_air_2),
	.in_air_3(in_air_3));
	
	Lightning_Draw lightning_draw(
	.clk(clk),
	.resetN(resetN),
	.pxl_x(pxl_x),
	.pxl_y(pxl_y),
	.topLeft_x_light_1(topLeft_x_light_1),
	.topLeft_y_light_1(topLeft_y_light_1),
	.topLeft_x_light_2(topLeft_x_light_2),
	.topLeft_y_light_2(topLeft_y_light_2),
	.topLeft_x_light_3(topLeft_x_light_3),
	.topLeft_y_light_3(topLeft_y_light_3),
	.in_air_1(in_air_1),
	.in_air_2(in_air_2),
	.in_air_3(in_air_3),
	.Red_level(Red_level),
	.Green_level(Green_level),
	.Blue_level(Blue_level),
	.drawing_lightning_1(drawing_lightning_1),
	.drawing_lightning_2(drawing_lightning_2),
	.drawing_lightning_3(drawing_lightning_3));
	




endmodule