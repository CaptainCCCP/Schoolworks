module mips(clk,rst);
  input clk,rst;
  wire [1:0]ExtOp,nPC_sel;
  wire [3:0]ALUctr;
  wire ALUSrc,MemWr,MemtoReg,RegDst,RegWr,j_sel,jal_sel,jr_sel,lb_sel;
  wire [31:0]instruction;
  
  ctrl CU(.instruction(instruction),.RegDst(RegDst),.RegWr(RegWr),.ExtOp(ExtOp),.nPC_sel(nPC_sel),.ALUctr(ALUctr),.MemtoReg(MemtoReg),.MemWr(MemWr),.ALUSrc(ALUSrc),.j_sel(j_sel),.jal_sel(jal_sel),.lb_sel(lb_sel));
  mips_dp MAIN(.clk(clk),.rst(rst),.RegDst(RegDst),.RegWr(RegWr),.ExtOp(ExtOp),.nPC_sel(nPC_sel),.ALUctr(ALUctr),.MemtoReg(MemtoReg),.MemWr(MemWr),.ALUSrc(ALUSrc),.j_sel(j_sel),.Instruction(instruction),.jal_sel(jal_sel),.lb_sel(lb_sel));
endmodule
  
