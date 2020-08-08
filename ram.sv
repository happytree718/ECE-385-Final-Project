/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

 module  keyRAM
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 400 addresses
logic [3:0] mem [0:2099];

initial
begin
	 $readmemh("sprite_bytes/key.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

 module  monster3RAM
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 400 addresses
logic [3:0] mem [0:2099];

initial
begin
	 $readmemh("sprite_bytes/monster-3.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  background3RAM
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 400 addresses
logic [3:0] mem [0:76799];

initial
begin
	 $readmemh("sprite_bytes/dungeon3.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)  
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule

 
module  characterRAM
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 400 addresses
logic [3:0] mem [0:2099];

initial
begin
	 $readmemh("sprite_bytes/rouge.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule



module  character1RAM
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 400 addresses
logic [3:0] mem [0:2099];

initial
begin
	 $readmemh("sprite_bytes/rouge1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  monster1RAM
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 400 addresses
logic [3:0] mem [0:2099];

initial
begin
	 $readmemh("sprite_bytes/monster1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule


module  monster2RAM
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 400 addresses
logic [3:0] mem [0:2099];

initial
begin
	 $readmemh("sprite_bytes/monster2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule


module bulletRAM
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 400 addresses
logic [3:0] mem [0:24];

initial
begin
	 $readmemh("sprite_bytes/bullet.txt", mem);
end

always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module  background1RAM
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 400 addresses
logic [3:0] mem [0:76799];

initial
begin
	 $readmemh("sprite_bytes/dungeon.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)  
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule

module  background2RAM
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 400 addresses
logic [3:0] mem [0:76799];

initial
begin
	 $readmemh("sprite_bytes/dungeon2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)  
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule 

module  initialRAM
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 400 addresses
logic [3:0] mem [0:76799];

initial
begin
	 $readmemh("sprite_bytes/initial.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)  
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule

module failRAM
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 400 addresses
logic [3:0] mem [0:76799];

initial
begin
	 $readmemh("sprite_bytes/game-over.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)  
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule

module succRAM
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 400 addresses
logic [3:0] mem [0:76799];

initial
begin
	 $readmemh("sprite_bytes/you-win.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)  
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule

module heartRAM
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 4 bits and a total of 400 addresses
logic [3:0] mem [0:2799];

initial
begin
	 $readmemh("sprite_bytes/multiheart.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)  
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end
endmodule


