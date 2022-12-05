module counter (clk, rst, CounterX, CounterY);
input clk, rst;
output reg CounterX, CounterY;
reg X = 1'd0;
reg Y = 1'd0;

reg [4:0] S;
reg [4:0] NS;

parameter XCOUNT = 1'd0,
			 YCOUNT = 1'd1,
			 XCOUNTER = 1'd2,
			 YCOUNTER = 1'd3,
			 DONE = 1'd4;
			 
always @(*)
	case (S)
		XCOUNT:
		begin	
			X = X + 1;
			if (X >= 20 && X <= 300)
				NS = XCOUNTER;
			else if (X == 320)
				NS = YCOUNT;
			else
				NS = XCOUNT;
		end
		XCOUNTER:
		begin
			CounterX = CounterX + 1;
			NS = XCOUNT;
		end
		YCOUNT:
		begin
			Y = Y + 1;
			if (Y >= 20 && Y <= 240)
				NS = YCOUNTER;
			else if (Y == 240)
				NS = DONE;
			else
				NS = YCOUNT;
		end
		YCOUNTER:
		begin
			CounterY = CounterY + 1;
			NS = YCOUNT;
		end
	endcase

endmodule