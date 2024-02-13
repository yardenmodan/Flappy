module Lightning_Draw #(parameter width_lightning= 60,parameter height_lightning=30)(
input					clk,
input					resetN,
input		[31:0]	pxl_x,
input		[31:0]	pxl_y,
input 	integer 	topLeft_x_light_1,
input 	integer 	topLeft_y_light_1,
input 	integer 	topLeft_x_light_2,
input	 	integer 	topLeft_y_light_2,
input 	integer 	topLeft_x_light_3,
input 	integer 	topLeft_y_light_3,




input					in_air_1, // in air 1 drawing
input					in_air_2, // in air 2 drawing
input					in_air_3, // in air 3 drawing

output	[3:0]		Red_level,
output	[3:0]		Green_level,
output	[3:0]		Blue_level,

output				drawing_lightning_1,
output				drawing_lightning_2,
output				drawing_lightning_3


);

wire		in_rectangle_lightning_1;
wire		in_rectangle_lightning_2; 
wire		in_rectangle_lightning_3;

wire	[31:0]	offset_x_lightning_1;
wire	[31:0]	offset_y_lightning_1;
wire	[31:0]	offset_x_lightning_2;
wire	[31:0]	offset_y_lightning_2;
wire	[31:0]	offset_x_lightning_3;
wire	[31:0]	offset_y_lightning_3;

