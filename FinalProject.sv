//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Modified by Po-Han Huang                                         --
//      10/06/2017                                                       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module FinalProject( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1, HEX2, HEX3,
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input               OTG_INT,      //CY7C67200 Interrupt
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK,      //SDRAM Clock
				 // Audio Interface
				 input logic AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK,
				 output logic AUD_DACDAT, AUD_XCK, I2C_SCLK, I2C_SDAT,
							
				 // SDRAM
//				 output logic SRAM_CE_N, SRAM_UB_N, SRAM_LB_N, SRAM_OE_N, SRAM_WE_N,
//                      output logic [19:0] SRAM_ADDR,
//                      inout wire [15:0] SRAM_DQ
				 // Flash
				 output 	logic [22:0]		FL_ADDR,
							inout	 	wire [7:0]			FL_DQ,
							output 	logic 				FL_WE_N, FL_OE_N, FL_CE_N,
							output 	logic 				FL_WP_N
                    );
    
    logic Reset_h, Clk;
    logic [15:0] keycode;
    
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end
    
    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs, hpi_reset;
    
    // Interface between NIOS II and EZ-OTG chip
    hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            .from_sw_reset(hpi_reset),
                            // signals connected to EZ-OTG chip
                            .OTG_DATA(OTG_DATA),    
                            .OTG_ADDR(OTG_ADDR),    
                            .OTG_RD_N(OTG_RD_N),    
                            .OTG_WR_N(OTG_WR_N),    
                            .OTG_CS_N(OTG_CS_N),
                            .OTG_RST_N(OTG_RST_N)
    );
     
     // You need to make sure that the port names here match the ports in Qsys-generated codes.
     final_project_soc nios_system(
                             .clk_clk(Clk),         
                             .reset_reset_n(1'b1),    // Never reset NIOS
                             .sdram_wire_addr(DRAM_ADDR), 
                             .sdram_wire_ba(DRAM_BA),   
                             .sdram_wire_cas_n(DRAM_CAS_N),
                             .sdram_wire_cke(DRAM_CKE),  
                             .sdram_wire_cs_n(DRAM_CS_N), 
                             .sdram_wire_dq(DRAM_DQ),   
                             .sdram_wire_dqm(DRAM_DQM),  
                             .sdram_wire_ras_n(DRAM_RAS_N),
                             .sdram_wire_we_n(DRAM_WE_N), 
                             .sdram_clk_clk(DRAM_CLK),
                             .keycode_export(keycode),  
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w),
                             .otg_hpi_reset_export(hpi_reset)
    );
	 
	 logic [9:0] DrawX, DrawY;
	 logic is_character, character_frame;
	 
	 logic [2:0] Health;
	 logic is_heart;
	 logic [18:0] heart_ra;
	 logic [3:0] idx_heart;
	 
	 logic active_key;
	 logic is_key;
	 logic [9:0] key_idx_x, key_idx_y;
	 logic [18:0] key_ra;
	 logic [3:0] idx_key;
	 
	 logic is_monster1, is_monster2, is_bullet;
	 logic is_bullet_l, is_bullet_r, is_bullet_u, is_bullet_d;
	 
	 logic [9:0] charX, charY, Monster_X, Monster_Y, bullet_X, bullet_Y, Monster_X_2, Monster_Y_2;
	 logic is_monster3;
	 logic [9:0] m2_idx_x, m2_idx_y;
	 logic [18:0] monster3_ra;
	 logic [3:0] idx_mons_3;
	 
	 
	 logic [9:0] char_frame_X, char_frame_Y;
	 
	 logic [9:0] monster_bullet_X_L, monster_bullet_Y_L,
					 monster_bullet_X_R, monster_bullet_Y_R,
					 monster_bullet_X_U, monster_bullet_Y_U,
					 monster_bullet_X_D, monster_bullet_Y_D;
	 
	 logic [18:0] char_ra, background_ra, monster1_ra, monster2_ra, bullet_ra,
					  bullet_l_ra, bullet_r_ra, bullet_u_ra, bullet_d_ra;
	 
	 logic [3:0] idx_char1, idx_char2, idx_back1;
	 logic [3:0] idx_bul, idx_bul_l, idx_bul_r, idx_bul_u, idx_bul_d, idx_back4, idx_back5;
	 logic [3:0] idx_mons_1, idx_mons_2, idx_back3, idx_back2, idx_back6; //
	 
	 logic dungeon_frame1, dungeon_frame2, dungeon_frame3, initial_frame, final_frame, game_over, soft_reset;
	 
	 logic [9:0] m1_idx_x, m1_idx_y, b_idx_x, b_idx_y, 
					 bl_idx_x, bl_idx_y, br_idx_x, br_idx_y, 
				    bu_idx_x, bu_idx_y, bd_idx_x, bd_idx_y;
	 
    // Use PLL to generate the 25MHZ VGA_CLK.
    // You will have to generate it on your own in simulation.
    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));
    
    // TODO: Fill in the connections for the rest of the modules
	 
	 audio_controller audio_controller_instance(.Clk(Clk), 
																.Reset(Reset_h),
																.AUD_DACLRCK(AUD_DACLRCK), 
//																.AUD_ADCLRCK(AUD_ADCLRCK), 
																.AUD_BCLK(AUD_BCLK),
																.AUD_DACDAT(AUD_DACDAT), 
																.AUD_XCK(AUD_XCK), 
																.I2C_SCLK(I2C_SCLK), 
																.I2C_SDAT(I2C_SDAT)
																);
	 
	 partial_top_level ptl_instance(.Clk(Clk), .Reset(Reset_h), .frame_clk(VGA_VS), 
											  .keycode(keycode),
											  .Char_X(char_frame_X), .Char_Y(char_frame_Y), .*);
	 
    VGA_controller vga_controller_instance(.Clk(Clk), .Reset(Reset_h), .*);
	 
	 character character_instance(.Clk(Clk), .Reset(Reset_h), .frame_clk(VGA_VS), .*);
	 
	 BM_decider BM_ins(.*);
	 
	 idx_decider idx_des_ins(.*);
	 
	 Color_mapper color_instance(.*);
	 
	 characterRAM charRAM0_in(.data_In(4'b0), 
									  .write_address(19'b0), 
									  .read_address(char_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_char1));
	 character1RAM charRAM1_in(.data_In(4'b0), 
									  .write_address(19'b0), 
									  .read_address(char_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_char2));
	 background1RAM backRAM0_in(.data_In(4'b0), 
									  .write_address(19'b0), 
									  .read_address(background_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_back1));
	 background2RAM backRAM1_in(.data_In(3'b0), 
									  .write_address(19'b0), 
									  .read_address(background_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_back2));
	 background3RAM backRAM5_in(.data_In(3'b0), 
									  .write_address(19'b0), 
									  .read_address(background_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_back6));
	 initialRAM backRAM2_in(.data_In(4'b0), 
									  .write_address(19'b0), 
									  .read_address(background_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_back3));
	 failRAM backRAM3_in(.data_In(2'b0), 
									  .write_address(19'b0), 
									  .read_address(background_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_back4));
	 succRAM backRAM4_in(.data_In(2'b0), 
									  .write_address(19'b0), 
									  .read_address(background_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_back5));				  
	 monster1RAM m1ram_in(.data_In(3'b0), 
									  .write_address(19'b0), 
									  .read_address(monster1_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_mons_1));
	 monster2RAM m2ram_in(.data_In(3'b0), 
									  .write_address(19'b0), 
									  .read_address(monster2_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_mons_2));
	 monster3RAM m3ram_in(.data_In(3'b0), 
									  .write_address(19'b0), 
									  .read_address(monster3_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_mons_3));						  
									  
	 bulletRAM b_ram_in(.data_In(2'b0), 
									  .write_address(19'b0), 
									  .read_address(bullet_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_bul));
	 bulletRAM bl_ram_in(.data_In(2'b0), 
									  .write_address(19'b0), 
									  .read_address(bullet_l_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_bul_l));
	 bulletRAM br_ram_in(.data_In(2'b0), 
									  .write_address(19'b0), 
									  .read_address(bullet_r_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_bul_r));
	 bulletRAM bu_ram_in(.data_In(2'b0), 
									  .write_address(19'b0), 
									  .read_address(bullet_u_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_bul_u));
	 bulletRAM bd_ram_in(.data_In(2'b0), 
									  .write_address(19'b0), 
									  .read_address(bullet_d_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_bul_d));
	 heartRAM ht_ram_in(.data_In(2'b0), 
									  .write_address(19'b0), 
									  .read_address(heart_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_heart));
    		
    keyRAM key_ram_in(.data_In(2'b0), 
									  .write_address(19'b0), 
									  .read_address(key_ra), 
									  .we(1'b0), .Clk(Clk), .data_Out(idx_key));
    // Display keycode on hex display
    HexDriver hex_inst_0 (keycode[3:0], HEX0);
    HexDriver hex_inst_1 (keycode[7:4], HEX1);
	 HexDriver hex_inst_2 (keycode[11:8], HEX2);
    HexDriver hex_inst_3 (keycode[15:12], HEX3);
    
    /**************************************************************************************
        ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
        Hidden Question #1/2:
        What are the advantages and/or disadvantages of using a USB interface over PS/2 interface to
             connect to the keyboard? List any two.  Give an answer in your Post-Lab.
    **************************************************************************************/
endmodule
