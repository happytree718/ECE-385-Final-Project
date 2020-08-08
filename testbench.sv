module testbench();

timeunit 10ns;

timeprecision 1ns;

logic Clk;

logic Reset, hit;

logic [7:0] keycode;

logic [9:0] Char_X, Char_Y, Monster_X, Monster_Y, bullet_X, bullet_Y;


bullet B1(.*);
	

always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

initial begin: TEST_VECTORS
Reset = 1'b0;		//reset is inactive
Char_X = 10'd170;
Char_Y = 10'd170;
Monster_X = 10'd170;
Monster_Y = 10'd60;




#2 Reset = 1;//trigger Reset
#2 Reset = 0;
#2 keycode = 8'h52;//triger Run


#30 keycode = 8'h50;

end
endmodule
