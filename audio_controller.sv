module audio_controller(
							input logic Clk, Reset,
							output logic AUD_DACLRCK, AUD_BCLK,
							output logic AUD_DACDAT, AUD_XCK, I2C_SCLK, I2C_SDAT,
//							output logic SRAM_CE_N, SRAM_UB_N, SRAM_LB_N, SRAM_OE_N, SRAM_WE_N,							
//							output logic [19:0] SRAM_ADDR,
//							inout wire [15:0] SRAM_DQ
							output 	logic [22:0]		FL_ADDR,
							inout	 	wire [7:0]			FL_DQ,
							output 	logic 				FL_WE_N, FL_OE_N, FL_CE_N,
							output 	logic 				FL_WP_N
);

assign FL_WE_N = 1'b1;
	assign FL_CE_N = 1'b0;
	assign FL_OE_N = 1'b0;
	assign FL_WP_N = 1'bx;

enum logic [3:0] { IDLE, INI, GET_DATA, DAC } State, Next_state;
logic INIT, INIT_FINISH, data_over, adc_full, AUD_ADCDAT;
logic [31:0] ADCDATA;
logic [7:0] LDATA, RDATA, LDATA_in, RDATA_in, data_out;
logic [22:0] addr_counter;
assign FL_ADDR = addr_counter;
assign Data = FL_DQ;

always_ff @(posedge Clk) begin
	if (Reset)
		State <= IDLE;
	else begin
		State <= Next_state;
		LDATA <= LDATA_in;
		RDATA <= RDATA_in;
	end
end

always_comb begin
	INIT = 1'b0;
	Next_state = State;
	LDATA_in = LDATA;
	RDATA_in = RDATA;
	case(State)
		IDLE: 	Next_state = INI;
		INI: begin 
			if(INIT_FINISH)
				Next_state = GET_DATA;
		end
		GET_DATA: begin
			if(data_over)
				Next_state = DAC;
		end
		DAC: begin
			if(~data_over)
				Next_state = GET_DATA;
		end 
		default:;
	endcase		

	case(State)
		INI: INIT = 1'b1;
		DAC: begin
			LDATA_in = Data;
			RDATA_in = Data; 
		end
		default:;
	endcase
end

always_ff @(posedge data_over) begin
	if(Reset)
		addr_counter <= 23'b0;
	else if(addr_counter == 23'hc2011)
		addr_counter <= 23'b0;
	else
		addr_counter <= addr_counter + 1'b1;
end


//audioRAM ar(.data_In(4'b0), 
//									  .write_address(19'b0), 
//									  .read_address(addr_counter), 
//									  .we(1'b0), .Clk(Clk), .data_Out(data_out));


audio_interface AUDIO(
					.LDATA({LDATA,8'b0}),
					.RDATA({RDATA,8'b0}),
					.clk(Clk),
					.Reset(Reset),
					.INIT(INIT),
					.INIT_FINISH(INIT_FINISH),
					.adc_full(adc_full),
					.data_over(data_over),
					.AUD_MCLK(AUD_XCK),
					.AUD_BCLK(AUD_BCLK),
					.AUD_ADCDAT(AUD_ADCDAT),
					.AUD_DACDAT(AUD_DACDAT),
					.AUD_ADCLRCK(AUD_ADCLRCK),
					.AUD_DACLRCK(AUD_DACLRCK),
					.I2C_SDAT(I2C_SDAT),
					.I2C_SCLK(I2C_SCLK),
					.ADCDATA(ADCDATA)
);

//g00_audio_interface A_I	(	
//		.LDATA(LDATA), 
//		.RDATA(RDATA),
//		.clk(Clk),
//		.rst(Reset),  
//		.INIT,
//		.W_EN,
//		.pulse(data_over),
//		.AUD_MCLK,
//		.AUD_BCLK,
//		.AUD_DACDAT,
//		.AUD_DACLRCK,
//		.I2C_SDAT,
//		.I2C_SCLK
//	);

//	assign SRAM_CE_N = 1'b0;
//	assign SRAM_UB_N = 1'b0;
//	assign SRAM_LB_N = 1'b0;
//	assign SRAM_WE_N = 1'b1;
//	assign SRAM_OE_N = 1'b0;
//	
endmodule
