module background (clk, rst, CounterX, CounterY, color);
input clk, rst;
output reg [7:0] CounterX;
output reg [7:0] CounterY;
output reg [2:0] color;

integer X = 0;
integer Y = 0;

always @(posedge clk)
	begin
		if (X < 105 && Y == 0)
		begin
			X <= X + 1;
		end
		else if (X == 105 && Y < 115)
		begin
			Y <= Y + 1;
		end
		else if (X > 0 && Y == 115)
		begin
			X <= X - 1;
		end
		else if (X == 0 && Y > 0)
		begin
			Y <= Y - 1;
		end
		CounterX <= X;
		CounterY <= Y;
		color <= 3'b001;
	end

endmodule