module veripong(clk, rst, color, X, Y, plot, VGA_CLK, VGA_HS, VGA_VS, VGABlank, VGASync, VGA_R, VGA_G, VGA_B);
input clk, rst, color, plot;
input [9:0] X;
input [9:0] Y;
output VGA_CLK, VGA_HS, VGA_VS, VGABlank, VGASync;
output reg [9:0] VGA_R;
output reg [9:0] VGA_G;
output reg [9:0] VGA_B;

reg score;
reg [12:0] S;
reg [12:0] NS;

wire BorderX;
wire BorderY;
wire CounterX;
wire CounterY;
counter count(clk, rst, CounterX, CounterY);

vga_adapter VGA(.resetn(1'b1), .clock(clk), .colour(3'b111), .x(9'd200), .y(8'd200), .plot(1'b1), .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS), .VGA_BLANK(VGABlank), .VGA_SYNC(VGASync), .VGA_CLK(VGA_CLK));

parameter BORDERDRAW = 8'd0,
		PADDLE1DRAW = 8'd1,
		PADDLE2DRAW = 8'd2,
		BALLDRAW = 8'd3,
		SCORE1DRAW = 8'd4,
		SCORE2DRAW = 8'd5,
		WAIT = 8'd6,
		PADDLE1MOVE = 8'd7,
		PADDLE2MOVE = 8'd8,
		BALLMOVE = 8'd9,
		SCORE1ADD = 8'd10,
		SCORE2ADD = 8'd11,
		END = 8'd12;
			 
always @(posedge clk or negedge rst)
	if (rst == 1'b0)
	begin
		score = 1'd0;
		S <= WAIT;
	end
	else
		S <= NS;
		
always @(*)
	case (S)
		//Border FSM
		BORDERDRAW: 
		begin
			NS = PADDLE1DRAW;
		end
		PADDLE1DRAW:
			NS = PADDLE2DRAW;
		PADDLE2DRAW:
			NS = BALLDRAW;
		BALLDRAW:
			NS = SCORE1DRAW;
		SCORE1DRAW:
			NS = SCORE2DRAW;
		SCORE2DRAW:
			NS = WAIT;
		WAIT: if (score > 1'd3)
					NS = END;
				//else		
		//PADDLE1MOVE:
		//PADDLE2MOVE:
		//BALLMOVE:
		//SCORE1ADD:
		//SCORE2ADD:
		//END:
	endcase

endmodule