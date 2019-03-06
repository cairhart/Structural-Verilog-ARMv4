`include "decodeFamilies.v"

/* Decode Families Key:
 * Index  Testcase Formula                        Description
 * f[0]   32'bxxxx 001x xxxx xxxx xxxx xxxx xxxx xxxx  Data Processing Immediate 
 * f[1]   32'bxxxx 000x xxxx xxxx xxxx xxxx xxx0 xxxx  Data Processing Immediate Shift 
 * f[2]   32'bxxxx 000x xxxx xxxx xxxx xxxx 0xx1 xxxx  Data Processing Register Shift
 * f[3]   32'bxxxx 0000 00xx xxxx xxxx xxxx 1001 xxxx  Multiply
 * f[4]   32'bxxxx 0000 1xxx xxxx xxxx xxxx 1001 xxxx  Multiply Long
 * f[5]   32'bxxxx 0001 0x00 xxxx xxxx xxxx xxxx xxxx  Move from Status Register
 * f[6]   32'bxxxx 0011 0x10 xxxx xxxx xxxx xxxx xxxx  Move Immediate to Status Register
 * f[7]   32'bxxxx 0001 0x10 xxxx xxxx xxxx xxx0 xxxx  Move Register to Status Register
 * f[8]   32'bxxxx 010x xxxx xxxx xxxx xxxx xxxx xxxx  Load/Store Immediate Offset
 * f[9]   32'bxxxx 011x xxxx xxxx xxxx xxxx xxx0 xxxx  Load/Store Register Offset
 * f[10]  32'bxxxx 000x x1xx xxxx xxxx xxxx 1xx1 xxxx  Load/Store Halfword/Signed Byte Combined Offset
 * f[11]  32'bxxxx 000x x0xx xxxx xxxx xxxx 1xx1 xxxx  Load/Store Halfword/Signed Byte Shifted Offset
 *                                           `->note f[11][6] & f[11][5] CANNOT both be 0 at the same time   
 * f[12]  32'bxxxx 0001 0x00 xxxx xxxx xxxx 1001 xxxx  Swap/Swap Byte
 * f[13]  32'bxxxx 100x xxxx xxxx xxxx xxxx xxxx xxxx  Load/Store Multiple
 * f[14]  32'bxxxx 101x xxxx xxxx xxxx xxxx xxxx xxxx  Branch and Branch with Link
 * f[15]  32'bxxxx 011x xxxx xxxx xxxx xxxx xxx1 xxxx  Undefined Instruction
 */

module testDecodeFamilies;
reg [31:0] ir;
wire [15:0] f;

decodeFamily moduleA (ir, f);

