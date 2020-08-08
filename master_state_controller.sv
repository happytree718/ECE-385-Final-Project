module master_state_controller(
							input Clk, Reset,
							input [15:0] keycode,
							input [9:0] Char_X, Char_Y,
							input finish_1, finish_2, finish_3, Die,
							output active_1, active_2, active_3, initial_frame, 
							output final_frame, game_over, soft_reset, active_key,
							output active_4, active_5, active_6, active_7
);

enum logic [4:0] {Start, L1, Wait1, Wait2, L2, L3, End, Game_Over} State, Next_state;

always_ff @(posedge Clk) begin
	if (Reset)begin
		State <= Start;
		F1 <= 1'b0;
		F2 <= 1'b0;
		F3 <= 1'b0;
		Fkey <= 1'b0;
		N1 <= 1'b0;
		N2 <= 1'b0;
		N3 <= 1'b0;
		active_key <= 1'b0;
   end
	else begin
		State <= Next_state;
		F1 = F1_in;
		F2 = F2_in;
		F3 = F3_in;
		Fkey = Fkey_in;
		N1 = N1_in;
		N2 = N2_in;
		N3 = N3_in;
		active_key = active_key_in;
	end
end

logic N1, N2, N3;
logic N1_in, N2_in, N3_in;
logic F1, F2, F3, Fkey;
logic F1_in, F2_in, F3_in, Fkey_in;
logic active_key_in;

always_comb begin
	initial_frame = 1'b0;
	final_frame = 1'b0;
	active_1 = 1'b0;
	active_2 = 1'b0;
	active_3 = 1'b0;
	active_4 = 1'b0;
	active_5 = 1'b0;
	active_6 = 1'b0;
	active_7 = 1'b0;
	game_over = 1'b0;
	soft_reset = 1'b0;
	active_key_in = active_key;
	N1_in = N1;
	N2_in = N2;
	N3_in = N3;
	F1_in = F1;
	F2_in = F2;
	F3_in = F3;
	Fkey_in = Fkey;
	Next_state = State;
		case(State)
			Start:begin
					if(keycode == 16'h0028)begin
						Next_state = L1;
						soft_reset = 1'b1;
						Fkey_in = 1'b0;
						active_key_in = 1'b0;
					end
					end
			L1: begin
					soft_reset = 1'b0;
					if(finish_1)begin
						F1_in = 1'b1;
					end
					else if((F1 == 1'b1 && Char_X >= 10'd540 && Char_Y >= 10'd220 && Char_Y <= 10'd260) || keycode == 16'd0044)begin
						N2_in = 1'b1;
						Next_state = Wait1;
					end else if((F1 == 1'b1 && Char_X >= 10'd300 && Char_X <= 10'd330 && Char_Y <= 10'd60))begin
						N3_in = 1'b1;
						Next_state = Wait1;
					end else if(Die)
						Next_state = Game_Over;	
				 end
			Wait1:begin
						Next_state = Wait2;
						soft_reset = 1'b1;
					end
			Wait2:begin
						if(N2)begin
							Next_state = L2;
							N2_in = 1'b0;
						end else if(N3)begin
							Next_state = L3;
							N3_in = 1'b0;
						end else begin
							Next_state = L1;
							N1_in = 1'b0;
						end
						soft_reset = 1'b1;
					end
			L2: begin
					soft_reset = 1'b0;
					if(finish_2 && F2 == 1'b0)begin
						active_key_in = 1'b1;
						F2_in = 1'b1;
					end else if(active_key == 1'b1 && Char_X >= 10'd300 && Char_X <= 10'd330 && Char_Y >= 10'd210 && Char_Y <= 10'd230)begin
						active_key_in = 1'b0;
						Fkey_in = 1'b1;
					end else if(F2 == 1'b1 && Fkey == 1'b1 && Char_Y >= 10'd210 && Char_Y <= 10'd230 && Char_X <= 10'd60)begin
						N1_in = 1'b1;
						Next_state = Wait1;
					end else if(Die)begin
						Next_state = Game_Over;
					end
				 end
			L3: begin
					soft_reset = 1'b0;
					if(finish_3)begin
						F3_in = 1'b1;
					end
					else if((F3 == 1'b1 && Char_X >= 10'd300 && Char_X <= 10'd330 && Char_Y >= 10'd380))begin
						Next_state = Wait1;
						N1_in = 1'b1;
					end else if(Die)begin
						Next_state = Game_Over;	
					end else if(F3 == 1'b1 && Fkey == 1'b1 && Char_X >= 10'd300 && 
									Char_X <= 10'd330 && Char_Y >= 10'd210 && Char_Y <= 10'd230)begin
						Next_state = End;
					end
				 end
			End, Game_Over: begin
						soft_reset = 1'b1;
						if(keycode == 16'h0029)begin
							F1_in = 1'b0;
							F2_in = 1'b0;
							F3_in = 1'b0;
							Next_state = Start;
						end
					end
			default:;
		endcase
	
	case(State)
		Start: initial_frame = 1'b1;
		L1:begin
				if(F1 == 1'b0)
					active_1 = 1'b1;
				else
					active_4 = 1'b1;
			end
		L2:begin
				if(F2 == 1'b0)
					active_2 = 1'b1;
				else
					active_5 = 1'b1;
			end
		L3:begin
				if(F3 == 1'b0)
					active_3 = 1'b1;
				else
					active_6 = 1'b1;
			end
		Wait1, Wait2: 
			begin
				active_7 = 1'b1;
			end
		End: final_frame = 1'b1;
		Game_Over: game_over = 1'b1;
	endcase
end

endmodule
