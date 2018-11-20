
//`include "FFT.v"

module  FAS (data_valid, data, clk, rst, fir_d, fir_valid, fft_valid, done, freq,
 fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7, fft_d8,
 fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15, fft_d0);
input clk, rst;
input data_valid;
input [15:0] data; 

output fir_valid, fft_valid;
output [15:0] fir_d;
output [31:0] fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7, fft_d8;
output [31:0] fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15, fft_d0;
output done;
output [3:0] freq;
`include "./dat/FIR_coefficient.dat"

integer i;
reg [10:0]cnt;
reg signed[15:0]array[0:31];
reg [35:0]fir_out;
reg [15:0]fir_d;
reg fir_valid; 
reg fft_valid;
reg [3:0]freq;
reg done;

always@(posedge clk)begin
    if(rst)
        cnt <= 0;
    else if (cnt>1058)begin
        cnt <= 1058;
    end    
    else begin
        cnt <= cnt+1;
    end
    
end

reg[5:0]cnt2;    
always@(posedge clk)begin
    if(!fir_valid||(cnt == 49&&cnt2 == 16)||(cnt>49&&cnt2 == 15))begin
        cnt2 <=0 ; 
    end
    else begin
        cnt2 <= cnt2+1;
    end
    
end     
   
always@(posedge clk)begin
    if(rst)begin
        for(i=0;i<32;i=i+1)begin
            array[i] <= 0;
        end
    end
    else begin
        array[0] <= data;
        for(i=0;i<31;i=i+1)begin
            array[i+1] <= array[i];
        end
    end
end

always@(negedge clk)begin
        fir_d <= fir_out[31:16]+fir_out[31];
end

always@(posedge clk)begin
    if(cnt > 31)begin
        fir_valid <= 1;
    end
    else begin
        fir_valid <= 0;
    end
end

always@(negedge clk)begin
    if(cnt > 1057)begin
        fft_valid <= 0; 
    end
    else if((cnt== 49 && cnt2 == 16) || (cnt>49 && cnt2 == 15))
        fft_valid <= 1;
    else begin
        fft_valid <= 0; 
    end
    
end

always@(posedge clk)begin
    if(cnt>1057)begin
        done<=1;
    end
end

always@(*)begin
    fir_out = (((array[31]*FIR_C00+array[30]*FIR_C01)+(array[29]*FIR_C02+array[28]*FIR_C03))+
            ((array[27]*FIR_C04+array[26]*FIR_C05)+(array[25]*FIR_C06+array[24]*FIR_C07)))+
            
            (((array[23]*FIR_C08+array[22]*FIR_C09)+(array[21]*FIR_C10+array[20]*FIR_C11))+
            ((array[19]*FIR_C12+array[18]*FIR_C13)+(array[17]*FIR_C14+array[16]*FIR_C15)))+
            
            (((array[15]*FIR_C16+array[14]*FIR_C17)+(array[13]*FIR_C18+array[12]*FIR_C19))+
            ((array[11]*FIR_C20+array[10]*FIR_C21)+(array[9]*FIR_C22+array[8]*FIR_C23)))+
            
            (((array[7]*FIR_C24+array[6]*FIR_C25)+(array[5]*FIR_C26+array[4]*FIR_C27))+
            ((array[3]*FIR_C28+array[2]*FIR_C29)+(array[1]*FIR_C30+array[0]*FIR_C31)))
            ;
end

FFT fft(.fir_d({fir_d,16'b0}),.fir_valid(fir_valid),.clk(clk),.rst(rst),.fft_valid(fft_valid),
.fft_d0(fft_d0), 
.fft_d1(fft_d1),
.fft_d2(fft_d2),
.fft_d3(fft_d3),
.fft_d4(fft_d4),
.fft_d5(fft_d5),
.fft_d6(fft_d6),
.fft_d7(fft_d7),
.fft_d8(fft_d8),
.fft_d9(fft_d9),
.fft_d10(fft_d10),
.fft_d11(fft_d11),
.fft_d12(fft_d12),
.fft_d13(fft_d13),
.fft_d14(fft_d14),
.fft_d15(fft_d15));

always@(*)begin
    freq = 4'bz;
end



endmodule


