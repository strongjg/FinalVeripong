module baller (clk, rst, CounterX1, CounterY1, color1);
input clk, rst;
output reg [9:0] CounterX1;
output reg [8:0] CounterY1;
output reg [2:0] color1;
reg [2:0] color2;

integer X1 = 20;
integer Y1 = 20;
			
always @(posedge clk)
begin
	CounterX1 <= X1;
	CounterY1 <= Y1;
	color1 <= 3'b111;
end

endmodule