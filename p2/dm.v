module dm(Data_in,MemWr,Addr,clk,rst,Data_out,lb_sel,sb_sel);
  input [31:0]Data_in,Addr;
  input clk,rst,MemWr,lb_sel,sb_sel;
  output reg[31:0]Data_out;
  
  reg [7:0]DataMem[1023:0];
  wire [9:0]pointer;
  assign pointer=Addr[9:0];
  //reset
  integer i;
  always@(negedge rst)begin
    for(i=0;i<1024;i=i+1)
    DataMem[i]=0;
  end
  
  
  always@(posedge clk)begin
    //store word
    if(MemWr==1)begin
      if(sb_sel==1)begin
              DataMem[pointer+0]<=Data_in[7:0];
             end
    else if(sb_sel==0)begin
      DataMem[pointer+3]<=Data_in[31:24];
      DataMem[pointer+2]<=Data_in[23:16];
      DataMem[pointer+1]<=Data_in[15:8];
      DataMem[pointer+0]<=Data_in[7:0];
    end
  end
  end
  
  always@(negedge clk)begin
    //load word
  if(MemWr==0)begin
    if(lb_sel==1) begin
        if(DataMem[pointer][7]==0)begin
            Data_out<={24'b0,DataMem[pointer]};
          end
        else if(DataMem[pointer][7]==1)begin
           Data_out<={24'b111111111111111111111111,DataMem[pointer]};
        end
      end
    else if(lb_sel==0)begin
    Data_out<={DataMem[pointer+3],DataMem[pointer+2],DataMem[pointer+1],DataMem[pointer]};
    end
  end
end
endmodule
    
    
  
