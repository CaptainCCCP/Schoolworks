module system(clk,rst,in);
  input clk,rst;
  input [31:0] in;
  //bridge mips
  wire [31:0]PrAddr,PrRD,PrDOut,PrDIn;
  //timer
  wire [31:0]DEV_WD,TimerO,DEVT_RD,DEVI_RD,DEVO_RD;
  wire IRQ,WeDEVT,Wen;
  wire [31:0]DEV_Addr;
  //
  wire [5:0]HWInt;
  //output32
  wire WeDEVO;
  mips mips(.clk(clk),.rst(rst),.PrAddr(PrAddr),.PrDIn(PrDIn),.PrDOut(PrDOut),.Wen(Wen),.HWInt(HWInt)) ;
  bridge bridge(.PrAddr(PrAddr),.PrDin(PrDIn),.PrDout(PrDOut),.Wen(Wen),.DEVT_RD(DEVT_RD),.DEVI_RD(DEVI_RD),.DEVO_RD(DEVO_RD),
  .IRQ(IRQ),.DEV_Addr(DEV_Addr),.HWInt(HWInt),.DEV_WD(DEV_WD),.WeDEVO(WeDEVO),.WeDEVT(WeDEVT));
  
  input32 input32(.din(in),.dout(DEVI_RD),.DEV_Addr(DEV_Addr[1:0]),.clk(clk),.rst(rst)); 
  output32 output32(.clk(clk),.rst(rst),.WeDEVO(WeDEVO),.DEV_Addr(DEV_Addr[3:2]),.Din(DEV_WD),.Dout(DEVO_RD)); 
  timer timer(.clk_i(clk),.rst_i(rst),.add_i(DEV_Addr[3:2]),.we_i(WeDEVT),.dat_i(DEV_WD),.dat_o(DEVT_RD),.IRQ(IRQ));
endmodule