module border (clk, rst, P1Up, P1Down, CounterX, CounterY, color);
input clk, rst;
input P1Up, P1Down;
output reg [9:0] CounterX;
output reg [8:0] CounterY;
output reg [2:0] color;
reg [2:0] color1;

integer X = 5;
integer Y = 140;

reg [2:0] S;
reg [2:0] NS;
			
always @(posedge clk)
begin
	if (X == 5 && Y >= 100)
	begin
		Y <= Y - 1;
		color1 <= 3'b111;
	end
	else if (X == 5 && Y == 99)
	begin	
		X <= 315;
		Y <= 140;
	end
	else if (X == 315 && Y >= 100)
	begin
		Y <= Y - 1;
		color1 <= 3'b110;
	end
	else if (X == 315 && Y == 99)
	begin	
		X <= 160;
		Y <= 120;
	end
	CounterX <= X;
	CounterY <= Y;
	color <= color1;
end

endmodule