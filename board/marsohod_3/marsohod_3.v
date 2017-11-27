
module marsohod_3(
      input       CLK100MHZ,
      input       KEY0,
      input       KEY1,
      output      [7:0]  LED,
		output		[12:1] IO

);

    // wires & inputs
    wire          clk;
    wire          clkIn     =  CLK100MHZ;
    wire          rst_n     =  KEY0;
    wire          clkEnable =  ~KEY1;
	wire [ 31:0 ] regData;

    //cores
    sm_top sm_top
    (
        .clkIn      ( clkIn     ),
        .rst_n      ( rst_n     ),
        .clkDevide  ( 4'b1000   ),
        .clkEnable  ( clkEnable ),
        .clk        ( clk       ),
        .regAddr    ( 4'b0010   ),
        .regData    ( regData   )
    );

    //outputs
    assign LED[0]   = clk;
    assign LED[7:1] = regData[6:0];



	 wire [11:0] seven_segments;
    assign IO[12:1] = seven_segments;
    wire [31:0] our_h7segment = 32'b0000_0000_0000_0000_0000_0001_0010_0011;
    sm_hex_display_digit sm_hex_display_digit
    (
        .digit1 (digit1),
        .digit2 (digit2),
        .digit3 (digit3),
        .clkIn  (clkIn),
        .seven_segments (seven_segments)
    );

    wire [6:0] digit3;
    wire [6:0] digit2;
    wire [6:0] digit1;

    sm_hex_display digit_02 (our_h7segment [3:0], digit3 [6:0]);
    sm_hex_display digit_01 (our_h7segment [7:4], digit2 [6:0]);
    sm_hex_display digit_00 (our_h7segment [11:8], digit1 [6:0]);

endmodule


