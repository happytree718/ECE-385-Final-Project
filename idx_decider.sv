module idx_decider(input logic is_character, is_monster1, is_monster2, is_bullet, is_monster3,
						 input logic is_bullet_l, is_bullet_r, is_bullet_u, is_bullet_d,
						 input logic is_heart, is_key,
						 input logic [9:0] DrawX, DrawY,
						 input logic [9:0] charX, charY,
						 input logic [9:0] m1_idx_x, m1_idx_y, b_idx_x, b_idx_y, m2_idx_x, m2_idx_y,
												 bl_idx_x, bl_idx_y, br_idx_x, br_idx_y, 
												 bu_idx_x, bu_idx_y, bd_idx_x, bd_idx_y, key_idx_x, key_idx_y,
						 output logic [18:0] char_ra, background_ra, monster1_ra, monster2_ra, monster3_ra,
						 output logic [18:0] bullet_ra,
						 output logic [18:0] bullet_l_ra, bullet_r_ra, bullet_u_ra, bullet_d_ra,
						 output logic [18:0] heart_ra, key_ra
						);
	parameter [9:0] char_X_Size = 10'd42;
	parameter [9:0] mon_X_Size = 10'd42;
	parameter [9:0] bul_X_Size = 10'd5;
	parameter [9:0] back_X_Size = 10'd320;
	parameter [9:0] heart_X_Size = 10'd140;
	parameter [9:0] key_X_Size = 10'd60;
	
	always_comb
	begin
		background_ra = (DrawY >> 1)* back_X_Size + (DrawX >> 1);
	   char_ra= 19'b0;
		bullet_ra = 19'b0;
		monster1_ra = 19'b0;
		monster2_ra = 19'b0;
		monster3_ra = 19'b0;
		bullet_l_ra = 19'b0;			
		bullet_r_ra = 19'b0;
		bullet_u_ra = 19'b0;
		bullet_d_ra = 19'b0;
		heart_ra = 19'b0;
		key_ra = 19'b0;
		if(is_key == 1'b1)begin
			key_ra = key_idx_y * key_X_Size + key_idx_x;
		end
		if(is_heart == 1'b1)begin
			heart_ra = DrawY * heart_X_Size + DrawX;
		end
		if(is_character == 1'b1) begin
			char_ra = charY * char_X_Size + charX;
		end
		if (is_monster1 == 1'b1) begin
			monster1_ra = m1_idx_y * mon_X_Size + m1_idx_x;
		end
		if (is_monster2 == 1'b1) begin
			monster2_ra = m1_idx_y * mon_X_Size + m1_idx_x;
		end
		if (is_monster3 == 1'b1) begin
			monster3_ra = m2_idx_y * mon_X_Size + m2_idx_x;
		end
		if (is_bullet == 1'b1) begin
			bullet_ra = b_idx_y * bul_X_Size + b_idx_x;
		end
		if (is_bullet_l == 1'b1) begin
			bullet_l_ra = bl_idx_y * bul_X_Size + bl_idx_x;
		end
		if (is_bullet_r == 1'b1) begin
			bullet_r_ra = br_idx_y * bul_X_Size + br_idx_x;
		end
		if (is_bullet_u == 1'b1) begin
			bullet_u_ra = bu_idx_y * bul_X_Size + bu_idx_x;
		end
		if (is_bullet_d == 1'b1) begin
			bullet_d_ra = bd_idx_y * bul_X_Size + bd_idx_x;
		end
	end
endmodule

