module Bird_Unit(
input 	resetN,
input 	collision_bird,
input 	[11:0] wheel,
input					clk,
input		[31:0]	pxl_x,
input		[31:0]	pxl_y,

output 	[31:0] 	topLeft_x_bird,
output 	[31:0]   topLeft_y_bird,
output	[3:0]		Red_level,
output	[3:0]		Green_level,
output	[3:0]		Blue_level,
output				drawing_bird,
output				game_over);


wire [31:0] topLeft_x_bird_wire;
wire [31:0] topLeft_y_bird_wire;

 

assign topLeft_x_bird=topLeft_x_bird_wire;
assign topLeft_y_bird=topLeft_y_bird_wire;



Bird_Move bird_move (
.collision(collision_bird),
.clk(clk), 
.resetN(resetN), 
.wheel(wheel), 
.topLeft_x_bird(topLeft_x_bird_wire), 
.topLeft_y_bird(topLeft_y_bird_wire),
.game_over(game_over));

Bird_Draw bird_draw(
.clk(clk), 
.resetN(resetN), 
.pxl_x(pxl_x), 
.pxl_y(pxl_y), 
.topLeft_x_bird(topLeft_x_bird_wire), 
.topLeft_y_bird(topLeft_y_bird_wire),

.Red_level(Red_level),
.Green_level(Green_level),
.Blue_level(Blue_level), 
.drawing_bird(drawing_bird));


endmodule