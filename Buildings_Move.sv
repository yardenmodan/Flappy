module Buildings_Move #(parameter width_building=80, parameter height_bird =56)(
input slow_down,
input clk,
input resetN,
 
output reg signed [31:0] topLeft_x_1,
output reg signed [31:0] topLeft_y_1, 
output reg signed [31:0]  topLeft_x_2,
output reg signed [31:0] topLeft_y_2, 

output reg [31:0] height_window,
output reg [31:0] stage,
output reg slow_draw);

	
	localparam [31:0]	divider = 32'd230_000;// changing speed 
	localparam [31:0] sec_15 =32'd500_000_000;
	localparam [31:0] speed_quantum=32'd1;// number of pixels increasing each stage

	localparam [31:0] height_window_quantum=32'd5;
	localparam [31:0] screen_size=32'd640;
	localparam [31:0] screen_height=32'd480;
	reg [31:0] last_speed_x;
	reg [31:0] last_stage;
	reg [31:0] speed_x;
	reg [31:0] counter; //counter for moving pixels
	reg [31:0] counter_time; //counter_stage

	
	reg [31:0] topLeft_y_temp_2_reg;
	reg [31:0] topLeft_y_temp_1_reg;
	
	wire [31:0] random_1;
	wire [31:0] random_2;
	reg [31:0] random_norm_1;
	reg [31:0] random_norm_2;
	reg [31:0] counter_15_sec;
	reg [1:0] counting_stage;


	randomizer_1 randomize_1(.clk(clk), .resetN(resetN), .random_1(random_1));
	randomizer_2 randomize_2(.clk(clk), .resetN(resetN), .random_2(random_2));

	
	
	always @(posedge clk or negedge resetN) begin
		
		random_norm_1<={random_1}%screen_height;
		random_norm_2<={random_2}%screen_height;

		

		if (!resetN) begin
			stage<=0;
			speed_x<=1;
			counter<=0;
			counter_time<=0;
			topLeft_y_1<=0;// fixx
			topLeft_x_1<=screen_size/2-width_building/2;//
			topLeft_x_2<=screen_size-1;
			height_window<=height_bird*2.5;
			slow_draw<=1;
			counter_15_sec<=sec_15;
			counting_stage<=0;
			
			
		end
		else begin	
			counter<=counter+1;//?
			if ((counting_stage==0) || (counting_stage==2)) begin
				counter_time<=counter_time+1;
				
			end
			
			
			
		
			if ((!slow_down) && (stage!=0) && (counting_stage==0)) begin
				counting_stage<=1;
				last_stage<=stage;
				last_speed_x<=speed_x;
				
				slow_draw<=0;
			end
			if (counting_stage==1) begin
				
				if (counter_15_sec>0) begin
					counter_15_sec<=counter_15_sec-1;
					stage<=0;
					speed_x<=1;
				
				end
					
				else begin
					stage<=last_stage;
					speed_x<=last_speed_x;
					counting_stage<=2;
					counter_time<=0;
				end
			end
					
			if (counter_time>=sec_15) begin
					counter_time<=0;
					stage<=stage+1;
					speed_x<=speed_x+speed_quantum;
					if (height_window-height_window_quantum> height_bird) begin
						height_window<=height_window-height_window_quantum;
					end
			end
			
			
			if (random_norm_1>=screen_height-height_window) begin
				topLeft_y_temp_1_reg<=screen_height-height_window;
			end
			else begin
				topLeft_y_temp_1_reg<=random_norm_1;
			end 
			if (random_norm_2>=screen_height-height_window) begin
				topLeft_y_temp_2_reg<=screen_height-height_window;
			end
			else begin
				topLeft_y_temp_2_reg<=random_norm_2;
			end 
			begin
			
			
				if (topLeft_x_1 <= -80) begin
					topLeft_x_1<=screen_size-1;
					topLeft_y_1<=topLeft_y_temp_1_reg; // fixxx!
				end 
				if (topLeft_x_2 <= -80) begin
					topLeft_x_2 <= screen_size-1;
					topLeft_y_2<=topLeft_y_temp_2_reg; ///////// fix!
				end
				if (counter>=divider) begin// moving building pixels
					counter<=0;
					topLeft_x_1<=topLeft_x_1-speed_x;
					topLeft_x_2<=topLeft_x_2-speed_x;
					
				end
				
				
			end
		end
	end
	
endmodule
/////////////////////