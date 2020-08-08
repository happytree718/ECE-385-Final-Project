//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  12-08-2017                               --
//    Spring 2018 Distribution                                           --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  character( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
									  soft_reset,
					input logic [15:0] keycode,
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input initial_frame, final_frame, game_over,
               output logic  is_character,             // Whether current pixel belongs to ball or background
					output logic character_frame,
					output logic [9:0] charX, charY,
					output logic [9:0] char_frame_X, char_frame_Y
              );
    
    parameter [9:0] char_X_top = 10'd50;  // Center position on the X axis VGA is 640 * 480
    parameter [9:0] char_Y_top = 10'd50;  // Center position on the Y axis
    parameter [9:0] char_X_Min = 10'd40;       // Leftmost point on the X axis
    parameter [9:0] char_X_Max = 10'd599;     // Rightmost point on the X axis
    parameter [9:0] char_Y_Min = 10'd40;       // Topmost point on the Y axis
    parameter [9:0] char_Y_Max = 10'd439;     // Bottommost point on the Y axis
    parameter [9:0] char_X_Step = 10'd2;    // Step size on the X axis
    parameter [9:0] char_Y_Step = 10'd2;      // Step size on the Y axis
	
	 parameter [9:0] char_X_Size = 10'd42; 
	 parameter [9:0] char_Y_Size = 10'd50; 
    
    logic [9:0] char_X_Pos, char_X_Motion, char_Y_Pos, char_Y_Motion;
    logic [9:0] char_X_Pos_in, char_X_Motion_in, char_Y_Pos_in, char_Y_Motion_in;
    logic char_pic, char_pic_in;
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset || soft_reset)
        begin
            char_X_Pos <= char_X_top;
            char_Y_Pos <= char_Y_top;
            char_X_Motion <= 10'd0;
            char_Y_Motion <= 10'd0;
				char_pic = 1'b0;
        end
        else
        begin
            char_X_Pos <= char_X_Pos_in;
            char_Y_Pos <= char_Y_Pos_in;
            char_X_Motion <= char_X_Motion_in;
            char_Y_Motion <= char_Y_Motion_in;
				char_pic = char_pic_in;
        end
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        char_X_Pos_in = char_X_Pos;
        char_Y_Pos_in = char_Y_Pos;
		  if(keycode == 16'b0)begin
				char_X_Motion_in = 10'd0;
				char_Y_Motion_in = 10'd0;
		  end
		  else begin
				char_X_Motion_in = char_X_Motion;
				char_Y_Motion_in = char_Y_Motion;
		  end
		  char_pic_in = char_pic;
        
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
            // Be careful when using comparators with "logic" datatype because compiler treats 
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
            // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, but rather a large positive number.
				
				if(keycode == 16'h001a) //w
				begin
					char_Y_Motion_in = (~(char_Y_Step) + 1'b1);
					char_X_Motion_in = 10'd0;
				end
				else if(keycode == 16'h0004) //a
				begin
					char_X_Motion_in = (~(char_X_Step) + 1'b1);
					char_Y_Motion_in = 10'd0;
					char_pic_in = 1'b1;
				end
				else if(keycode == 16'h0016) //s
				begin
					char_Y_Motion_in = char_Y_Step;
					char_X_Motion_in = 10'd0;
				end
				else if(keycode == 16'h0007) //d
				begin
					char_X_Motion_in = char_X_Step;
					char_Y_Motion_in = 10'd0;
					char_pic_in = 1'b0;
				end else if(keycode == 16'h1a04 || keycode == 16'h041a) //wa,aw
				begin
					char_X_Motion_in = (~(char_X_Step) + 1'b1);
					char_Y_Motion_in = (~(char_Y_Step) + 1'b1);
					char_pic_in = 1'b1;
				end else if(keycode == 16'h1a07 || keycode == 16'h071a) //wd,dw
				begin
					char_X_Motion_in = char_X_Step;;
					char_Y_Motion_in = (~(char_Y_Step) + 1'b1);
					char_pic_in = 1'b0;
				end else if(keycode == 16'h0416 ||keycode == 16'h1604) //as, sa
				begin
					char_X_Motion_in = (~(char_X_Step) + 1'b1);
					char_Y_Motion_in = char_Y_Step;
					char_pic_in = 1'b1;
				end else if(keycode == 16'h1607 || keycode == 16'h0716) //ds, sd
				begin
					char_X_Motion_in = char_X_Step;
					char_Y_Motion_in = char_Y_Step;
					char_pic_in = 1'b0;
				end
            // Update the ball's position with its motion
				if( char_Y_Pos + char_Y_Size >= char_Y_Max && (keycode[7:0] == 8'h16 || keycode[15:8] == 8'h16))  // Ball is at the bottom edge, BOUNCE!
				begin
                char_Y_Motion_in = 10'd0;
				end
            else if ( char_Y_Pos <= char_Y_Min && (keycode[7:0] == 8'h1a || keycode[15:8] == 8'h1a))  // Ball is at the top edge, BOUNCE!
				begin
                char_Y_Motion_in = 10'd0;
				end
            // TODO: Add other boundary detections and handle keypress here.
        
				if( char_X_Pos + char_X_Size >= char_X_Max && keycode[7:0] == 8'b00000111)  // Ball is at the right edge, BOUNCE!
				begin
                char_X_Motion_in = 10'd0;  // 2's complement.
					 if(char_Y_Pos <= char_Y_Min || char_Y_Pos + char_Y_Size >= char_Y_Max)
							char_Y_Motion_in = 10'd0;
				end
            else if ( char_X_Pos <= char_X_Min && keycode[7:0] == 8'b00000100)  // Ball is at the left edge, BOUNCE!
				begin
                char_X_Motion_in = 10'd0;  // 2's complement.
					 if(char_Y_Pos <= char_Y_Min || char_Y_Pos + char_Y_Size >= char_Y_Max)
							char_Y_Motion_in = 10'd0;
				end
				
				
				
            char_X_Pos_in = char_X_Pos + char_X_Motion;
            char_Y_Pos_in = char_Y_Pos + char_Y_Motion;
        end
        
        /**************************************************************************************
            ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
            Hidden Question #2/2:
               Notice that Ball_Y_Pos is updated using Ball_Y_Motion. 
              Will the new value of Ball_Y_Motion be used when Ball_Y_Pos is updated, or the old? 
              What is the difference between writing
                "Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;" and 
                "Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion_in;"?
              How will this impact behavior of the ball during a bounce, and how might that interact with a response to a keypress?
              Give an answer in your Post-Lab.
        **************************************************************************************/
    end
    
    // Compute whether the pixel corresponds to ball or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, X, Y, X_size, Y_size, X_start, Y_start;
    assign X_start = char_X_Pos;
	 assign Y_start = char_Y_Pos;
    assign DistX = DrawX;
	 assign DistY = DrawY;
	 assign X_size = char_X_Size;
	 assign Y_size = char_Y_Size;
    always_comb begin
		  character_frame = char_pic;
		  char_frame_X = char_X_Pos;
		  char_frame_Y = char_Y_Pos;
        if ( (DistX >= X_start) && (DistX < X_start + X_size) && (DistY >= Y_start) && (DistY < Y_start + Y_size))
		  begin
				charX = DistX - char_X_Pos_in;
				charY = DistY - char_Y_Pos_in;
				if(initial_frame == 0 && final_frame == 0 && game_over == 0)begin
					is_character = 1'b1;
				end else begin
					is_character = 1'b0;
				end
		  end
        else
		  begin
            is_character = 1'b0;
				charX = 10'b0;
				charY = 10'b0;
		  end
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
    
endmodule
