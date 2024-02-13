// Designer: Mor (Mordechai) Dahan, Avi Salmon,
// Sep. 2022
// ***********************************************

`define ENABLE_ADC_CLOCK
`define ENABLE_CLOCK1
`define ENABLE_CLOCK2
`define ENABLE_SDRAM
`define ENABLE_HEX0
`define ENABLE_HEX1
`define ENABLE_HEX2
`define ENABLE_HEX3
`define ENABLE_HEX4
`define ENABLE_HEX5
`define ENABLE_KEY
`define ENABLE_LED
`define ENABLE_SW
`define ENABLE_VGA
`define ENABLE_ACCELEROMETER
`define ENABLE_ARDUINO
`define ENABLE_GPIO

module Flappy_Bird(

	//////////// ADC CLOCK: 3.3-V LVTTL //////////
`ifdef ENABLE_ADC_CLOCK
	input 		          		ADC_CLK_10,
`endif
	//////////// CLOCK 1: 3.3-V LVTTL //////////
`ifdef ENABLE_CLOCK1
	input 		          		MAX10_CLK1_50,
`endif
	//////////// CLOCK 2: 3.3-V LVTTL //////////
`ifdef ENABLE_CLOCK2
	input 		          		MAX10_CLK2_50,
`endif

	//////////// SDRAM: 3.3-V LVTTL //////////
`ifdef ENABLE_SDRAM
	output		    [12:0]		DRAM_ADDR,
	output		     [1:0]		DRAM_BA,
	output		          		DRAM_CAS_N,
	output		          		DRAM_CKE,
	output		          		DRAM_CLK,
	output		          		DRAM_CS_N,
	inout 		    [15:0]		DRAM_DQ,
	output		          		DRAM_LDQM,
	output		          		DRAM_RAS_N,
	output		          		DRAM_UDQM,
	output		          		DRAM_WE_N,
`endif

	//////////// SEG7: 3.3-V LVTTL //////////
`ifdef ENABLE_HEX0
	output		     [7:0]		HEX0,
`endif
`ifdef ENABLE_HEX1
	output		     [7:0]		HEX1,
`endif
`ifdef ENABLE_HEX2
	output		     [7:0]		HEX2,
`endif
`ifdef ENABLE_HEX3
	output		     [7:0]		HEX3,
`endif
`ifdef ENABLE_HEX4
	output		     [7:0]		HEX4,
`endif
`ifdef ENABLE_HEX5
	output		     [7:0]		HEX5,
`endif

	//////////// KEY: 3.3 V SCHMITT TRIGGER //////////
`ifdef ENABLE_KEY
	input 		     [1:0]		KEY,
`endif

	//////////// LED: 3.3-V LVTTL //////////
`ifdef ENABLE_LED
	output		     [9:0]		LEDR,
`endif

	//////////// SW: 3.3-V LVTTL //////////
`ifdef ENABLE_SW
	input 		     [9:0]		SW,
`endif

	//////////// VGA: 3.3-V LVTTL //////////
`ifdef ENABLE_VGA
	output		     [3:0]		VGA_B,
	output		     [3:0]		VGA_G,
	output		          		VGA_HS,
	output		     [3:0]		VGA_R,
	output		          		VGA_VS,
`endif

	//////////// Accelerometer: 3.3-V LVTTL //////////
`ifdef ENABLE_ACCELEROMETER
	output		          		GSENSOR_CS_N,
	input 		     [2:1]		GSENSOR_INT,
	output		          		GSENSOR_SCLK,
	inout 		          		GSENSOR_SDI,
	inout 		          		GSENSOR_SDO,
`endif

	//////////// Arduino: 3.3-V LVTTL //////////
`ifdef ENABLE_ARDUINO
	output 		    [15:0]		ARDUINO_IO,
	inout 		          		ARDUINO_RESET_N,
`endif

	//////////// GPIO, GPIO connect to GPIO Default: 3.3-V LVTTL //////////
`ifdef ENABLE_GPIO
	inout 		    [35:0]		GPIO