logic[0:height_lightning-1][0:width_lightning-1][11:0] Bitmap = {
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFEC,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hF90,12'hFEB,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFEA,12'hFFE,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFA0,12'hFA0,12'hFD9,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFA0,12'hFA0,12'hFC6,12'hFEC,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFA0,12'hFA1,12'hFA0,12'hFC6,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFB4,12'hFA0,12'hFB0,12'hFA0,12'hFB3,12'hFD9,12'hFFE,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFA0,12'hFD1,12'hFA1,12'hFA0,12'hFB4,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFC6,12'hFA0,12'hFD1,12'hFC0,12'hFB0,12'hFA0,12'hFA1,12'hFC6,12'hFEB,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFA0,12'hFD1,12'hFD1,12'hFA1,12'hFA0,12'hFB3,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFD9,12'hFA0,12'hFD1,12'hFE2,12'hFD1,12'hFC0,12'hFB0,12'hFA0,12'hF90,12'hFB3,12'hFD8,12'hFFD,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFA0,12'hFD1,12'hFD1,12'hFD1,12'hFB1,12'hFA0,12'hFA1,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFEA,12'hFA0,12'hFD1,12'hFF3,12'hFE2,12'hFD1,12'hFD1,12'hFC1,12'hFB0,12'hFA0,12'hF90,12'hFA0,12'hFC5,12'hFDA,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFA0,12'hFD1,12'hFD1,12'hFD1,12'hFD1,12'hFB1,12'hFA0,12'hFA0,12'hFFE,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFED,12'hFA0,12'hFC0,12'hFF3,12'hFF3,12'hFF3,12'hFE2,12'hFD1,12'hFD1,12'hFC1,12'hFB1,12'hFA0,12'hFA0,12'hFA0,12'hFB2,12'hFC7,12'hFEC,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFA0,12'hFD1,12'hFE3,12'hFD1,12'hFD1,12'hFD1,12'hFC1,12'hFA0,12'hFA0,12'hFEC,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFE,12'hFA0,12'hFC0,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFE2,12'hFD1,12'hFD1,12'hFC1,12'hFC1,12'hFA0,12'hFA0,12'hFA0,12'hFA0,12'hFB4,12'hFD9,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFA0,12'hFD1,12'hFF3,12'hFF3,12'hFD1,12'hFD1,12'hFD1,12'hFC1,12'hFA0,12'hFA0,12'hFDA,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFA2,12'hFB0,12'hFE2,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFE3,12'hFE2,12'hFD1,12'hFD1,12'hFD1,12'hFC1,12'hFB1,12'hFA0,12'hFA0,12'hFA0,12'hFA1,12'hFC6,12'hFEC,12'hFA0,12'hFD1,12'hFE3,12'hFF3,12'hFF3,12'hFE2,12'hFD1,12'hFD1,12'hFD1,12'hFA1,12'hFA0,12'hFD7,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFB3,12'hFB0,12'hFE2,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFE3,12'hFD2,12'hFD1,12'hFD1,12'hFD1,12'hFC1,12'hFB1,12'hFA0,12'hFA0,12'hFA0,12'hFA1,12'hFD1,12'hFE2,12'hFF3,12'hFF3,12'hFF3,12'hFE2,12'hFD1,12'hFD1,12'hFD1,12'hFA1,12'hFA0,12'hFC5,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFC5,12'hFA0,12'hFD1,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFE2,12'hFD1,12'hFD1,12'hFD1,12'hFD1,12'hFC1,12'hFB1,12'hFA1,12'hFD1,12'hFD1,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFD1,12'hFD1,12'hFD1,12'hFB1,12'hFA0,12'hFB3,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFD8,12'hFA0,12'hFD1,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFE2,12'hFD1,12'hFD1,12'hFD1,12'hFD1,12'hFD1,12'hFD1,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFE2,12'hFD1,12'hFD1,12'hFB1,12'hFA0,12'hFB1,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFDA,12'hFA0,12'hFD1,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFE2,12'hFD1,12'hFD1,12'hFC1,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFE3,12'hFD1,12'hFD1,12'hFC1,12'hFA0,12'hFA0,12'hFFE,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFEC,12'hFA0,12'hFC0,12'hFE2,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFC1,12'hFD1,12'hFE2,12'hFF3,12'hFF3,12'hFF3,12'hFE2,12'hFE3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFD1,12'hFD1,12'hFC1,12'hFA0,12'hFA0,12'hFEC,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFE,12'hFA0,12'hFC0,12'hFE2,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFD1,12'hFD1,12'hFD1,12'hFD1,12'hFD1,12'hFE2,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFE2,12'hFD1,12'hFC1,12'hFA0,12'hFA0,12'hFEA,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFA1,12'hFB0,12'hFE2,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFD2,12'hFD1,12'hFC1,12'hFA1,12'hFB0,12'hFC0,12'hFD1,12'hFD1,12'hFE2,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFE3,12'hFD1,12'hFD1,12'hFA1,12'hFA0,12'hFD8,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFB3,12'hFB0,12'hFD1,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFE2,12'hFD1,12'hFC1,12'hFA1,12'hFD9,12'hFB3,12'hFA0,12'hFB0,12'hFC0,12'hFD0,12'hFD1,12'hFE2,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFD1,12'hFD1,12'hFB1,12'hF90,12'hFC6,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFB5,12'hFA0,12'hFD1,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFD1,12'hFC1,12'hFA0,12'hFFF,12'hFFF,12'hFFF,12'hFEC,12'hFC6,12'hFA1,12'hFA0,12'hFB0,12'hFC0,12'hFD1,12'hFE2,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFE2,12'hFD1,12'hFB1,12'hFA0,12'hFB4,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFC7,12'hFA0,12'hFD1,12'hFE2,12'hFF3,12'hFF3,12'hFF3,12'hFD1,12'hFC1,12'hFA0,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFD9,12'hFB4,12'hFA0,12'hFB0,12'hFC0,12'hFD1,12'hFE2,12'hFF3,12'hFF3,12'hFF3,12'hFF3,12'hFE3,12'hFD1,12'hFB1,12'hFA0,12'hFB2,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFD9,12'hFA0,12'hFD1,12'hFE2,12'hFF3,12'hFF3,12'hFD1,12'hFC1,12'hFA0,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFEC,12'hFC7,12'hFB2,12'hFA0,12'hFB0,12'hFD1,12'hFE2,12'hFF3,12'hFF3,12'hFF3,12'hFE2,12'hFC1,12'hFA0,12'hFA1,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFEC,12'hFA0,12'hFC0,12'hFE2,12'hFF3,12'hFE2,12'hFC1,12'hFA0,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFDA,12'hFB5,12'hFA0,12'hFB0,12'hFC0,12'hFE2,12'hFF3,12'hFE2,12'hFC1,12'hFA0,12'hFA0,12'hFFD,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFD,12'hFA0,12'hFC0,12'hFD1,12'hFE2,12'hFC1,12'hFA0,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFD,12'hFC8,12'hFB3,12'hFB0,12'hFC0,12'hFE1,12'hFD1,12'hFA0,12'hFA0,12'hFEB,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFA1,12'hFB0,12'hFD1,12'hFC1,12'hFA0,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFDB,12'hFC6,12'hFB1,12'hFB0,12'hFA0,12'hF90,12'hFD9,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFA2,12'hFB0,12'hFC1,12'hFA0,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFE,12'hFD9,12'hFB3,12'hF90,12'hFC5,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFB4,12'hFA0,12'hFA0,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFEA,12'hFEB},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFC6,12'hFA0,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFD9,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF},
{12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF,12'hFFF}};
localparam TRANSPERENT = 12'hFFF;
	
assign in_rectangle_lightning_1 = (pxl_x >= topLeft_x_light_1) && (pxl_x < topLeft_x_light_1+width_lightning) && (pxl_y >= topLeft_y_light_1) && (pxl_y < topLeft_y_light_1+height_lightning);
assign in_rectangle_lightning_2 = (pxl_x >= topLeft_x_light_2) && (pxl_x < topLeft_x_light_2+width_lightning) && (pxl_y >= topLeft_y_light_2) && (pxl_y < topLeft_y_light_2+height_lightning);
assign in_rectangle_lightning_3 = (pxl_x >= topLeft_x_light_3) && (pxl_x < topLeft_x_light_3+width_lightning) && (pxl_y >= topLeft_y_light_3) && (pxl_y < topLeft_y_light_3+height_lightning);
assign offset_x_lightning_1 = pxl_x - topLeft_x_light_1;
assign offset_y_lightning_1 = pxl_y - topLeft_y_light_1;
assign offset_x_lightning_2 = pxl_x - topLeft_x_light_2;
assign offset_y_lightning_2 = pxl_y - topLeft_y_light_2;
assign offset_x_lightning_3 = pxl_x - topLeft_x_light_3;
assign offset_y_lightning_3 = pxl_y - topLeft_y_light_3;
always @(posedge clk or negedge resetN) begin
	if (!resetN) begin
		drawing_lightning_1 <= 0;
		drawing_lightning_2 <= 0;
		drawing_lightning_3 <= 0;
		Red_level <= 4'hF;
		Green_level <= 4'hF;
		Blue_level <= 4'hF;
	end
	else begin

		if (in_rectangle_lightning_1 && Bitmap[offset_y_lightning_1][offset_x_lightning_1] != TRANSPERENT && in_air_1) begin
			drawing_lightning_1<=1;
			Red_level <= Bitmap[offset_y_lightning_1][offset_x_lightning_1] [11:8];
			Green_level <= Bitmap[offset_y_lightning_1][offset_x_lightning_1] [7:4];
			Blue_level <= Bitmap[offset_y_lightning_1][offset_x_lightning_1] [3:0];
			
				
		end
		else begin
			drawing_lightning_1<=0;
		end
		if (in_rectangle_lightning_2 && Bitmap[offset_y_lightning_2][offset_x_lightning_2] != TRANSPERENT && in_air_2) begin
			drawing_lightning_2<=1;
			Red_level <= Bitmap[offset_y_lightning_2][offset_x_lightning_2] [11:8];
			Green_level <= Bitmap[offset_y_lightning_2][offset_x_lightning_2] [7:4];
			Blue_level <= Bitmap[offset_y_lightning_2][offset_x_lightning_2] [3:0];
				
		end
		else begin
			drawing_lightning_2<=0;
		end
		if (in_rectangle_lightning_3 && Bitmap[offset_y_lightning_3][offset_x_lightning_3] != TRANSPERENT && in_air_3) begin
			drawing_lightning_3<=1;
			Red_level <= Bitmap[offset_y_lightning_3][offset_x_lightning_3] [11:8];
			Green_level <= Bitmap[offset_y_lightning_3][offset_x_lightning_3] [7:4];
			Blue_level <= Bitmap[offset_y_lightning_3][offset_x_lightning_3] [3:0];
				
		end
		else begin
			drawing_lightning_3<=0;
		end
			
		
	end
end

endmodule