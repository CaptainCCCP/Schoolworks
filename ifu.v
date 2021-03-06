module ifu(nPC_sel,zero,clk,rst,instruction,j_sel,jValue,jrValue,jalsw);
  input clk,rst;
  input [1:0]nPC_sel;
  input [31:0]zero;
  input j_sel;
  input [25:0]jValue;
  input [31:0]jrValue;
  output [31:0]instruction,jalsw;
  
  reg [31:0]pc;
  reg [7:0]im[1023:0];
  reg [31:0]pcnew;
  wire [31:0]temp,t0,t1,t2;
  wire [15:0]imm16;
  reg [31:0]extout;
  
  assign instruction={im[pc[9:0]],im[pc[9:0]+1],im[pc[9:0]+2],im[pc[9:0]+3]};
  
  assign imm16=instruction[15:0];
  
  assign temp={{16{imm16[15]}},imm16};//branch
  
  //j
  always@(*)begin
    if(j_sel==1)begin
      extout={pc[31:28],jValue[25:0],2'b0};
    end
      if(j_sel==0)begin
      extout={temp[31:0]<<2};//{14{imm[15]},imm16}//beq
    end
  end
    //beq ext18(16<<2)    j ext28(address<<2)+[3:0]pc+4
  assign t0=pc+4;
  assign t1=t0+extout;//mux
  assign t2=jrValue;
  assign jalsw=t0;
  always@(*)
  begin
    if(nPC_sel==2'b00)begin
      pcnew=t0;//+4
    end
    else if(nPC_sel==2'b01)begin
      pcnew=t1;//branch
    end
    else if(nPC_sel==2'b11)begin
      pcnew=t2;//jrValue
    end
    else if(nPC_sel==2'b10)begin//beq
      if(zero==0)begin
        pcnew=t1;
      end
    else begin
      pcnew=t0;
    end
    end
  end
  
  //reset
  always@(posedge clk,posedge rst)
  begin
    if(rst) pc=32'h0000_3000;
      else if(j_sel==0)pc=pcnew;
      else if(j_sel==1)pc=extout;
  end
  
endmodule
    