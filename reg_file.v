module reg_file
(
input  clk,
input  [4:0] raddr0,raddr1,waddr,
input  [31:0] wdata,
input  we,
output  [31:0] rdata0,rdata1

);

reg [31:0] rf[31:0];

genvar i;
generate
for (i = 0; i < 32; i = i + 1)
begin : reg_init
    initial
        rf[i] = 32'b0; /* Set initial value of x[i] to 0 */
end
endgenerate

always @(posedge clk)
	if(we) rf[waddr]<=wdata;
	
assign rdata0 = (raddr0!=0)?rf[raddr0]:0;
assign rdata1 = (raddr1!=0)?rf[raddr1]:0;

endmodule

