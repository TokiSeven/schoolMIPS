
module marsohod_3(
      input       CLK100MHZ,
      input       KEY0,
      input       KEY1,
      output      [7:0]  LED

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



    assign IO[12:1] = seven_segments;
    wire [31:0] our_h7segment = 32'b0000_0000_0000_0000_0000_0001_0010_0011;
    wire [11:0] seven_segments;
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

    sm_hex_display digit_00 (our_h7segment [3:0], digit3 [6:0])
    sm_hex_display digit_00 (our_h7segment [7:4], digit2 [6:0])
    sm_hex_display digit_00 (our_h7segment [11:8], digit1 [6:0])

endmodule

module sm_hex_display
(
    input      [3:0] digit,
    output reg [6:0] seven_segments
);

    always @*
        case (digit)
        'h0: seven_segments = 'b1000000;  // a b c d e f g
        'h1: seven_segments = 'b1111001;
        'h2: seven_segments = 'b0100100;  //   --a--
        'h3: seven_segments = 'b0110000;  //  |     |
        'h4: seven_segments = 'b0011001;  //  f     b
        'h5: seven_segments = 'b0010010;  //  |     |
        'h6: seven_segments = 'b0000010;  //   --g--
        'h7: seven_segments = 'b1111000;  //  |     |
        'h8: seven_segments = 'b0000000;  //  e     c
        'h9: seven_segments = 'b0011000;  //  |     |
        'ha: seven_segments = 'b0001000;  //   --d-- 
        'hb: seven_segments = 'b0000011;
        'hc: seven_segments = 'b1000110;
        'hd: seven_segments = 'b0100001;
        'he: seven_segments = 'b0000110;
        'hf: seven_segments = 'b0001110;
        endcase

endmodule


module sm_hex_display_digit
(
    input   [6:0] digit1,
    input   [6:0] digit2,
    input   [6:0] digit3,
    input         clkIn,
    output reg [11:0] seven_segments
);
    reg [9:0] count = 10'b0000000000;
    always @(posedge clkIn)
    begin
        case (count[9:8])
        2'b00 : seven_segments = {1'b0, digit1[0], digit1[5], 2'b11, digit1[1], 
                1'b1, digit1[6], digit1[2], 1'b0, digit1[3], digit1[4]};
        2'b01 : seven_segments = {1'b1, digit2[0], digit2[5], 2'b01, digit2[1], 
                1'b1, digit2[6], digit2[2], 1'b0, digit2[3], digit2[4]};
        2'b10 : seven_segments = {1'b1, digit3[0], digit3[5], 2'b10, digit3[1], 
                1'b1, digit3[6], digit3[2], 1'b0, digit3[3], digit3[4]};
        default : count <= count + 1'b0;
        endcase
        count <= count + 1'b1;
    end
endmodule