`endif
);


//=======================================================
//  REG/WIRE declarations
//=======================================================

localparam sec=50_000_000;
// clock signals
wire				clk_25;
wire				clk_50;
wire				clk_100;

// Screens signals
wire	[31:0]	pxl_x;
wire	[31:0]	pxl_y;
wire				h_sync_wire;
wire				v_sync_wire;
wire	[3:0]		vga_r_wire;
wire	[3:0]		vga_g_wire;
wire	[3:0]		vga_b_wire;
wire	[7:0]		lcd_db;
wire				lcd_reset;
wire				lcd_wr;
wire				lcd_d_c;
wire				lcd_rd;
wire				lcd_buzzer;
wire				lcd_status_led;
wire	[3:0]		Red_level;
wire	[3:0]		Green_level;
wire	[3:0]		Blue_level;

//  modules move and draw signals
wire	[3:0]		r_bird;
wire	[3:0]		g_bird;
wire	[3:0]		b_bird;
wire				draw_bird;
wire	[3:0]		r_light;
wire	[3:0]		g_light;
wire	[3:0]		b_light;
wire				draw_light_1;
wire 				draw_light_2;
wire 				draw_light_3;
wire	[3:0]		r_building;
wire	[3:0]		g_building;
wire	[3:0]		b_building;
			
wire				draw_building_1;
wire				draw_building_2;
wire 		[31:0] topLeft_x_bird_wire;
wire 		[31:0] topLeft_y_bird_wire;
wire 		[31:0] width_bird_wire;
wire 		[31:0] height_bird_wire;
wire [1:0] light_num;
wire [31:0] stage_wire;
//wire	[31:0]	topLeft_x_intel;
//wire	[31:0]	topLeft_y_intel;
//collisions

wire collision_building_1;
wire collision_building_2;
wire collision_lightning_1;
wire collision_lightning_2;
wire collision_lightning_3;
wire draw_state_light;
wire collision_bird;
wire game_over;
wire background_drawing;
wire [3:0] Blue_background;
wire [3:0] Green_background;
wire [3:0] Red_background;
wire destructed_building_1;
wire destructed_building_2;
wire [31:0] green_state_light;
wire [31:0] blue_state_light;
wire [31:0] red_state_light;
wire restart_light;
wire slow_draw;
wire [31:0] r_slow;
wire [31:0] g_slow;
wire [31:0] b_slow;
wire [31:0] Red_level_gameover;
wire [31:0] Green_level_gameover;
wire [31:0] Blue_level_gameover;
wire [31:0] stage_wire_fixed;
reg [31:0] counter_sec;
wire [31:0] counter_sec_fixed;
reg [31:0] counter_divider;
//wire charging_right;
//wire counter;
wire [31:0] charging_right;
wire [31:0] counter;
wire [31:0] counter_out;
wire [3:0] digit_10000;
wire [3:0] digit_1000;
wire [3:0] digit_100;
wire [3:0] digit_10;
wire [3:0] digit_1;
wire [9:0] led_wire;

led_control led_control (
.clk(clk_25),
.resetN(~Start),
.stage(stage_wire),
.led_control(led_wire));



// Periphery signals
wire	A;
wire	B;
wire	Select;
wire	Start;
wire	Right;
wire	Left;
wire	Up;
wire	Down;
wire [11:0]	Wheel;


// Screens Assigns
assign ARDUINO_IO[7:0]	= lcd_db;
assign ARDUINO_IO[8] 	= lcd_reset;
assign ARDUINO_IO[9]		= lcd_wr;
assign ARDUINO_IO[10]	= lcd_d_c;
assign ARDUINO_IO[11]	= lcd_rd;
assign ARDUINO_IO[12]	= lcd_buzzer;
assign ARDUINO_IO[13]	= lcd_status_led;
assign VGA_HS = h_sync_wire;
assign VGA_VS = v_sync_wire;
assign VGA_R = vga_r_wire;
assign VGA_G = vga_g_wire;
assign VGA_B = vga_b_wire;


// Screens control (LCD and VGA)
Screens_dispaly Screen_control(
	.clk_25(clk_25),
	.clk_100(clk_100),
	.Red_level(Red_level),
	.Green_level(Green_level),
	.Blue_level(Blue_level),
	.pxl_x(pxl_x),
	.pxl_y(pxl_y),
	.Red(vga_r_wire),
	.Green(vga_g_wire),
	.Blue(vga_b_wire),
	.h_sync(h_sync_wire),
	.v_sync(v_sync_wire),
	.lcd_db(lcd_db),
	.lcd_reset(lcd_reset),
	.lcd_wr(lcd_wr),
	.lcd_d_c(lcd_d_c),
	.lcd_rd(lcd_rd)
);


// Utilities

// 25M clk generation
pll25	pll25_inst (
	.areset ( 1'b0 ),
	.inclk0 ( MAX10_CLK1_50 ),
	.c0 ( clk_25 ),
	.c1 ( clk_50 ),
	.c2 ( clk_100 ),
	.locked ( )
	);


//7-Seg default assign (all leds are off)

assign HEX6 = 8'b11111110;


// periphery_control module for external units: joystick, wheel and buttons (A,B, Select and Start) 
periphery_control periphery_control_inst(
	.clk(clk_25),
	.A(A),
	.B(B),
	.Select(Select),
	.Start(Start),
	.Right(Right),
	.Left(Left),
	.Up(Up),
	.Down(Down),
	.Wheel(Wheel)
	);
	
	// Leds and 7-Seg show periphery_control outputs
	assign LEDR[9:0]=led_wire[9:0] ;
	/*assign LEDR[0] = A; 			// A
	assign LEDR[1] = B; 			// B
	assign LEDR[2] = Select;	// Select
	assign LEDR[3] = Start; 	// Start
	assign LEDR[9] = Left; 		// Left
	assign LEDR[8] = Right; 	// Right
	assign LEDR[7] = Up; 		// UP
	assign LEDR[6] = Down; 		// DOWN/**/

		seven_segment ss4(
	.in_hex(digit_10000),
	.out_to_ss(HEX4)
);
	
	seven_segment ss3(
	.in_hex(digit_1000),
	.out_to_ss(HEX3)
);

	seven_segment ss2(
	.in_hex(digit_100),
	.out_to_ss(HEX2)
);
	seven_segment ss1(
	.in_hex(digit_10),
	.out_to_ss(HEX1)
);
	seven_segment ss0(
	.in_hex(digit_1),
	.out_to_ss(HEX0)
);

// Priority mux for the RGB
Priority_Drawing priority_drawing(
	.pxl_x(pxl_x),
	.pxl_y(pxl_y),
	.slow_draw(slow_draw),
	.r_slow(r_slow),
	.g_slow(g_slow),
	.b_slow(b_slow),
	.draw_state_light(draw_state_light),
	.red_state_light(red_state_light),
	.green_state_light(green_state_light),
	.blue_state_light(blue_state_light),
	
	.destructed_building_1(destructed_building_1),
	.destructed_building_2(destructed_building_2),
	.clk(clk_25),
	.resetN(~Start),
	.game_over(game_over),
	.Red_level_gameover(Red_level_gameover),
	.Green_level_gameover(Green_level_gameover),
	.Blue_level_gameover(Blue_level_gameover),
	.Red_level_background(Red_background),//fix
	.Green_level_background(Green_background),//fix
	.Blue_level_background(Blue_background),//fix
	.drawing_background(background_drawing),//no need in that
	.Red_level_lightning(r_light),
	.Green_level_lightning(g_light),
	.Blue_level_lightning(b_light),
	.drawing_lightning_1(draw_light_1),
	.drawing_lightning_2(draw_light_2),
	.drawing_lightning_3(draw_light_3),
	.Red_level_building(r_building),
	.Green_level_building(g_building),
	.Blue_level_building(b_building),
	.drawing_building_1(draw_building_1),
	.drawing_building_2(draw_building_2),
	.Red_level_bird(r_bird),
	.Green_level_bird(g_bird),
	.Blue_level_bird(b_bird),
	.drawing_bird(draw_bird),
	.collision_building_1(collision_building_1),
	.collision_building_2(collision_building_2),
	.collision_lightning_1(collision_lightning_1),
	.collision_lightning_2(collision_lightning_2),
	.collision_lightning_3(collision_lightning_3),
	.collision_bird(collision_bird),
	.Red_level(Red_level),
	.Green_level(Green_level),
	.Blue_level(Blue_level)
	);
	
	
	
	
// Intel object
Bird_Unit bird_unit(
	.resetN(~Start),
	.collision_bird(collision_bird),
	.wheel(Wheel),
	.clk(clk_25),
	.pxl_x(pxl_x),
	.pxl_y(pxl_y),
	.topLeft_x_bird(topLeft_x_bird_wire),
	.topLeft_y_bird(topLeft_y_bird_wire),
	.Red_level(r_bird),
	.Green_level(g_bird),
	.Blue_level(b_bird),
	.drawing_bird(draw_bird),
	.game_over(game_over)
	);
	
	

//	input collision_light_1,
//	input collision_light_2,
//	input collision_light_3,
Lightning_Unit lightning_unit(
.restart_light(restart_light),
.topLeft_x_bird(topLeft_x_bird_wire),
.topLeft_y_bird(topLeft_y_bird_wire),
.clk(clk_25),
.resetN(~Start),
.shootN(Select || (~A)),
.collision_light_1(collision_lightning_1),
.collision_light_2(collision_lightning_2),
.collision_light_3(collision_lightning_3),
.pxl_x(pxl_x),
.pxl_y(pxl_y),
.light_num(light_num),
.Red_level(r_light),
.Green_level(g_light),
.Blue_level(b_light),
.drawing_lightning_1(draw_light_1),
.drawing_lightning_2(draw_light_2),
.drawing_lightning_3(draw_light_3));




slowing_down Slowing_down(
.clk(clk_25),
.resetN(~Start),
.pxl_x(pxl_x),
.pxl_y(pxl_y),
.r_slow(r_slow),
.g_slow(g_slow),
.b_slow(b_slow));





Background_Draw background_draw (
.pxl_x(pxl_x),
.pxl_y(pxl_y),
.clk(clk_25),
.background_drawing(background_drawing),
.Blue_background(Blue_background),
.Green_background(Green_background),
.Red_background(Red_background));


Buildings_Unit buildings_unit (
.slow_down(~B),	
.clk(clk_25),
.resetN(~Start),
.pxl_x(pxl_x),
.pxl_y(pxl_y),
.collision_building_1(collision_building_1),
.collision_building_2(collision_building_2),
.stage(stage_wire),
.Red_level(r_building),
.Green_level(g_building),
.Blue_level(b_building),
.drawing_building_1(draw_building_1),
.drawing_building_2(draw_building_2),
.destructed_building_1(destructed_building_1),
.destructed_building_2(destructed_building_2),
.slow_draw(slow_draw));

gameover Gameover(
.clk(clk_25),
.resetN(~Start),
.pxl_x(pxl_x),
.pxl_y(pxl_y),
.red_gameover(Red_level_gameover),
.green_gameover(Green_level_gameover),
.blue_gameover(Blue_level_gameover));



light_state light_state(
.clk(clk_25),
.resetN(~Start),
.light_num(light_num),
.pxl_x(pxl_x),
.pxl_y(pxl_y),
.draw_state_light(draw_state_light),
.red_state_light(red_state_light),
.green_state_light(green_state_light),
.blue_state_light(blue_state_light),
.restart_light(restart_light),
.charging_right(charging_right),
.counter(counter));

counter_sec Counter_sec(
.clk(clk_25),
.resetN(~Start),
.game_over(game_over),
.counter_out(counter_out));

h2d H2D( 
.clk(clk_25),
.resetN(~Start),
.counter_out(counter_out),
.digit_10000(digit_10000),
.digit_1000(digit_1000),
.digit_100(digit_100),
.digit_10(digit_10),
.digit_1(digit_1));



endmodule



