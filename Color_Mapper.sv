//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  Color_mapper (
							  input        is_character, is_monster1, is_monster2, is_bullet,	is_monster3,						  
							  input 			is_bullet_l, is_bullet_r, is_bullet_u, is_bullet_d, is_heart, is_key,
							  input        character_frame,
							  input 	logic dungeon_frame1, dungeon_frame2, dungeon_frame3, initial_frame, final_frame, game_over,
							  input	logic [3:0] idx_char1, idx_char2, idx_back1,
							  input  logic [3:0] idx_back2, idx_back3, idx_mons_1, idx_mons_2, idx_mons_3,
							  input  logic [3:0] idx_back4, idx_back5, idx_back6,
														idx_bul, idx_bul_l, idx_bul_r, idx_bul_u, idx_bul_d,
							  input  logic [3:0] idx_heart,
							  input  logic [3:0] idx_key,
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    logic [7:0] c_Red, c_Green, c_Blue, b_Red, b_Green, b_Blue, Red, Green, Blue;
	 logic [7:0] m1_Red, m1_Green, m1_Blue, m2_Red, m2_Green, m2_Blue, m3_Red, m3_Green, m3_Blue,
					 bu_Red, bu_Green, bu_Blue, bu_l_Red, bu_l_Green, bu_l_Blue,
					 bu_r_Red, bu_r_Green, bu_r_Blue, bu_u_Red, bu_u_Green, bu_u_Blue,
					 bu_d_Red, bu_d_Green, bu_d_Blue, b1_Red, b1_Green, b1_Blue,
					 b2_Red, b2_Green, b2_Blue, b3_Red, b3_Green, b3_Blue, b4_Red, b4_Green, b4_Blue,
					 b5_Red, b5_Green, b5_Blue;
	 logic [3:0] idx_char, idx_back, idx_monster;
	 logic [3:0] idx_bullet, idx_bullet_l, idx_bullet_r, idx_bullet_u, idx_bullet_d;
	 
	 logic [7:0] heart_Red, heart_Green, heart_Blue;
	 logic [7:0] key_Red, key_Green, key_Blue;
	 
	 always_comb
	 begin
		idx_bullet = idx_bul;
		idx_bullet_l = idx_bul_l;
		idx_bullet_r = idx_bul_r;
		idx_bullet_u = idx_bul_u;
		idx_bullet_d = idx_bul_d;
		
		if(character_frame == 1'b0)
			idx_char = idx_char1;
		else
			idx_char = idx_char2;
		
		if(is_heart && (heart_Red != 8'h80 || heart_Green != 8'h00 || heart_Blue != 8'h80))begin
			Red = heart_Red;
			Green = heart_Green;
			Blue = heart_Blue;
		end else if(is_character && (c_Red != 8'h80 || c_Green != 8'h00 || c_Blue != 8'h80)) begin
			Red = c_Red;
			Green = c_Green;
			Blue = c_Blue;
		end else if(is_key && (key_Red != 8'h80 || key_Green != 8'h00 || key_Blue != 8'h80)) begin
			Red = key_Red;
			Green = key_Green;
			Blue = key_Blue;
		end else if(is_monster2 && (m2_Red != 8'h80 || m2_Green != 8'h00 || m2_Blue != 8'h80)) begin
			Red = m2_Red;
			Green = m2_Green;
			Blue = m2_Blue;
		end else if(is_monster1 && (m1_Red != 8'h80 || m1_Green != 8'h00 || m1_Blue != 8'h80)) begin
			Red = m1_Red;
			Green = m1_Green;
			Blue = m1_Blue;
		end else if(is_monster3 && (m3_Red != 8'h80 || m3_Green != 8'h00 || m3_Blue != 8'h80)) begin
			Red = m3_Red;
			Green = m3_Green;
			Blue = m3_Blue;
		end else if(is_bullet && (bu_Red != 8'h80 || bu_Green != 8'h00 || bu_Blue != 8'h80)) begin
			Red = bu_Red;
			Green = bu_Green;
			Blue = bu_Blue;
		end else if(is_bullet_d && (bu_d_Red != 8'h80 || bu_d_Green != 8'h00 || bu_d_Blue != 8'h80)) begin
			Red = bu_d_Red;
			Green = bu_d_Green;
			Blue = bu_d_Blue;
		end else if(is_bullet_u && (bu_u_Red != 8'h80 || bu_u_Green != 8'h00 || bu_u_Blue != 8'h80)) begin
			Red = bu_u_Red;
			Green = bu_u_Green;
			Blue = bu_u_Blue;
		end else if(is_bullet_r && (bu_r_Red != 8'h80 || bu_r_Green != 8'h00 || bu_r_Blue != 8'h80)) begin
			Red = bu_r_Red;
			Green = bu_r_Green;
			Blue = bu_r_Blue;
		end else if(is_bullet_l && (bu_l_Red != 8'h80 || bu_l_Green != 8'h00 || bu_l_Blue != 8'h80)) begin
			Red = bu_l_Red;
			Green = bu_l_Green;
			Blue = bu_l_Blue;
		end else begin
			if(dungeon_frame1) begin
				Red = b_Red;
				Green = b_Green;
				Blue = b_Blue;
			end else if(dungeon_frame2) begin
				Red = b1_Red;
				Green = b1_Green;
				Blue = b1_Blue;
			end else if(dungeon_frame3) begin
				Red = b5_Red;
				Green = b5_Green;
				Blue = b5_Blue;
			end else if(initial_frame) begin
				Red = b2_Red;
				Green = b2_Green;
				Blue = b2_Blue;
			end else if(game_over) begin
				Red = b3_Red;
				Green = b3_Green;
				Blue = b3_Blue;
			end else begin
				Red = b4_Red;
				Green = b4_Green;
				Blue = b4_Blue;
			end
		end
	end
//		if(is_character == 1'b1) begin
//			idx_back = idx_back1;
//			if(character_frame == 1'b0)
//				idx_char = idx_char1;
//			else
//				idx_char = idx_char2;
//			if(c_Red == 8'h80 && c_Green == 8'h00 && c_Blue == 8'h80)begin
//				Red = b_Red;
//				Green = b_Green;
//				Blue = b_Blue;
//			end
//			else begin
//				Red = c_Red;
//				Green = c_Green;
//				Blue = c_Blue;
//			end
//		end
//		else begin
//			idx_back = idx_back1;
//			idx_char = idx_char1;
//			Red = b_Red;
//			Green = b_Green;
//			Blue = b_Blue;
//		end	
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
	 
	 keyPalette keyheartPAL(.data_in(idx_key), .Red(key_Red), .Green(key_Green), .Blue(key_Blue));
	 
    heartPalette heartPAL(.data_in(idx_heart), .Red(heart_Red), .Green(heart_Green), .Blue(heart_Blue));
	 
	 characterPalette charPAL(.data_in(idx_char), .Red(c_Red), .Green(c_Green), .Blue(c_Blue));
	 
	 backgroundPalette back1PAL(.data_in(idx_back1), .Red(b_Red), .Green(b_Green), .Blue(b_Blue));
	 
	 background2Palette back2PAL(.data_in(idx_back2), .Red(b1_Red), .Green(b1_Green), .Blue(b1_Blue));
	 
	 background3Palette back6PAL(.data_in(idx_back6), .Red(b5_Red), .Green(b5_Green), .Blue(b5_Blue));
	 
	 initialPalette back4PAL(.data_in(idx_back3), .Red(b2_Red), .Green(b2_Green), .Blue(b2_Blue));
	 
	 gameoverPalette back5PAL(.data_in(idx_back4), .Red(b3_Red), .Green(b3_Green), .Blue(b3_Blue));
	 
	 youwinPalette back3PAL(.data_in(idx_back5), .Red(b4_Red), .Green(b4_Green), .Blue(b4_Blue));
	 
	 monster1Palette mon1PAL(.data_in(idx_mons_1), .Red(m1_Red), .Green(m1_Green), .Blue(m1_Blue));
	 
	 monster2Palette mon2PAL(.data_in(idx_mons_2), .Red(m2_Red), .Green(m2_Green), .Blue(m2_Blue));
	 
	 monster3Palette mon3PAL(.data_in(idx_mons_3), .Red(m3_Red), .Green(m3_Green), .Blue(m3_Blue));
	 
	 bulletPalette bPAL(.data_in(idx_bullet), .Red(bu_Red), .Green(bu_Green), .Blue(bu_Blue));
	 
	 bulletPalette blPAL(.data_in(idx_bullet_l), .Red(bu_l_Red), .Green(bu_l_Green), .Blue(bu_l_Blue));
	 
	 bulletPalette brPAL(.data_in(idx_bullet_r), .Red(bu_r_Red), .Green(bu_r_Green), .Blue(bu_r_Blue));
	 
	 bulletPalette buPAL(.data_in(idx_bullet_u), .Red(bu_u_Red), .Green(bu_u_Green), .Blue(bu_u_Blue));
	 
	 bulletPalette bdPAL(.data_in(idx_bullet_d), .Red(bu_d_Red), .Green(bu_d_Green), .Blue(bu_d_Blue));
				  
    // Assign color based on is_ball signal
    
endmodule
