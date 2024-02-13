module Buildings_Unit(
input slow_down,
input clk,
input resetN,

input [31:0] pxl_x,
input [31:0] pxl_y,
input collision_building_1,
input collision_building_2,
output [31:0] stage,
output [3:0] Red_level,
output [3:0] Green_level,
output [3:0] Blue_level,
output drawing_building_1,
output drawing_building_2,
output destructed_building_1,
output destructed_building_2,
output slow_draw

);



wire signed [31:0] topLeft_x_1_1;
wire signed [31:0] topLeft_y_1_1;
wire signed [31:0] topLeft_x_2_1;
wire signed [31:0] topLeft_y_2_1;

wire [31:0] height_window;

Buildings_Move buildings_move( 
.slow_down(slow_down),
.clk(clk),
.resetN(resetN),

.topLeft_x_1(topLeft_x_1_1),
.topLeft_y_1(topLeft_y_1_1),
.topLeft_x_2(topLeft_x_2_1),
.topLeft_y_2(topLeft_y_2_1),

.height_window(height_window),
.stage(stage),
.slow_draw(slow_draw));



Buildings_Draw buildings_draw(.clk(clk),
.resetN(resetN),
.pxl_x(pxl_x),
.pxl_y(pxl_y),
.topLeft_x_1(topLeft_x_1_1),
.topLeft_y_1(topLeft_y_1_1),
.topLeft_x_2(topLeft_x_2_1),
.topLeft_y_2(topLeft_y_2_1),

.height_window(height_window),
.collision_building_1(collision_building_1),
.collision_building_2(collision_building_2),
.Red_level(Red_level),
.Green_level(Green_level),
.Blue_level(Blue_level),
.drawing_building_1(drawing_building_1),
.drawing_building_2(drawing_building_2),
.destructed_building_1(destructed_building_1),
.destructed_building_2(destructed_building_2)
);

endmodule

