module partial_top_level(
                        input logic Clk, Reset, frame_clk,
                        input logic [15:0] keycode,
                        input logic [9:0]     Char_X, Char_Y,
                        output logic [9:0]	Monster_X, Monster_Y,
								output logic [9:0]	Monster_X_2, Monster_Y_2,
 								output logic [9:0]	monster_bullet_X_L, monster_bullet_Y_L, 
															monster_bullet_X_R, monster_bullet_Y_R, 
															monster_bullet_X_U, monster_bullet_Y_U,
															monster_bullet_X_D, monster_bullet_Y_D,
                        output logic [9:0]   bullet_X, bullet_Y,
								output logic [2:0]   Health,
								output logic dungeon_frame1, dungeon_frame2, dungeon_frame3, 
								output logic initial_frame, final_frame, game_over, 
								output logic soft_reset, active_key
);

logic finish_1, finish_2, finish_3, Die, die_1, die_2, die_3;
logic hit1, hit2, hit3;
logic active_1, active_2,active_3, active_4, active_5, active_6, active_7;
logic [2:0] hit_count1, hitcount_2, hit_count3;
logic [2:0] health, health_in;

logic [9:0] Monster_X_1, Monster_Y_1, monster_bullet_X_L_1, monster_bullet_Y_L_1, 
            monster_bullet_X_R_1, monster_bullet_Y_R_1, monster_bullet_X_U_1, monster_bullet_Y_U_1,
				monster_bullet_X_D_1, monster_bullet_Y_D_1, bullet_X_1, bullet_Y_1,
            Monster_X__2, Monster_Y__2, monster_bullet_X_L_2, monster_bullet_Y_L_2, 
            monster_bullet_X_R_2, monster_bullet_Y_R_2, monster_bullet_X_U_2, monster_bullet_Y_U_2,
				monster_bullet_X_D_2, monster_bullet_Y_D_2, bullet_X_2, bullet_Y_2,
				Monster_X_3, Monster_Y_3, monster_bullet_X_L_3, monster_bullet_Y_L_3, 
            monster_bullet_X_R_3, monster_bullet_Y_R_3, monster_bullet_X_U_3, monster_bullet_Y_U_3,
				monster_bullet_X_D_3, monster_bullet_Y_D_3, bullet_X_3, bullet_Y_3;
logic [9:0] Monster_X_1_2, Monster_Y_1_2, Monster_X_2_2, Monster_Y_2_2, Monster_X_3_2, Monster_Y_3_2;
assign dungeon_frame1 = active_1 || active_4;
assign dungeon_frame2 = active_2 || active_5;
assign dungeon_frame3 = active_3 || active_6;
assign Health = health;

always_ff @(posedge Clk) begin
    if(Reset)
        health <= 3'b111;
    else
        health <= health_in;
end

