module monster2(
				input logic Clk, Reset, frame_clk, hit,
				input logic [9:0]		Char_X, Char_Y,
				output logic [9:0]	Monster_X_2, Monster_Y_2,
				output logic 	hit_char
);

	parameter [9:0] monster_X_top = 10'd200;  // Center position on the X axis VGA is 640 * 480
	parameter [9:0] monster_Y_top = 10'd300; 

	parameter [9:0] monster_X_Min = 10'd40;       // Leftmost point on the X axis
	parameter [9:0] monster_X_Max = 10'd599;     // Rightmost point on the X axis
	parameter [9:0] monster_Y_Min = 10'd40;       // Topmost point on the Y axis
	parameter [9:0] monster_Y_Max = 10'd439;     // Bottommost point on the Y axis
	parameter [9:0] monster_X_Step = 10'd3;    // Step size on the X axis
	parameter [9:0] monster_Y_Step = 10'd3;      // Step size on the Y axis
// temporary variable	
	parameter [9:0] monster_X_Size = 10'd20;
	parameter [9:0] monster_Y_Size = 10'd20;
	parameter [1:0] initial_health = 2'b11;
	parameter [9:0] count_Mid = 10'd80;
	parameter [9:0] count_Max = 10'd160;
	
	//////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
	
	logic [1:0] health;
	logic [9:0] monster_X_Pos, monster_X_Motion, monster_Y_Pos, monster_Y_Motion;
	logic [9:0] monster_X_Pos_in, monster_X_Motion_in, monster_Y_Pos_in, monster_Y_Motion_in;
	logic [9:0] count, count_in;
	logic [1:0] dir_mon;
	
	always_ff @(posedge Clk) begin
		if (Reset) begin
			health <= initial_health;
			monster_X_Pos <= monster_X_top;
			monster_Y_Pos <= monster_Y_top;
			monster_X_Motion <= 10'd0;
			monster_Y_Motion <= 10'd0;
			count <= 10'd0;
		end
		else begin
			monster_X_Pos <= monster_X_Pos_in;
			monster_Y_Pos <= monster_Y_Pos_in;
			monster_X_Motion <= monster_X_Motion_in;
			monster_Y_Motion <= monster_Y_Motion_in;
			count <= count_in;
		end
		
		if(count > count_Max) begin
			count <= 10'b0;
		end
		
//		if(monster_X_Pos > Char_X)begin
//			dir_mon = 2'b01;
//		end else if (monster_Y_Pos > Char_Y)begin
//			dir_mon = 2'b00;
//		end else if (monster_X_Pos <= Char_X)begin
//			dir_mon = 2'b11;
//		end else begin
//			dir_mon = 2'b10;
//		end
		
		if(monster_X_Pos >= Char_X) begin
			if(monster_Y_Pos >= Char_Y) begin
				if((monster_X_Pos - Char_X) >= (monster_Y_Pos - Char_Y)) begin
					dir_mon = 2'b01;//a
				end 
				else begin
					dir_mon = 2'b00;//w
				end
			end
			else begin
				if((monster_X_Pos - Char_X) >= (Char_Y - monster_Y_Pos)) begin
					dir_mon = 2'b01;//a
				end 
				else begin
					dir_mon = 2'b10;//s
				end
			end
		end
		else begin
			if(monster_Y_Pos >= Char_Y) begin
				if((Char_X - monster_X_Pos) >= (monster_Y_Pos - Char_Y)) begin
					dir_mon = 2'b11;//d
				end 
				else begin
					dir_mon = 2'b00;//w
				end
			end
			else begin
				if((Char_X - monster_X_Pos) >= (Char_Y - monster_Y_Pos)) begin
					dir_mon = 2'b11;//d
				end 
				else begin
					dir_mon = 2'b10;//s
				end
			end
		end
		
		if (hit)
			health <= health - 1'b1;
		if (health == 2'b00) begin
			monster_X_Pos <= 10'b0;
			monster_Y_Pos <= 10'b0;
		end
		
	end
	
	always_comb
    begin
        // By default, keep motion and position unchanged
        monster_X_Pos_in = monster_X_Pos;
        monster_Y_Pos_in = monster_Y_Pos;
		  count_in = count;
		  if(count > count_Mid)begin
		  		monster_X_Motion_in = monster_X_Motion;
				monster_Y_Motion_in = monster_Y_Motion;
		  end else begin
				monster_X_Motion_in = 10'b0;
				monster_Y_Motion_in = 10'b0;
		  end
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
				count_in = count + 10'd1;
            // Be careful when using comparators with "logic" datatype because compiler treats 
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
            // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, but rather a large positive number.
				if(dir_mon == 2'b00) begin //w
					monster_Y_Motion_in = (~(monster_Y_Step) + 1'b1);
					monster_X_Motion_in = 10'b0;
				end else if(dir_mon == 2'b01) begin //a
					monster_X_Motion_in = (~(monster_X_Step) + 1'b1);
					monster_Y_Motion_in = 10'b0;
				end else if(dir_mon == 2'b10) begin //s
					monster_Y_Motion_in = monster_Y_Step;
					monster_X_Motion_in = 10'b0;
				end else if(dir_mon == 2'b11) begin //d
					monster_X_Motion_in = monster_X_Step;
					monster_Y_Motion_in = 10'b0;
				end 
				
            // Update the ball's position with its motion
				if( monster_Y_Pos + monster_Y_Size >= monster_Y_Max && dir_mon == 2'b10) // Ball is at the bottom edge, BOUNCE!
				begin
                monster_Y_Motion_in = 10'd0;
				end
            if ( monster_Y_Pos <= monster_Y_Min && dir_mon == 2'b00)  // Ball is at the top edge, BOUNCE!
				begin
                monster_Y_Motion_in = 10'd0;
				end
            // TODO: Add other boundary detections and handle keypress here.
        
				if( monster_X_Pos + monster_X_Size >= monster_X_Max && dir_mon == 2'b11)  // Ball is at the right edge, BOUNCE!
				begin
                monster_X_Motion_in = 10'd0;
				end
            if ( monster_X_Pos <= monster_X_Min && dir_mon == 2'b10)  // Ball is at the left edge, BOUNCE!
				begin
                monster_X_Motion_in = 10'd0;  // 2's complement.
				end
				
            monster_X_Pos_in = monster_X_Pos + monster_X_Motion;
            monster_Y_Pos_in = monster_Y_Pos + monster_Y_Motion;
        end
	end
	
	always_comb begin
		Monster_X_2 = monster_X_Pos;
		Monster_Y_2 = monster_Y_Pos;
	end
	
	always_comb begin
		hit_char = 1'b0;
		if (Char_X <= (Monster_X_2 + monster_X_Size) && Char_X >= (Monster_X_2) && Char_Y <= (Monster_Y_2 + monster_Y_Size) && Char_Y >= (Monster_Y_2))begin
			hit_char = 1'b1;
		end
	end

endmodule
