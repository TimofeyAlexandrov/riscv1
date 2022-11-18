module rom #(parameter ADDR_WIDTH = 32,parameter WIDTH = 32)(
    input [ADDR_WIDTH-1:0]addr,
    input clk,
    output reg [WIDTH - 1:0]q
);

reg [WIDTH - 1:0]mem[0:ADDR_WIDTH-1];

initial begin
    $readmemh("G:/addi.txt", mem);
end

always @(posedge clk) begin
    q <= mem[addr];
end

endmodule
