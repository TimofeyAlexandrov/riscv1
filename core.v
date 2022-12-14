module core
(input clk,
 input [31:0] instr_data,
 input [31:0] last_pc,
 
 
 output [31:0] instr_addr

);

reg [31:0]pc = 32'hFFFFFFFF;
wire [31:0]pc_next = (pc == last_pc) ? pc : pc + 1;
wire [31:0]instr = instr_data;
assign instr_addr = pc_next;
always @(posedge clk) begin

	pc<= pc_next;
	$strobe("CPUv1: [%h] %h", pc, instr);
end
wire [4:0]rd = instr[11:7];
wire [4:0]rs1 = instr[19:15];

wire [31:0]alu_result;
wire [31:0]alu_b_src = imm32;

alu alu(.src_a(rf_rdata0),.src_b(alu_b_src),.op(alu_op),.res(alu_result)
);

wire [31:0] rf_rdata0;
wire [4:0] rf_raddr0 = rs1;
wire [31:0]rf_wdata = alu_result;
wire [4:0]rf_waddr = rd;
wire rf_we;
reg_file rf(
.clk(clk),
.raddr0(rf_raddr0),
.rdata0(rf_rdata0),
.raddr1(5'b0),
.waddr(rf_waddr),.wdata(rf_wdata),.we(rf_we)
);

wire [31:0] imm32 = {{20{imm12[11]}},imm12};
wire [11:0]imm12;

control control(
.instr(instr),
.imm12(imm12),
.rf_we(rf_we),
.alu_op(alu_op)
);
 endmodule
 
 