always_comb begin
	 health_in = health;
	 Die = 1'b0;
    if(active_1 == 1'b1) begin
        Monster_X = Monster_X_1; 
        Monster_Y = Monster_Y_1;
		  if(hit1)
			health_in = health - 1'b1;
		  Monster_X_2 = Monster_X_1_2;
		  Monster_Y_2 = Monster_Y_1_2;
        monster_bullet_X_L = monster_bullet_X_L_1;
        monster_bullet_Y_L = monster_bullet_Y_L_1; 
		  monster_bullet_X_R = monster_bullet_X_R_1;
        monster_bullet_Y_R = monster_bullet_Y_R_1;
	     monster_bullet_X_U = monster_bullet_X_U_1; 
        monster_bullet_Y_U = monster_bullet_Y_U_1;
		  monster_bullet_X_D = monster_bullet_X_D_1; 
        monster_bullet_Y_D = monster_bullet_Y_D_1;
        bullet_X = bullet_X_1; 
        bullet_Y = bullet_Y_1;
    end
    else if (active_2 == 1'b1) begin
		  
        Monster_X = Monster_X__2; 
        Monster_Y = Monster_Y__2;
		  if(hit2)
			health_in = health - 1'b1;
		  Monster_X_2 = Monster_X_2_2;
		  Monster_Y_2 = Monster_Y_2_2;
		  
        monster_bullet_X_L = monster_bullet_X_L_2;
        monster_bullet_Y_L = monster_bullet_Y_L_2; 
		  monster_bullet_X_R = monster_bullet_X_R_2;
        monster_bullet_Y_R = monster_bullet_Y_R_2;
	     monster_bullet_X_U = monster_bullet_X_U_2; 
        monster_bullet_Y_U = monster_bullet_Y_U_2;
		  monster_bullet_X_D = monster_bullet_X_D_2; 
        monster_bullet_Y_D = monster_bullet_Y_D_2;
        bullet_X = bullet_X_2; 
        bullet_Y = bullet_Y_2;
    end else if (active_3 == 1'b1) begin
		  Monster_X = Monster_X_3; 
        Monster_Y = Monster_Y_3;
		  Monster_X_2 = Monster_X_3_2;
		  Monster_Y_2 = Monster_Y_3_2;		
		  if(hit3)
			health_in = health - 1'b1;
        monster_bullet_X_L = monster_bullet_X_L_3;
        monster_bullet_Y_L = monster_bullet_Y_L_3; 
		  monster_bullet_X_R = monster_bullet_X_R_3;
        monster_bullet_Y_R = monster_bullet_Y_R_3;
	     monster_bullet_X_U = monster_bullet_X_U_3; 
        monster_bullet_Y_U = monster_bullet_Y_U_3;
		  monster_bullet_X_D = monster_bullet_X_D_3; 
        monster_bullet_Y_D = monster_bullet_Y_D_3;
        bullet_X = bullet_X_3; 
        bullet_Y = bullet_Y_3;
    end else if(active_4 || active_5 || active_6 || active_7)begin
		  Monster_X = 10'b0; 
        Monster_Y = 10'b0;
		  Monster_X_2 = 10'b0;
		  Monster_Y_2 = 10'b0;
        monster_bullet_X_L = 10'b0;
        monster_bullet_Y_L = 10'b0; 
		  monster_bullet_X_R = 10'b0;
        monster_bullet_Y_R = 10'b0;
	     monster_bullet_X_U = 10'b0; 
        monster_bullet_Y_U = 10'b0;
		  monster_bullet_X_D = 10'b0; 
        monster_bullet_Y_D = 10'b0;
        bullet_X = 10'b0; 
        bullet_Y = 10'b0;
	 end else begin
        Monster_X = 10'b0; 
        Monster_Y = 10'b0;
		  Monster_X_2 = 10'b0;
		  Monster_Y_2 = 10'b0;
		  health_in = 3'b111;
        monster_bullet_X_L = 10'b0;
        monster_bullet_Y_L = 10'b0; 
		  monster_bullet_X_R = 10'b0;
        monster_bullet_Y_R = 10'b0;
	     monster_bullet_X_U = 10'b0; 
        monster_bullet_Y_U = 10'b0;
		  monster_bullet_X_D = 10'b0; 
        monster_bullet_Y_D = 10'b0;
        bullet_X = 10'b0; 
        bullet_Y = 10'b0;
    end
	 if(health == 3'b0)
		Die = 1'b1;
end


master_state_controller MSC(.*);

level level_1(
            .Reset(~active_1),
            .finish(finish_1),
				.hited(hit1),
            .Monster_X(Monster_X_1),
            .Monster_Y(Monster_Y_1),
				.Monster_X_2(Monster_X_1_2),
				.Monster_Y_2(Monster_Y_1_2),
				.monster_bullet_X_L(monster_bullet_X_L_1), 
            .monster_bullet_Y_L(monster_bullet_Y_L_1), 
				.monster_bullet_X_R(monster_bullet_X_R_1), 
            .monster_bullet_Y_R(monster_bullet_Y_R_1), 
				.monster_bullet_X_U(monster_bullet_X_U_1), 
            .monster_bullet_Y_U(monster_bullet_Y_U_1),
				.monster_bullet_X_D(monster_bullet_X_D_1), 
            .monster_bullet_Y_D(monster_bullet_Y_D_1),
            .bullet_X(bullet_X_1), 
            .bullet_Y(bullet_Y_1),
            .*
);

level level_2(
            .Reset(~active_2),
            .finish(finish_2),
				.hited(hit2),
            .Monster_X(Monster_X__2),
            .Monster_Y(Monster_Y__2),
				.Monster_X_2(Monster_X_2_2),
				.Monster_Y_2(Monster_Y_2_2),
				.monster_bullet_X_L(monster_bullet_X_L_2), 
            .monster_bullet_Y_L(monster_bullet_Y_L_2), 
				.monster_bullet_X_R(monster_bullet_X_R_2), 
            .monster_bullet_Y_R(monster_bullet_Y_R_2), 
				.monster_bullet_X_U(monster_bullet_X_U_2), 
            .monster_bullet_Y_U(monster_bullet_Y_U_2),
				.monster_bullet_X_D(monster_bullet_X_D_2), 
            .monster_bullet_Y_D(monster_bullet_Y_D_2),
            .bullet_X(bullet_X_2), 
            .bullet_Y(bullet_Y_2),
            .*
);

level level_3(
            .Reset(~active_3),
            .finish(finish_3),
				.hited(hit3),
            .Monster_X(Monster_X_3),
            .Monster_Y(Monster_Y_3),
				.Monster_X_2(Monster_X_3_2),
				.Monster_Y_2(Monster_Y_3_2),
				.monster_bullet_X_L(monster_bullet_X_L_3), 
            .monster_bullet_Y_L(monster_bullet_Y_L_3), 
				.monster_bullet_X_R(monster_bullet_X_R_3), 
            .monster_bullet_Y_R(monster_bullet_Y_R_3), 
				.monster_bullet_X_U(monster_bullet_X_U_3), 
            .monster_bullet_Y_U(monster_bullet_Y_U_3),
				.monster_bullet_X_D(monster_bullet_X_D_3), 
            .monster_bullet_Y_D(monster_bullet_Y_D_3),
            .bullet_X(bullet_X_3), 
            .bullet_Y(bullet_Y_3),
            .*
);

endmodule