module frame_buffer(input [4:0] data_In,
						  input [18:0] write_address, read_address,
						  input we, Clk,
						  output logic [4:0] data_Out,
 
						  input [9:0] charX, charY, monster1X, monster1Y,
									     bulletX, bulletY,
										  bullet_l_X, bullet_l_Y,
										  bullet_r_X, bullet_r_Y,
										  bullet_u_X, bullet_u_Y,
										  bullet_d_X, bullet_d_Y
						 );
endmodule
