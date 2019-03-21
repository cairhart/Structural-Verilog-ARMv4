


module mar(
	input LATCH_MAR,
	input MARMUX1,
	input MARMUX2,
	input [31:0] PC,
	input [31:0] ALU_bus,
	output [31:0] address
);

reg [31:0] address;
wire incr;


always @(posedge LATCH_MAR) begin
    address = (MARMUX2) ? ALU_bus : (MARMUX1) ? PC : address + 1;
end


endmodule
