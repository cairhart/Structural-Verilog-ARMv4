// This is the top module for the ARMv4 processor

`include "32_bit_tsb.v"
`include "addr_mode_1.v"
`include "alu.v"
`include "basic_ram.v"
`include "decodeFamilies.v"
`include "multiply_unit.v"
`include "reg_bank_encap.v"
`include "state_machine.v"


module ARMv4(
	
	
);



/**************************************************
 ********         Top Level Registers   ***********
 **************************************************/
reg [31:0] mrdr,mwdr; // Memory Read and Memory Write registers
reg [31:0] ir; // Instruction register



/**************************************************
 ********         Control Signals       ***********
 **************************************************/
wire [63:0] control_signals; // Left generic to ease modificaiton. 
// Check the state machine spreadsheet to see descriptions of control signals



/**************************************************
 ********         Decode Signals       ***********
 **************************************************/
wire [15:0] decoder_output; // See decodeFamilies.v for description of this signal
	

/**************************************************
 ********         Inter-connection      ***********
 **************************************************/
 // The following signals are misc. interconntections between modules.
 // These signals aren't part of the main signal or bus set.
wire [31:0] mul_out;                                // ouput from the multiply unit
wire [31:0] am1_to_alu;                             // bus from addr1 module to ALU
wire        am1_carry_in, am1_carry_out;            // addr1 carry in and out
wire [3:0]  reg_counter_to_rb;                      // register counter to register bank
wire [31:0] pc;                                     // Program counter output from the register bank (i.e. R15)
wire [31:0] st;                                     
wire        cond;                                   // COND signal based on condition codes



/**************************************************
 ********         Busses                ***********
 **************************************************/
wire [31:0] a_bus, b_bus, c_bus;
wire [31:0] alu_bus;
wire [31:0] alu_bus_hi_UNUSED; // High 32 bits padding for the unused portion of the ALU output




/**************************************************
 ********         Tri-state buffers     ***********
 **************************************************/

// Naming convention: <gate_signal_name>_B


tsb_32_bit GATE_MUL_B ( 
    .in(mul_out),
    .gate(control_signals[44]),
    .out(b_bus)
);

/**************************************************
 ********         Top Level Modules     ***********
 **************************************************/
AddrMode1 ADDR_MODE_1(
	.IR(ir),
	.Rs_LSB(c_bus[7:0]),
	.Rm_data(b_bus),
    .is_DPI(decoder_output[0]),       // data processing immediate
    .is_DPIS(decoder_output[1]),      // data processing immediate shift
    .is_DPRS(decoder_output[2]),      // data processing register shift
    .is_LSIO(decoder_output[8]),      // load/store immediate offset
    .is_LSHSBCO(decoder_output[10]),   // load/store halfword/signed byte combined offset
    .is_LSHSBSO(decoder_output[11]),   // load/store halfword/signed byte shifted offset
    .is_BL(decoder_output[14]),        // branch/branch and link
    .is_pass_thru(control_signals[43]), // pass all 32 IR bits through
    .C(am1_carry_in),

    .shifter_operand(am1_to_alu),
    .shifter_carry(am1_carry_out)

);

alu ALU(
    .A(a_bus),
    .B(am1_to_alu),
    .ALU_Sel(ir[24:21]),
    .ALU_Out({alu_bus_hi_UNUSED, alu_bus} ),
    .NZCV() // TODO

);

ram_sp_sr_sw BASIC_RAM(

);

decodeFamily DECODE_FAMILY(
	.ir(ir),
	.f(decoder_output)
);

mul MUL(
	.B_In(b_bus),
	.C(c_bus),
	.MUL_HiLo(control_signals[45]),
	.LD_MUL(control_signals[46]),
	.U( ir[22]),
	.B_Out(mul_out)
);

RegBankEncapsulation REG_BANK_ENCAP(
	.clk(),     // TODO
	.LATCH_REG(control_signals[52]),
	.IR_RD_MUX(control_signals[42]),
	.LSM_RD_MUX(control_signals[41]),
	.RD_MUX(control_signals[51]),
	.PC_MUX(control_signals[50]),
	.DATA_MUX(control_signals[49]),
	.REG_GATE_B(control_signals[48]),
	.REG_GATE_C(control_signals[47]),
	.IR(ir), 
	.ALU_BUS(alu_bus),
	.REG_COUNTER(reg_counter_to_rb),    // TODO  will probably remove this signal
	.A_BUS(a_bus),
	.B_BUS(b_bus),
	.C_BUS(c_bus),
	.ST(st), 
	.PC(pc)

);

StateMachine STATE_MACHINE(
	.clk(),		// TODO 
	.rst(),		// TODO 
	.family_bits(decoder_output),
	.COND(cond),
	.L(ir[20]),
	.P(ir[24]),
	.A(ir[21]),
	.CS_BITS(control_signals)
);

endmodule
