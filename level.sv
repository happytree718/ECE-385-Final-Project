module level(
            input logic          Clk, Reset, frame_clk,
            input logic [9:0]    Char_X, Char_Y,
            input logic [15:0]   keycode,
            output logic         finish,
				output logic 			hited,
            output logic [9:0]	Monster_X, Monster_Y,
				output logic [9:0]   Monster_X_2, Monster_Y_2,
				output logic [9:0]	monster_bullet_X_L, monster_bullet_Y_L, 
											monster_bullet_X_R, monster_bullet_Y_R, 
											monster_bullet_X_U, monster_bullet_Y_U,
											monster_bullet_X_D, monster_bullet_Y_D,
            output logic [9:0]   bullet_X, bullet_Y
);

logic hit_by_bullet, hit_by_monster, hit_by_bullet_2, hit_by_monster_2;
assign hited = hit_by_monster| hit_by_monster_2;

always_comb begin
    finish = 1'b0;
    if((Monster_X == 10'b0) && (Monster_Y == 10'b0) && (Monster_X_2 == 10'b0) && (Monster_Y_2 == 10'b0))
        finish = 1'b1;
end

monster monster_1 (
                .hit(hit_by_bullet),
                .hit_char(hit_by_monster),
                .*
);

monster2 monster_2 (.hit(hit_by_bullet_2),
						  .hit_char(hit_by_monster_2),
						  .*);

bullet bullet_1(
                .hit(hit_by_bullet),
					 .hit2(hit_by_bullet_2),
					 .Monster2_X(Monster_X_2),
					 .Monster2_Y(Monster_Y_2),
                .*
);


endmodule
