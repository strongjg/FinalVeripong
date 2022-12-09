`timescale 1s / 1ps

module veripong(clk, rst, color, X, Y, plot, VGA_CLK, VGA_HS, VGA_VS, VGABlank, VGASync, VGA_R, VGA_G, VGA_B, P1Up, P1Down, P2Up, P2Down);
input clk, rst, color, plot;
input P1Up, P1Down, P2Up, P2Down;
input [7:0] X;
input [7:0] Y;
output VGA_CLK, VGA_HS, VGA_VS, VGABlank, VGASync;
output [9:0] VGA_R;
output [9:0] VGA_G;
output [9:0] VGA_B;

reg score;
reg [12:0] S;
reg [12:0] NS;

wire [9:0] X1;
wire [8:0] Y1;
wire [9:0] X2;
wire [8:0] Y2;
wire [2:0] color1;
wire [2:0] color2;

reg [9:0] CounterX;
reg [8:0] CounterY;

border border1(.clk(clk), .rst(rst), .P1Up(P1Up), .P1Down(P1Down), .P2Up(P2Up), .P2Down(P2Down), .CounterX(X1), .CounterY(Y1), .color(color1));

always @(posedge clk)
begin
	CounterY <= Y1;
	CounterX <= X1;
end

vga_adapter VGA(1'b1, clk, color1, CounterX, CounterY, 1'b1, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGABlank, VGASync, VGA_CLK);
defparam VGA.BITS_PER_COLOUR_CHANNEL = 1'b1;
defparam VGA.MONOCHROME = "FALSE";
defparam VGA.RESOLUTION = "320x240";
defparam VGA.BACKGROUND_IMAGE = "background.mif";

/*parameter OBJECT_SIZE = 10,
		  BAR_X_SIZE = 60,
		  BAR_Y_SIZE = 5,
		  BAR_SPEED = 5,
		  SCREEN_BOTTOM = 50;

integer X1 = 20;
integer Y1 = 20;
always @(posedge clk)
begin
	CounterX1 <= X1;
	CounterY1 <= Y1;
	color1 <= 3'b111;
end

wire ball = ball_inX & ball_inY;
wire outline = (CounterX[7:3]==0) || (CounterX[7:3]==79) || (CounterY[7:3]==0) || (CounterY[7:3]==59);
wire paddle = (CounterX>=PaddlePosition+8) && (CounterX<=PaddlePosition+120) && (CounterY[7:4]==27);
wire BouncingObject = outline | paddle; // active if the border or paddle is redrawing itself

reg ResetCollision;
always @(posedge clk)
	ResetCollision <= (CounterY==500) & (CounterX==0);  // active only once for every video frame

reg CollisionX1, CollisionX2, CollisionY1, CollisionY2;

always @(posedge clk)
	if(ResetCollision)
		CollisionX1<=0;
	else if(BouncingObject & (CounterX == ballX) & (CounterY == ballY + 8))
		CollisionX1<=1;
	
always @(posedge clk)
	if(ResetCollision)
		CollisionX2<=0;
	else if(BouncingObject & (CounterX == ballX+16) & (CounterY == ballY + 8))
		CollisionX2<=1;
	
always @(posedge clk)
	if(ResetCollision)
		CollisionY1<=0;
	else if(BouncingObject & (CounterX == ballX+ 8) & (CounterY == ballY))
		CollisionY1<=1;
	
always @(posedge clk)
	if(ResetCollision) 
		CollisionY2<=0;
	else if(BouncingObject & (CounterX == ballX + 8) & (CounterY == ballY + 16))
		CollisionY2<=1;

/////////////////////////////////////////////////////////////////
wire UpdateBallPosition = ResetCollision;  // update the ball position at the same time that we reset the collision detectors

reg ball_dirX, ball_dirY;
always @(posedge clk)
if(UpdateBallPosition)
begin
	if(~(CollisionX1 & CollisionX2))        // if collision on both X-sides, don't move in the X direction
	begin
		ballX <= ballX + (ball_dirX ? -1 : 1);
		if(CollisionX2)
			ball_dirX <= 1;
		else if(CollisionX1)
			ball_dirX <= 0;
	end

	if(~(CollisionY1 & CollisionY2))        // if collision on both Y-sides, don't move in the Y direction
	begin
		ballY <= ballY + (ball_dirY ? -1 : 1);
		if(CollisionY2)
			ball_dirY <= 1;
		else if(CollisionY1)
			ball_dirY <= 0;
	end
end*/

endmodule