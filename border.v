module border (clk, rst, P1Up, P1Down, P2Up, P2Down, CounterX, CounterY, color);
input clk, rst;
input P1Up, P1Down, P2Up, P2Down;
output reg [9:0] CounterX;
output reg [8:0] CounterY;
output reg [2:0] color;
reg [2:0] color1;

integer X = 5;
integer Y = 140;
integer X1;
integer Y1;
integer paddle1Y = 140;
integer paddle2Y = 140;
integer ballX = 160;
integer ballY = 120;

reg ballX_d = 1'b1;
reg ballY_d = 1'b1;

reg [2:0] start = 3'd0;
reg en1 = 1'b0;
reg en2;

reg [4:0] S;
reg [4:0] NS;
parameter START = 5'd0,
			 ERASE = 5'd1,
			 UPDATE = 5'd2,
			 DRAW = 5'd3,
			 ERASEBOARD = 5'd4;
			 
always @(posedge clk or negedge rst)
begin
	if (rst == 1'b0)
	begin
		//color1 <= 1'b000;
		//X <= 0;
		//Y <= 0;
		S <= START;
	end
	else
	begin
		S <= NS;
	end
end

/*always @(*)
begin
	case(S)
		START: begin
				 NS = ERASE;
				 end
		ERASE: begin
					if (P1Up == 1'b0 || P1Down == 1'b0)
					begin
						X = 5;
						Y = paddle1Y;
						paddle1Y = paddle1Y + 1;
						if (X == 5 && paddle1Y <= (paddle1Y))
						begin
							color1 = 3'b000;
							paddle1Y = paddle1Y - 1;
						end
					end
					else if (P2Up == 1'b0 || P2Down == 1'b0)
					begin
						X = 5;
						Y = paddle2Y;
						paddle2Y = paddle2Y + 1;
						if (X == 5 && paddle2Y == (paddle2Y))
						begin
							color1 = 3'b000;
							paddle2Y = paddle2Y - 1;
						end
					end
				 //NS = DRAW;
				 end
		UPDATE: begin
					  if (P1Up == 1'b0)
					  begin
						 if (paddle1Y >= 240)
						 begin
							paddle1Y = paddle1Y + 0;
						 end
						 else
						 begin
							paddle1Y = paddle1Y + 1;
						 end
					  end
					  
					  if (P1Down == 1'b0)
					  begin
						 if (paddle2Y <= 0)
						 begin
							paddle1Y = paddle1Y - 0;
						 end
						 else
						 begin
							paddle1Y = paddle1Y - 1;
						 end
					  end
					  
					  if (P2Up == 1'b0)
					  begin
						 if (paddle2Y >= 240)
						 begin
							paddle2Y = paddle2Y + 0;
						 end
						 else
						 begin
							paddle2Y = paddle2Y + 1;
						 end
					  end
					  
					  if (P2Down == 1'b0)
					  begin
						 if (paddle2Y <= 0)
						 begin
							paddle2Y = paddle2Y - 0;
						 end
						 else
						 begin
							paddle2Y = paddle2Y - 1;
						 end
					  end
				  NS = DRAW;
				  end
		DRAW: begin
					color1 = 3'b111;
					X = 5;
					Y = paddle1Y;
					X = 315;
					Y = paddle2Y;
					NS = ERASE;
				end
		ERASEBOARD: begin
							color1 = 3'b000;
							X = X1;
							Y = Y1;
							NS = START;
						end
		default: NS = START;
	endcase
end*/


/*always @(posedge clk)
begin
	X2 <= 5;
	if (Y2 < 240)
	begin
	Y2 <= Y2 + 1;
	end
end

always @(posedge clk)
begin
	X3 <= 315;
	if (Y3 < 240)
	begin
	Y3 <= Y3 + 1;
	end
end


always @(posedge clk)
begin
	if (Y1 <= 240)
	begin
		X1 <= X1 + 1;
	end
	else if (X1 == 320)
	begin	
		Y1 <= Y1 + 1;
	end	
end*/
			
always @(posedge clk)
begin
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
		end
		else if (X == 315 && Y == 99)
		begin	
			X <= 160;
			Y <= 120;
			start = 3'd1;
			//NS <= START;
		end
	end
	
	if (start == 3'd1)
	begin
		
		ballX = ballX + 1;
		//color1 <= 3'b000;
		X <= ballX + 1;
		Y <= ballY;
		color1 <= 3'b111;
		if (ballX <= 315)
		begin
			ballX <= ballX + 1;
		end
		else if (ballX >= 0)
		begin
			ballX <= ballX - 1;
		end
		
		if (ballY <= 240)
		begin
			ballY <= ballY + 1;
		end
		else if (ballY >= 0)
		begin	
			ballY <= ballY - 1;
		end
	
		
		/*if (P1Up == 1'b0)
		begin
			X <= 5;
			Y <= paddle1Y;
			paddle1Y <= paddle1Y + 1;
			if (X == 5 && paddle1Y <= (paddle1Y))
			begin
				color1 <= 3'b000;
				paddle1Y <= paddle1Y - 1;
				en1 <= 1'b1;
			end
			//paddle1Y <= paddle1Y - 40;
		end
		
		if (P1Up == 1'b1 && en1 == 1'b1)
		begin
			X <= 5;
			//Y <= paddle1Y;
			paddle1Y <= 140;
			//paddle1Y <= paddle1Y - 80;
			if (X == 5 && Y >= 100)
			begin
				Y <= Y - 1;
				color1 <= 3'b000;
			end
		end
		
		if (P1Down == 1'b0)
		begin
			X <= 5;
			Y <= paddle1Y;
			if (X == 5 && paddle1Y <= (paddle1Y))
			begin
				paddle1Y <= paddle1Y - 1;
				color1 <= 3'b000;
			end
			else if (X == 5 && paddle1Y >= (paddle1Y + 80))
			begin
				paddle1Y <= paddle1Y - 1;
				color1 <= 3'b111;
			end
		end
				
		if (P2Up == 1'b0)
		begin
			X <= 315;
			Y <= paddle2Y + 1;
			if (paddle2Y >= 240)
			begin
				Y <= paddle2Y + 0;
			end
		end
		else if (P2Down == 1'b0)
		begin
			X <= 315;
			Y <= paddle2Y - 1;
			if (paddle2Y <= 0)
			begin
				Y <= paddle2Y + 0;
			end
		end
	end
	
	/*if (start == 3'd2)
	begin
		X <= 0;
		Y <= 0;
		color1 <= 3'b000;
		if (Y <= 240)
		begin
			if (X <= 320)
			begin
				X <= X + 1;
				if (X == 320)
				begin
					Y <= Y + 1;
					X <= 0;
				end
			end
		end*/		
	end
	
	CounterX <= X;
	CounterY <= Y;
	//X <= ballX;
	//Y <= ballY;
	color <= color1;
end

endmodule