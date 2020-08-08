module bullet(
				input logic Clk, Reset, frame_clk, 
				input logic [15:0] keycode,
				input logic [9:0] Char_X, Char_Y, Monster_X, Monster_Y, Monster2_X, Monster2_Y,
				output logic [9:0] bullet_X, bullet_Y,
				output logic hit,
				output logic hit2
);

//	parameter [9:0] bullet_X_top = 10'd278;  // Center position on the X axis VGA is 640 * 480
//	parameter [9:0] bullet_Y_top = 10'd190;  // Center position on the Y axis
	parameter [9:0] bullet_X_Min = 10'd40;       // Leftmost point on the X axis
	parameter [9:0] bullet_X_Max = 10'd599;     // Rightmost point on the X axis
	parameter [9:0] bullet_Y_Min = 10'd40;       // Topmost point on the Y axis
	parameter [9:0] bullet_Y_Max = 10'd439;     // Bottommost point on the Y axis
	parameter [9:0] bullet_X_Step = 10'd4;    // Step size on the X axis
	parameter [9:0] bullet_Y_Step = 10'd4;      // Step size on the Y axis
// temporary variable	
	parameter [9:0] bullet_X_Size = 10'd5; 
	parameter [9:0] bullet_Y_Size = 10'd5;
	parameter [9:0] monster_X_Size = 10'd40;
	parameter [9:0] monster_Y_Size = 10'd40;
	parameter [9:0] bullet_start = 10'd20;

	//////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
	 
	logic [9:0] bullet_X_Pos, bullet_X_Motion, bullet_Y_Pos, bullet_Y_Motion;
	logic [9:0] bullet_X_Pos_in, bullet_X_Motion_in, bullet_Y_Pos_in, bullet_Y_Motion_in;
	logic proceed, miss;

	enum logic [4:0] {Start, Up, Right, Down, Left} State, Next_state;

	assign bullet_X = bullet_X_Pos;
	assign bullet_Y = bullet_Y_Pos;

// assign bullet position and motion
	always_ff @(posedge Clk) begin
		if(Reset|(~proceed)|hit|miss|hit2) begin
			bullet_X_Pos <= Char_X + bullet_start;
			bullet_Y_Pos <= Char_Y + bullet_start;
			bullet_X_Motion <= 10'd0;
			bullet_Y_Motion <= 10'd0;
		end
		else begin
			bullet_X_Pos <= bullet_X_Pos_in;
			bullet_Y_Pos <= bullet_Y_Pos_in;
			bullet_X_Motion <= bullet_X_Motion_in;
			bullet_Y_Motion <= bullet_Y_Motion_in;
		end
	end

// 2-always state machine
	always_ff @(posedge Clk) begin
		if(Reset)
			State <= Start;
		else
			State <= Next_state;
	end

	always_comb begin
	
		bullet_Y_Motion_in = bullet_Y_Motion;
		bullet_X_Motion_in = bullet_X_Motion;
		
		bullet_X_Pos_in = bullet_X_Pos;
		bullet_Y_Pos_in = bullet_Y_Pos;
		
		proceed = 1'b1;
		Next_state = State;

		case(State)
			Start:
			begin
			if (keycode[7:0] == 8'h52)
				Next_state = Up;
			else if (keycode[7:0] == 8'h51)
				Next_state = Down;
			else if (keycode[7:0] == 8'h50)
				Next_state = Left;
			else if (keycode[7:0] == 8'h4f)
				Next_state = Right;
			end
			Up, Down, Left, Right:
			begin
				if (hit|miss|hit2)
					Next_state = Start;
			end
			default:Next_state = State;
				
		endcase
		
		if (frame_clk_rising_edge) begin
		

		unique case(State)
			Start:	
				proceed = 1'b0;
			Up: 
			begin
//				if(bullet_X_Pos == 10'b0) begin
//					bullet_X_Pos_in = Char_X;
//					bullet_Y_Pos_in = Char_Y;
//				end
				bullet_Y_Motion_in = (~(bullet_Y_Step) + 1'b1);
			end
			Down: 
			begin
//				if(bullet_X_Pos == 10'b0) begin
//					bullet_X_Pos_in = Char_X;
//					bullet_Y_Pos_in = Char_Y;
//				end
				bullet_Y_Motion_in = bullet_Y_Step;
			end
			Left: 
			begin
//				if(bullet_X_Pos == 10'b0) begin
//					bullet_X_Pos_in = Char_X;
//					bullet_Y_Pos_in = Char_Y;
//				end
				bullet_X_Motion_in = (~(bullet_X_Step) + 1'b1);
			end
			Right: 
			begin
//				if(bullet_X_Pos == 10'b0) begin
//					bullet_X_Pos_in = Char_X;
//					bullet_Y_Pos_in = Char_Y;
//				end
				bullet_X_Motion_in = bullet_X_Step;
			end
		endcase
		bullet_X_Pos_in = bullet_X_Pos + bullet_X_Motion;
		bullet_Y_Pos_in = bullet_Y_Pos + bullet_Y_Motion;
		end
	end

// collision detection
	always_comb begin
		miss = 1'b0;
		hit = 1'b0;
		hit2 = 1'b0;
		if (State != Start) begin
			if (bullet_Y_Pos_in <= bullet_Y_Min || (bullet_Y_Pos_in + bullet_Y_Size) >= bullet_Y_Max)
				miss = 1'b1;
			else if (bullet_X_Pos_in <= bullet_X_Min || (bullet_X_Pos_in + bullet_X_Size) >= bullet_X_Max)
				miss = 1'b1;
			else if (bullet_X_Pos_in <= (Monster_X + monster_X_Size) && bullet_X_Pos_in >= (Monster_X) && bullet_Y_Pos_in <= (Monster_Y + monster_Y_Size) && bullet_Y_Pos_in >= (Monster_Y))
				hit = 1'b1;
			else if (bullet_X_Pos_in <= (Monster2_X + monster_X_Size) && bullet_X_Pos_in >= (Monster2_X) && bullet_Y_Pos_in <= (Monster2_Y + monster_Y_Size) && bullet_Y_Pos_in >= (Monster2_Y))
				hit2 = 1'b1;
		end
	end

endmodule
