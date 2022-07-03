module ctrl(instruction,RegDst,RegWr,ExtOp,nPC_sel,ALUctr,MemtoReg,MemWr,ALUSrc,j_sel,jal_sel,lb_sel);
  input [31:0]instruction;
  output reg [1:0]ExtOp,nPC_sel;
  output reg[3:0]ALUctr;
  output reg RegDst,RegWr,MemtoReg,MemWr,ALUSrc,j_sel,jal_sel,lb_sel;
  
parameter ADD=4'b0000;
parameter SUB=4'b0001;
parameter OR= 4'b0010;
parameter AND=4'b0011;
parameter SLT=4'b0100;
  
  initial begin
    nPC_sel=0;
    RegDst=0;
    RegWr=0;
    ExtOp=0;
    nPC_sel=0;
    ALUctr=0;
    MemtoReg=0;
    MemWr=0;
    ALUSrc=0;
    j_sel=0;
    jal_sel=0;
    lb_sel=0;
end

always@(*)begin
  //R////////////////////////////////////////
  if(instruction[31:26]==6'b000000)
    begin
      //ADDU
      if(instruction[5:0]==6'b100001)
        begin
          nPC_sel=2'b00;
          RegDst=1'b1;
          RegWr=1'b1;
          ExtOp=2'b00;
          ALUSrc=1'b0;
          ALUctr=ADD;
          MemWr=1'b0;
          MemtoReg=1'b0;
          j_sel=1'b0;
          jal_sel=1'b0;
          lb_sel=1'b0;
      end
      //SUBU
      else if(instruction[5:0]==6'b100011)
        begin
          nPC_sel=2'b00;
          RegDst=1'b1;
          RegWr=1'b1;
          ExtOp=2'b00;
          ALUSrc=1'b0;
          ALUctr=SUB;
          MemWr=1'b0;
          MemtoReg=1'b0;
          j_sel=1'b0;
          jal_sel=1'b0;
          lb_sel=1'b0;
        end
         //SLT
        else if(instruction[5:0]==6'b101010) 
        begin
            nPC_sel=2'b00;
            RegDst=1'b1;
            RegWr=1'b1;
            ExtOp=2'b01;
            ALUSrc=1'b0;
            ALUctr=SLT;
            MemWr=1'b0;
            MemtoReg=1'b0;
            j_sel=1'b0;
            jal_sel=1'b0;
            lb_sel=1'b0;
        end
        //jr
        if(instruction[5:0]==6'b001000)
        begin
          nPC_sel=2'b11;
          RegDst=1'b0;
          RegWr=1'b0;
          ExtOp=2'b00;
          ALUSrc=1'b0;
          ALUctr=4'b0000;
          MemWr=1'b0;
          MemtoReg=1'b0;
          j_sel=1'b0;
          jal_sel=1'b0;
          lb_sel=1'b0;
      end
      end
      //I//////////////////////////////////////////////
      else if(instruction[31:26]==6'b001000) begin
        nPC_sel=2'b00;
        RegDst=1'b0;
        RegWr=1'b1;
        ExtOp=2'b01;
        ALUSrc=1'b1;//Addi
        ALUctr=ADD;
        MemWr=1'b0;
        MemtoReg=1'b0;
        j_sel=1'b0;
        jal_sel=1'b0;
        lb_sel=1'b0;
        end
        //ADDIU
    else if(instruction[31:26]==6'b001001) begin
        nPC_sel=2'b00;
        RegDst=1'b0;
        RegWr=1'b1;
        ExtOp=2'b01;
        ALUSrc=1'b1;
        ALUctr=ADD;
        MemWr=1'b0;
        MemtoReg=1'b0;
        j_sel=1'b0;
        jal_sel=1'b0;
        lb_sel=1'b0;
    end
      //ORI
    else if(instruction[31:26]==6'b001101)
      begin
        nPC_sel=2'b00;
          RegDst=1'b0;
          RegWr=1'b1;
          ExtOp=2'b00;//zero
          ALUSrc=1'b1;
          ALUctr=OR;
          MemWr=1'b0;
          MemtoReg=1'b0;
          j_sel=1'b0;
          jal_sel=1'b0;
          lb_sel=1'b0;
        end
      //LW
    else if(instruction[31:26]==6'b100011)
      begin
        nPC_sel=2'b00;
          RegDst=1'b0;
          RegWr=1'b1;
          ExtOp=2'b01;//
          ALUSrc=1'b1;
          ALUctr=ADD;
          MemWr=1'b0;
          MemtoReg=1'b1;
          j_sel=1'b0;
          jal_sel=1'b0;
          lb_sel=1'b0;
        end
        //LB
        else if(instruction[31:26]==6'b100000)
      begin
        nPC_sel=2'b00;
          RegDst=1'b0;
          RegWr=1'b1;
          ExtOp=2'b01;//signed
          ALUSrc=1'b1;
          ALUctr=ADD;
          MemWr=1'b0;
          MemtoReg=1'b1;
          j_sel=1'b0;
          jal_sel=1'b0;
          lb_sel=1'b1;
        end
        //SW
      else if(instruction[31:26]==6'b101011)
        begin
          nPC_sel=2'b00;
          RegDst=1'b0;
          RegWr=1'b0;
          ExtOp=2'b01;
          ALUSrc=1'b1;
          ALUctr=ADD;
          MemWr=1'b1;
          MemtoReg=1'b0;
          j_sel=1'b0;
          jal_sel=1'b0;
          lb_sel=1'b0;
        end
        //BEQ
      else if(instruction[31:26]==6'b000100)
        begin
          nPC_sel=2'b10;
          RegDst=1'b0;
          RegWr=1'b0;
          ExtOp=2'b01;
          ALUSrc=1'b0;
          ALUctr=SUB;
          MemWr=1'b0;
          MemtoReg=1'b0;
          j_sel=1'b0;
          jal_sel=1'b0;
          lb_sel=1'b0;
        end
        //LUI
      else if(instruction[31:26]==6'b001111)
        begin
          nPC_sel=2'b00;
          RegDst=1'b0;
          RegWr=1'b1;
          ExtOp=2'b10;
          ALUSrc=1'b1;
          ALUctr=OR;
          MemWr=1'b0;
          MemtoReg=1'b0;
          j_sel=1'b0;
          jal_sel=1'b0;
          lb_sel=1'b0;
      end
    //J//////////////////////////////////////////
     else if(instruction[31:26]==6'b000010)
       begin
          nPC_sel=2'b01;
          RegDst=1'b0;
          RegWr=1'b0;
          ExtOp=2'b01;
          ALUSrc=1'b0;
          ALUctr=SUB;
          MemWr=1'b0;
          MemtoReg=1'b1;
          j_sel=1'b1;
          jal_sel=1'b0;
          lb_sel=1'b0;
    end
    //jal
    else if(instruction[31:26]==6'b000011)
       begin
          nPC_sel=2'b01;
          RegDst=1'b0;
          RegWr=1'b1;
          ExtOp=2'b01;
          ALUSrc=1'b0;
          ALUctr=SUB;
          MemWr=1'b0;
          MemtoReg=1'b1;
          j_sel=1'b1;
          jal_sel=1'b1;
          lb_sel=1'b0;
    end
  end
    endmodule