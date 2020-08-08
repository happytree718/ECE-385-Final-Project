module BM_decider
(input logic [9:0] monster_bullet_X_L, monster_bullet_Y_L,
						 monster_bullet_X_R, monster_bullet_Y_R,
						 monster_bullet_X_U, monster_bullet_Y_U,
						 monster_bullet_X_D, monster_bullet_Y_D,
 input logic 		 dungeon_frame1, dungeon_frame2, dungeon_frame3, active_key,
 input logic [9:0] DrawX, DrawY,
 input logic [2:0] Health,
 input logic [9:0] Monster_X, Monster_Y, Monster_X_2, Monster_Y_2, bullet_X, bullet_Y,
 output logic 		 is_bullet, is_bullet_l, is_bullet_r, is_bullet_u, is_bullet_d,  is_monster1, is_monster2, is_monster3,
 output logic 		 is_heart, is_key,
 output logic [9:0] m1_idx_x, m1_idx_y, b_idx_x, b_idx_y, m2_idx_x, m2_idx_y,
						  bl_idx_x, bl_idx_y, br_idx_x, br_idx_y, 
					     bu_idx_x, bu_idx_y, bd_idx_x, bd_idx_y, key_idx_x, key_idx_y
);
parameter [9:0] monster_width = 10'd42;
parameter [9:0] monster_height = 10'd50;

parameter [9:0] bullet_height = 10'd5;
parameter [9:0] bullet_width= 10'd5;
parameter [9:0] heart_width = 10'd20;
parameter [9:0] bullet_start = 10'd20;
parameter [9:0] key_min_x = 10'd300;
parameter [9:0] key_min_y = 10'd210;

logic is_Mons1, is_Mons2, is_Mons3;

int heart_max;

assign is_monster1 = is_Mons1;
assign is_monster2 = is_Mons2;
assign is_monster3 = is_Mons3;

assign heart_max = Health * heart_width;


	always_comb begin

		if(DrawX < heart_max && DrawX >= 10'd0 && DrawY < 10'd20 && DrawY >= 10'd0 && 
										(dungeon_frame1 || dungeon_frame2 || dungeon_frame3))begin
			is_heart = 1'b1;
		end else begin
			is_heart = 1'b0;
		end
		
		if(active_key && DrawX >= 10'd300 && DrawX < 10'd360 && DrawY >= 10'd210 && DrawY < 10'd245)begin
			is_key = 1'b1;
			key_idx_x = DrawX - key_min_x;
			key_idx_y = DrawY - key_min_y;
		end else begin
			is_key = 1'b0;
			key_idx_x = 10'b0;
			key_idx_y = 10'b0;
		end
		
		is_Mons1 = 1'b0;
		is_Mons2 = 1'b0;
		is_Mons3 = 1'b0;
		m1_idx_x = 1'b0;
		m1_idx_y = 1'b0;
		m2_idx_x = 1'b0;
		m2_idx_y = 1'b0;
		if(Monster_X > 10'b0 && (DrawX < Monster_X + monster_width) && (DrawX >= Monster_X) 
						  && (DrawY < Monster_Y + monster_height) && (DrawY >= Monster_Y))begin 
			if (dungeon_frame1) begin
				is_Mons1 = 1'b1;
				is_Mons2 = 1'b0;
			end else if (dungeon_frame2 || dungeon_frame3) begin
				is_Mons1 = 1'b0;
				is_Mons2 = 1'b1;
			end else begin
				is_Mons1 = 1'b0;
				is_Mons2 = 1'b0;
			end
			m1_idx_x =  DrawX - Monster_X;
			m1_idx_y = DrawY - Monster_Y;
		end 
		if(Monster_X_2 > 10'b0 && (DrawX < Monster_X_2 + monster_width) && (DrawX >= Monster_X_2) 
						  && (DrawY < Monster_Y_2 + monster_height) && (DrawY >= Monster_Y_2))begin 

			if (dungeon_frame1 || dungeon_frame2 || dungeon_frame3) begin
				is_Mons3 = 1'b1;
			end
			m2_idx_x =  DrawX - Monster_X_2;
			m2_idx_y = DrawY - Monster_Y_2;
		end 
		
		if(monster_bullet_X_L > bullet_start && monster_bullet_Y_L > bullet_start && (DrawX < monster_bullet_X_L + bullet_width) && (DrawX >= monster_bullet_X_L) 
						  && (DrawY < monster_bullet_Y_L + bullet_height) && (DrawY >= monster_bullet_Y_L) )begin
			is_bullet_l = 1'b1;
			bl_idx_x = DrawX - monster_bullet_X_L;
			bl_idx_y = DrawY - monster_bullet_Y_L;
		end else begin
			is_bullet_l = 1'b0;
			bl_idx_x = 10'b0;
			bl_idx_y = 10'b0;
		end
		
		if(monster_bullet_X_R > bullet_start && monster_bullet_Y_R > bullet_start && (DrawX < monster_bullet_X_R + bullet_width) && (DrawX >= monster_bullet_X_R) 
						  && (DrawY < monster_bullet_Y_R + bullet_height) && (DrawY >= monster_bullet_Y_R) )begin
			is_bullet_r = 1'b1;
			br_idx_x = DrawX - monster_bullet_X_R;
			br_idx_y = DrawY - monster_bullet_Y_R;
		end else begin
			is_bullet_r = 1'b0;
			br_idx_x = 10'b0;
			br_idx_y = 10'b0;
		end
		if(monster_bullet_X_U > bullet_start && monster_bullet_Y_U > bullet_start && (DrawX < monster_bullet_X_U + bullet_width) && (DrawX >= monster_bullet_X_U) 
						  && (DrawY < monster_bullet_Y_U + bullet_height) && (DrawY >= monster_bullet_Y_U) )begin
			is_bullet_u = 1'b1;
			bu_idx_x = DrawX - monster_bullet_X_U;
			bu_idx_y = DrawY - monster_bullet_Y_U;
		end else begin
			is_bullet_u = 1'b0;
			bu_idx_x = 10'b0;
			bu_idx_y = 10'b0;
		end
		
		if(monster_bullet_X_D > bullet_start && monster_bullet_Y_D > bullet_start && (DrawX < monster_bullet_X_D + bullet_width) && (DrawX >= monster_bullet_X_D) 
						  && (DrawY < monster_bullet_Y_D + bullet_height) && (DrawY >= monster_bullet_Y_D) )begin
			is_bullet_d = 1'b1;
			bd_idx_x = DrawX - monster_bullet_X_D;
			bd_idx_y = DrawY - monster_bullet_Y_D;
		end else begin
			is_bullet_d = 1'b0;
			bd_idx_x = 10'b0;
			bd_idx_y = 10'b0;
		end
		
		if(bullet_X != 1'b0 && bullet_Y != 1'b0 && (DrawX < bullet_X + bullet_width) && (DrawX >= bullet_X) 
						  && (DrawY < bullet_Y + bullet_height) && (DrawY >= bullet_Y) )begin
			is_bullet = 1'b1;
			b_idx_x =  DrawX - bullet_X;
			b_idx_y = DrawY - bullet_Y;
		end else begin
			is_bullet = 1'b0;
			b_idx_x = 10'b0;
			b_idx_y = 10'b0;
		end
	end
	
endmodule

