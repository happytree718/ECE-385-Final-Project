module characterPalette
(
	input logic [3:0] data_in,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red = R;
	assign Green = G;
	assign Blue = B;

	always_comb
	begin
		case(data_in)
		4'b0001:
		begin
			R = 8'h02;
			G = 8'h04;
			B = 8'h00;
		end
		4'b0010:
		begin
			R = 8'h2e;
			G = 8'h2e;
			B = 8'h2e;
		end
		4'b0011:
		begin
			R = 8'h41;
			G = 8'h41;
			B = 8'h41;
		end
		4'b0100:
		begin
			R = 8'h44;
			G = 8'h4b;
			B = 8'h3e;
		end
		4'b0101:
		begin
			R = 8'h2f;
			G = 8'h37;
			B = 8'h29;
		end
		4'b0110:
		begin
			R = 8'h43;
			G = 8'h4c;
			B = 8'h3d;
		end
		4'b0111:
		begin
			R = 8'h73;
			G = 8'hf7;
			B = 8'h05;
		end
		4'b1000:
		begin
			R = 8'h60;
			G = 8'h7c;
			B = 8'h8a;
		end
		4'b1001:
		begin
			R = 8'h78;
			G = 8'h90;
			B = 8'h9c;
		end
		4'b1010:
		begin
			R = 8'h90;
			G = 8'ha3;
			B = 8'had;
		end
		default:
		begin
		R = 8'h80;
		G = 8'h00;
		B = 8'h80;
		end
		endcase
	end
endmodule

module keyPalette
(
	input logic [3:0] data_in,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red = R;
	assign Green = G;
	assign Blue = B;

	always_comb
	begin
		case(data_in)
		4'b0001:
		begin
			R = 8'h00;
			G = 8'h00;
			B = 8'h00;
		end
		4'b0010:
		begin
			R = 8'h40;
			G = 8'h40;
			B = 8'h40;
		end
		4'b0011:
		begin
			R = 8'heb;
			G = 8'hc8;
			B = 8'h12;
		end
		4'b0100:
		begin
			R = 8'hff;
			G = 8'hff;
			B = 8'hff;
		end
		4'b0101:
		begin
			R = 8'h3b;
			G = 8'h33;
			B = 8'h04;
		end
		default:
		begin
		R = 8'h80;
		G = 8'h00;
		B = 8'h80;
		end
		endcase
	end
endmodule

module background3Palette
(
	input logic [3:0] data_in,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red = R;
	assign Green = G;
	assign Blue = B;

	always_comb
	begin
		case(data_in)
		4'b0001:
		begin
			R = 8'h00;
			G = 8'h00;
			B = 8'h0e;
		end
		4'b0010:
		begin
			R = 8'h1d;
			G = 8'h00;
			B = 8'h01;
		end
		4'b0011:
		begin
			R = 8'hf1;
			G = 8'hf1;
			B = 8'hf1;
		end
		4'b0100:
		begin
			R = 8'h61;
			G = 8'h62;
			B = 8'h63;
		end
		4'b0101:
		begin
			R = 8'hcb;
			G = 8'h00;
			B = 8'h00;
		end
		4'b0110:
		begin
			R = 8'h35;
			G = 8'h00;
			B = 8'h00;
		end
		default:
		begin
		R = 8'h80;
		G = 8'h00;
		B = 8'h80;
		end
		endcase
	end
endmodule


module monster3Palette
(
	input logic [3:0] data_in,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red = R;
	assign Green = G;
	assign Blue = B;

	always_comb
	begin
		case(data_in)
		4'b0001:
		begin
			R = 8'he9;
			G = 8'hec;
			B = 8'hf2;
		end
		4'b0010:
		begin
			R = 8'h47;
			G = 8'h47;
			B = 8'h47;
		end
		4'b0011:
		begin
			R = 8'h35;
			G = 8'h54;
			B = 8'h76;
		end
		4'b0100:
		begin
			R = 8'hab;
			G = 8'h2b;
			B = 8'h32;
		end
		4'b0101:
		begin
			R = 8'hb3;
			G = 8'h7b;
			B = 8'h7e;
		end
		4'b0110:
		begin
			R = 8'h91;
			G = 8'hb6;
			B = 8'he0;
		end
		default:
		begin
		R = 8'h80;
		G = 8'h00;
		B = 8'h80;
		end
		endcase
	end
endmodule

module backgroundPalette
(
	input logic [3:0] data_in,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red = R;
	assign Green = G;
	assign Blue = B;

	always_comb
		begin	
		case(data_in)
		4'b0001:
		begin
			R = 8'h30;
			G = 8'h30;
			B = 8'h30;
		end
		4'b0010:
		begin
			R = 8'h4b;
			G = 8'h45;
			B = 8'h45;
		end
		4'b0011:
		begin
			R = 8'h5d;
			G = 8'h54;
			B = 8'h54;
		end
		4'b0100:
		begin
			R = 8'h5b;
			G = 8'h57;
			B = 8'h57;
		end
		4'b0101:
		begin
			R = 8'h58;
			G = 8'h50;
			B = 8'h4f;
		end
		4'b0110:
		begin
			R = 8'h82;
			G = 8'h7b;
			B = 8'h7a;
		end
		4'b0111:
		begin
			R = 8'h88;
			G = 8'h81;
			B = 8'h7b;
		end
		4'b1000:
		begin
			R = 8'h56;
			G = 8'h55;
			B = 8'h53;
		end
		4'b1001:
		begin
			R = 8'h37;
			G = 8'h36;
			B = 8'h34;
		end
		4'b1010:
		begin
			R = 8'h30;
			G = 8'h2f;
			B = 8'h2b;
		end
		4'b1011:
		begin
			R = 8'h30;
			G = 8'h2f;
			B = 8'h2b;
		end
		4'b1100:
		begin
			R = 8'h45;
			G = 8'h45;
			B = 8'h42;
		end
		4'b1101:
		begin
			R = 8'h3a;
			G = 8'h36;
			B = 8'h3c;
		end
		4'b1110:
		begin
			R = 8'h51;
			G = 8'h4a;
			B = 8'h4e;
		end
		4'b1111:
		begin
			R = 8'h85;
			G = 8'h7e;
			B = 8'h83;
		end
		default:
		begin
			R = 8'h80;
			G = 8'h00;
			B = 8'h80;
		end
		endcase
	end
endmodule 

module monster1Palette
(
	input logic [3:0] data_in,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red = R;
	assign Green = G;
	assign Blue = B;

	always_comb
	begin
		case(data_in)
		4'b0001:
		begin
			R = 8'h40;
			G = 8'h41;
			B = 8'h49;
		end
		3'b010:
		begin
			R = 8'h68;
			G = 8'hea;
			B = 8'h47;
		end
		3'b0011:
		begin
			R = 8'h44;
			G = 8'h52;
			B = 8'h49;
		end
		3'b0100:
		begin
			R = 8'h72;
			G = 8'h63;
			B = 8'h87;
		end
		3'b0101:
		begin
			R = 8'h36;
			G = 8'h1A;
			B = 8'h4A;
		end
		3'b0110:
		begin
			R = 8'h1C;
			G = 8'h7E;
			B = 8'h10;
		end
		3'b0111:
		begin
			R = 8'h48;
			G = 8'h65;
			B = 8'h49;
		end
		default:
		begin
		R = 8'h80;
		G = 8'h00;
		B = 8'h80;
		end
		endcase
	end
endmodule


module monster2Palette
(
	input logic [3:0] data_in,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red = R;
	assign Green = G;
	assign Blue = B;

	always_comb
	begin
		case(data_in)
		4'b0001:
		begin
			R = 8'h13;
			G = 8'h13;
			B = 8'h13;
		end
		4'b0010:
		begin
			R = 8'h26;
			G = 8'h26;
			B = 8'h26;
		end
		4'b0011:
		begin
			R = 8'h6D;
			G = 8'h6D;
			B = 8'h6D;
		end
		4'b0100:
		begin
			R = 8'h52;
			G = 8'h03;
			B = 8'h03;
		end
		4'b0101:
		begin
			R = 8'h77;
			G = 8'h86;
			B = 8'h85;
		end
		4'b0110:
		begin
			R = 8'hb3;
			G = 8'h8a;
			B = 8'h5e;
		end
		4'b0111:
		begin
			R = 8'h25;
			G = 8'h39;
			B = 8'h23;
		end
		default:
		begin
		R = 8'h80;
		G = 8'h00;
		B = 8'h80;
		end
		endcase
	end
endmodule


module bulletPalette
(
	input logic [3:0] data_in,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red = R;
	assign Green = G;
	assign Blue = B;

	always_comb
	begin
		case(data_in)
		4'b0001:
		begin
			R = 8'h8b;
			G = 8'h0d;
			B = 8'h04;
		end
		4'b0010:
		begin
			R = 8'hc6;
			G = 8'h28;
			B = 8'h17;
		end
		4'b0011:
		begin
			R = 8'hf6;
			G = 8'h80;
			B = 8'h6f;
		end

		default:
		begin
		R = 8'h80;
		G = 8'h00;
		B = 8'h80;
		end
		endcase
	end
endmodule


module initialPalette
(
	input logic [3:0] data_in,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red = R;
	assign Green = G;
	assign Blue = B;

	always_comb
	begin
		case(data_in)
		4'b0001:
		begin
			R = 8'h0e;
			G = 8'h51;
			B = 8'h51;
		end
		4'b0010:
		begin
			R = 8'h00;
			G = 8'hb4;
			B = 8'h95;
		end
		4'b0011:
		begin
			R = 8'h96;
			G = 8'ha4;
			B = 8'ha1;
		end
		4'b0100:
		begin
			R = 8'h04;
			G = 8'h23;
			B = 8'h2d;
		end
		4'b0101:
		begin
			R = 8'h00;
			G = 8'h00;
			B = 8'h00;
		end
		4'b0110:
		begin
			R = 8'h00;
			G = 8'h5c;
			B = 8'h59;
		end
		4'b0111:
		begin
			R = 8'hc2;
			G = 8'h00;
			B = 8'h00;
		end
		default:
		begin
		R = 8'heb;
		G = 8'heb;
		B = 8'hec;
		end
		endcase
	end
endmodule


module background2Palette
(
	input logic [3:0] data_in,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red = R;
	assign Green = G;
	assign Blue = B;

	always_comb
	begin
		case(data_in)
		4'b001:
		begin
			R = 8'h72;
			G = 8'ha9;
			B = 8'h27;
		end
		4'b010:
		begin
			R = 8'h5b;
			G = 8'h90;
			B = 8'h22;
		end
		4'b011:
		begin
			R = 8'h43;
			G = 8'h32;
			B = 8'h09;
		end
		4'b100:
		begin
			R = 8'h88;
			G = 8'h58;
			B = 8'h19;
		end
		4'b101:
		begin
			R = 8'h24;
			G = 8'h10;
			B = 8'h04;
		end
		4'b110:
		begin
			R = 8'h74;
			G = 8'hac;
			B = 8'h35;
		end
		4'b111:
		begin
			R = 8'had;
			G = 8'hc8;
			B = 8'h91;
		end
		
		default:
		begin
		R = 8'h4c;
		G = 8'h1f;
		B = 8'h0a;
		end
		endcase
	end
endmodule


module gameoverPalette
(
	input logic [4:0] data_in,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red = R;
	assign Green = G;
	assign Blue = B;

	always_comb
	begin
		case(data_in)
		4'b0001:
		begin
			R = 8'h59;
			G = 8'h00;
			B = 8'h00;
		end
		4'b0010:
		begin
			R = 8'hbb;
			G = 8'h08;
			B = 8'h08;
		end
		4'b0011:
		begin
			R = 8'hdd;
			G = 8'h84;
			B = 8'h84;
		end
		default:
		begin
		R = 8'he2;
		G = 8'he2;
		B = 8'he2;
		end
		endcase
	end
endmodule


module youwinPalette
(
	input logic [3:0] data_in,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red = R;
	assign Green = G;
	assign Blue = B;

	always_comb
	begin
		case(data_in)
		4'b0001:
		begin
			R = 8'h0e;
			G = 8'h64;
			B = 8'h1f;
		end
		4'b0010:
		begin
			R = 8'he7;
			G = 8'hfa;
			B = 8'h39;
		end
		4'b0011:
		begin
			R = 8'h5c;
			G = 8'h64;
			B = 8'h16;
		end
		default:
		begin
		R = 8'he2;
		G = 8'he2;
		B = 8'he2;
		end
		endcase
	end
endmodule

module heartPalette
(
	input logic [3:0] data_in,
	output logic [7:0] Red, Green, Blue
);

	logic [7:0] R, G, B;

	assign Red = R;
	assign Green = G;
	assign Blue = B;

	always_comb
	begin
		case(data_in)
		4'b0001:
		begin
			R = 8'h9f;
			G = 8'h2d;
			B = 8'h2d;
		end
		4'b0010:
		begin
			R = 8'h00;
			G = 8'h00;
			B = 8'h00;
		end
		4'b0011:
		begin
			R = 8'hff;
			G = 8'h00;
			B = 8'h00;
		end
		4'b0100:
		begin
			R = 8'hff;
			G = 8'hff;
			B = 8'hff;
		end
		default:
		begin
		R = 8'h80;
		G = 8'h00;
		B = 8'h80;
		end
		endcase
	end
endmodule
