module control
( input [31:0] instr,

 output reg [11:0] imm12,
 output reg rf_we,
 output reg alu_op


);

wire [6:0] opcode = instr[6:0];
wire [2:0] funct3 = instr[14:12];

always @(*) begin

rf_we = 1'b0;
alu_op = 1'b0;
imm12 = 12'b0;

casez ({funct3,opcode})

	10'b000_0010011: begin
			rf_we = 1'b1;
			alu_op = 1'b1;
			imm12 = instr[31:20];
		end
	default: ;
	endcase
end
endmodule