initial begin
    $display("<< Starting the Testbench >>");
    ir = 32'h00000000;
    $display("@%3d START ir set to    : %h", $time, ir);
    #5
    $display("@%3d START resulted in f: %8h\n", $time, f);
   
    $display("<< Testing all testing formulas with x = 0 >>");
    /* testing these testcases:
    f0  32'b0000 0010 0000 0000 0000 0000 0000 0000
    f1  32'b0000 0000 0000 0000 0000 0000 0000 0000
    f2  32'b0000 0000 0000 0000 0000 0000 0001 0000
    f3  32'b0000 0000 0000 0000 0000 0000 1001 0000
    f4  32'b0000 0000 1000 0000 0000 0000 1001 0000
    f5  32'b0000 0001 0000 0000 0000 0000 0000 0000
    f6  32'b0000 0011 0010 0000 0000 0000 0000 0000
    f7  32'b0000 0001 0010 0000 0000 0000 0000 0000
    f8  32'b0000 0100 0000 0000 0000 0000 0000 0000
    f9  32'b0000 0110 0000 0000 0000 0000 0000 0000
    f10 32'b0000 0000 0100 0000 0000 0000 1001 0000
    f11 32'b0000 0000 0000 0000 0000 0000 1101 0000
    f12 32'b0000 0001 0000 0000 0000 0000 1001 0000
    f13 32'b0000 1000 0000 0000 0000 0000 0000 0000
    f14 32'b0000 1010 0000 0000 0000 0000 0000 0000
    f15 32'b0000 0110 0000 0000 0000 0000 0001 0000 */

    #10
    ir = 32'b00000010000000000000000000000000;  // f[0]   Data Processing Immediate 
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b00000000000000000000000000000000;  // f[1]   Data Processing Immediate Shift 
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b00000000000000000000000000010000;  // f[2]   Data Processing Register Shift
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b00000000000000000000000010010000;  // f[3]   Multiply
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b00000000100000000000000010010000;  // f[4]   Multiply Long
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b00000001000000000000000000000000;  // f[5]   Move from Status Register
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b00000011001000000000000000000000;  // f[6]   Move Immediate to Status Register
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b00000001001000000000000000000000;  // f[7]   Move Register to Status Register
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b00000100000000000000000000000000;  // f[8]   Load/Store Immediate Offset
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b00000110000000000000000000000000;  // f[9]   Load/Store Register Offset
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b00000000010000000000000010010000;  // f[10]  Load/Store Halfword/Signed Byte Combined Offset
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b00000000000000000000000011010000;  // f[11]  Load/Store Halfword/Signed Byte Shifted Offset
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b00000001000000000000000010010000;  // f[12]  Swap/Swap Byte
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b00001000000000000000000000000000;  // f[13]  Load/Store Multiple
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);

    ir = 32'b00001010000000000000000000000000;  // f[14]  Branch and Branch with Link
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b00000110000000000000000000010000;  // f[15]  Undefined Instruction
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);

    $display("<< Testing all testing formulas with x = 1 >>");
    /* testing these testcases:
    32'b1111 0011 1111 1111 1111 1111 1111 1111  f0   Data Processing Immediate 
    32'b1111 0001 1111 1111 1111 1111 1110 1111  f1   Data Processing Immediate Shift 
    32'b1111 0001 1111 1111 1111 1111 0111 1111  f2   Data Processing Register Shift
    32'b1111 0000 0011 1111 1111 1111 1001 1111  f3   Multiply
    32'b1111 0000 1111 1111 1111 1111 1001 1111  f4   Multiply Long
    32'b1111 0001 0100 1111 1111 1111 1111 1111  f5   Move from Status Register
    32'b1111 0011 0110 1111 1111 1111 1111 1111  f6   Move Immediate to Status Register
    32'b1111 0001 0110 1111 1111 1111 1110 1111  f7   Move Register to Status Register
    32'b1111 0101 1111 1111 1111 1111 1111 1111  f8   Load/Store Immediate Offset
    32'b1111 0111 1111 1111 1111 1111 1110 1111  f9   Load/Store Register Offset
    32'b1111 0001 1111 1111 1111 1111 1111 1111  f10  Load/Store Halfword/Signed Byte Combined Offset
    32'b1111 0001 1011 1111 1111 1111 1111 1111  f11  Load/Store Halfword/Signed Byte Shifted Offset
    32'b1111 0001 0100 1111 1111 1111 1001 1111  f12  Swap/Swap Byte
    32'b1111 1001 1111 1111 1111 1111 1111 1111  f13  Load/Store Multiple
    32'b1111 1011 1111 1111 1111 1111 1111 1111  f14  Branch and Branch with Link
    32'b1111 0111 1111 1111 1111 1111 1111 1111  f15  Undefined Instruction
    */

    
    ir = 32'b11110011111111111111111111111111;  // f0   Data Processing Immediate 
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b11110001111111111111111111101111;  // f1   Data Processing Immediate Shift 
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b11110001111111111111111101111111;  // f2   Data Processing Register Shift
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b11110000001111111111111110011111;  // f3   Multiply
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b11110000111111111111111110011111;  // f4   Multiply Long
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b11110001010011111111111111111111;  // f5   Move from Status Register
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b11110011011011111111111111111111;  // f6   Move Immediate to Status Register
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b11110001011011111111111111101111;  // f7   Move Register to Status Register
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b11110101111111111111111111111111;  // f8   Load/Store Immediate Offset
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b11110111111111111111111111101111;  // f9   Load/Store Register Offset
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b11110001111111111111111111111111;  // f10  Load/Store Halfword/Signed Byte Combined Offset
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b11110001101111111111111111111111;  // f11  Load/Store Halfword/Signed Byte Shifted Offset
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b11110001010011111111111110011111;  // f12  Swap/Swap Byte
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b11111001111111111111111111111111;  // f13  Load/Store Multiple
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b11111011111111111111111111111111;  // f14  Branch and Branch with Link
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
    ir = 32'b11110111111111111111111111111111;  // f15  Undefined Instruction
    $write("@%3d ir set to: %h -> ", $time, ir);
    #10
    $display("@%3d f: %4h", $time, f);
    
end

endmodule
