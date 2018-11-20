`include "PU.v"

module FFT(fir_d,fir_valid,clk,rst,fft_valid,
fft_d0, 
fft_d1,
fft_d2,
fft_d3,
fft_d4,
fft_d5,
fft_d6,
fft_d7,
fft_d8,
fft_d9,
fft_d10,
fft_d11,
fft_d12,
fft_d13,
fft_d14,
fft_d15);       

input[31:0] fir_d;
input rst,fir_valid,fft_valid,clk;
output[31:0] fft_d0,fft_d1,fft_d2,fft_d3,fft_d4,fft_d5,fft_d6,
            fft_d7,
            fft_d8,
            fft_d9,
            fft_d10,
            fft_d11,
            fft_d12,
            fft_d13,
            fft_d14,
            fft_d15;

reg[31:0] fft_d0, 
        fft_d1,
        fft_d2,
        fft_d3,
        fft_d4,
        fft_d5,
        fft_d6,
        fft_d7,
        fft_d8,
        fft_d9,
        fft_d10,
        fft_d11,
        fft_d12,
        fft_d13,
        fft_d14,
        fft_d15;
       
reg[31:0]data_file[0:15];       
wire [31:0]file_out_1[0:15];
wire [31:0]file_out_2[0:15];
wire [31:0]file_out_3[0:15];
wire [31:0]file_out_4[0:15];
integer i;
parameter signed[39:0] W0 = {20'h10000,20'h00000};
parameter signed[39:0] W1 = {20'h0EC83,20'hF9E09};
parameter signed[39:0] W2 = {20'h0B504,20'hF4AFC};
parameter signed[39:0] W3 = {20'h061F7,20'hF137D};
parameter signed[39:0] W4 = {20'h00000,20'hF0000};
parameter signed[39:0] W5 = {20'hF9E09,20'hF137D};
parameter signed[39:0] W6 = {20'hF4AFC,20'hF4AFC};
parameter signed[39:0] W7 = {20'hF137D,20'hF9E09};

always@(posedge clk)begin
    if(rst)begin
        for(i = 0;i<16;i = i +1)begin
            data_file[i]<= 0;
        end
    end
    else begin
        data_file[15]<=fir_d;
        for(i = 1;i<16;i = i +1)begin
            data_file[i-1]<= data_file[i];
        end
    end
end

PU pu1_1(.X(data_file[0]), .Y(data_file[8]), .W_real(W0[39:20]),.W_image(W0[19:0]),.fft_a(file_out_1[0]),.fft_b(file_out_1[8]));
PU pu1_2(.X(data_file[1]), .Y(data_file[9]), .W_real(W1[39:20]),.W_image(W1[19:0]),.fft_a(file_out_1[1]),.fft_b(file_out_1[9]));       
PU pu1_3(.X(data_file[2]), .Y(data_file[10]),.W_real(W2[39:20]),.W_image(W2[19:0]),.fft_a(file_out_1[2]),.fft_b(file_out_1[10]));
PU pu1_4(.X(data_file[3]), .Y(data_file[11]),.W_real(W3[39:20]),.W_image(W3[19:0]),.fft_a(file_out_1[3]),.fft_b(file_out_1[11]));
PU pu1_5(.X(data_file[4]), .Y(data_file[12]),.W_real(W4[39:20]),.W_image(W4[19:0]),.fft_a(file_out_1[4]),.fft_b(file_out_1[12]));
PU pu1_6(.X(data_file[5]), .Y(data_file[13]),.W_real(W5[39:20]),.W_image(W5[19:0]),.fft_a(file_out_1[5]),.fft_b(file_out_1[13]));       
PU pu1_7(.X(data_file[6]), .Y(data_file[14]),.W_real(W6[39:20]),.W_image(W6[19:0]),.fft_a(file_out_1[6]),.fft_b(file_out_1[14]));
PU pu1_8(.X(data_file[7]), .Y(data_file[15]),.W_real(W7[39:20]),.W_image(W7[19:0]),.fft_a(file_out_1[7]),.fft_b(file_out_1[15]));     

PU pu2_1(.X(file_out_1[0]), .Y(file_out_1[4]), .W_real(W0[39:20]),.W_image(W0[19:0]),.fft_a(file_out_2[0]), .fft_b(file_out_2[4]));
PU pu2_2(.X(file_out_1[1]), .Y(file_out_1[5]), .W_real(W2[39:20]),.W_image(W2[19:0]),.fft_a(file_out_2[1]), .fft_b(file_out_2[5]));       
PU pu2_3(.X(file_out_1[2]), .Y(file_out_1[6]), .W_real(W4[39:20]),.W_image(W4[19:0]),.fft_a(file_out_2[2]), .fft_b(file_out_2[6]));
PU pu2_4(.X(file_out_1[3]), .Y(file_out_1[7]), .W_real(W6[39:20]),.W_image(W6[19:0]),.fft_a(file_out_2[3]), .fft_b(file_out_2[7]));
PU pu2_5(.X(file_out_1[8]), .Y(file_out_1[12]),.W_real(W0[39:20]),.W_image(W0[19:0]),.fft_a(file_out_2[8]), .fft_b(file_out_2[12]));
PU pu2_6(.X(file_out_1[9]), .Y(file_out_1[13]),.W_real(W2[39:20]),.W_image(W2[19:0]),.fft_a(file_out_2[9]), .fft_b(file_out_2[13]));       
PU pu2_7(.X(file_out_1[10]),.Y(file_out_1[14]),.W_real(W4[39:20]),.W_image(W4[19:0]),.fft_a(file_out_2[10]),.fft_b(file_out_2[14]));
PU pu2_8(.X(file_out_1[11]),.Y(file_out_1[15]),.W_real(W6[39:20]),.W_image(W6[19:0]),.fft_a(file_out_2[11]),.fft_b(file_out_2[15]));  

PU pu3_1(.X(file_out_2[0]), .Y(file_out_2[2]), .W_real(W0[39:20]),.W_image(W0[19:0]),.fft_a(file_out_3[0]), .fft_b(file_out_3[2]));
PU pu3_2(.X(file_out_2[1]), .Y(file_out_2[3]), .W_real(W4[39:20]),.W_image(W4[19:0]),.fft_a(file_out_3[1]), .fft_b(file_out_3[3]));       
PU pu3_3(.X(file_out_2[4]), .Y(file_out_2[6]), .W_real(W0[39:20]),.W_image(W0[19:0]),.fft_a(file_out_3[4]), .fft_b(file_out_3[6]));
PU pu3_4(.X(file_out_2[5]), .Y(file_out_2[7]), .W_real(W4[39:20]),.W_image(W4[19:0]),.fft_a(file_out_3[5]), .fft_b(file_out_3[7]));
PU pu3_5(.X(file_out_2[8]), .Y(file_out_2[10]),.W_real(W0[39:20]),.W_image(W0[19:0]),.fft_a(file_out_3[8]), .fft_b(file_out_3[10]));
PU pu3_6(.X(file_out_2[9]), .Y(file_out_2[11]),.W_real(W4[39:20]),.W_image(W4[19:0]),.fft_a(file_out_3[9]), .fft_b(file_out_3[11]));       
PU pu3_7(.X(file_out_2[12]),.Y(file_out_2[14]),.W_real(W0[39:20]),.W_image(W0[19:0]),.fft_a(file_out_3[12]),.fft_b(file_out_3[14]));
PU pu3_8(.X(file_out_2[13]),.Y(file_out_2[15]),.W_real(W4[39:20]),.W_image(W4[19:0]),.fft_a(file_out_3[13]),.fft_b(file_out_3[15]));  

PU pu4_1(.X(file_out_3[0]), .Y(file_out_3[1]), .W_real(W0[39:20]),.W_image(W0[19:0]),.fft_a(file_out_4[0]), .fft_b(file_out_4[1]));
PU pu4_2(.X(file_out_3[2]), .Y(file_out_3[3]), .W_real(W0[39:20]),.W_image(W0[19:0]),.fft_a(file_out_4[2]), .fft_b(file_out_4[3]));       
PU pu4_3(.X(file_out_3[4]), .Y(file_out_3[5]), .W_real(W0[39:20]),.W_image(W0[19:0]),.fft_a(file_out_4[4]), .fft_b(file_out_4[5]));
PU pu4_4(.X(file_out_3[6]), .Y(file_out_3[7]), .W_real(W0[39:20]),.W_image(W0[19:0]),.fft_a(file_out_4[6]), .fft_b(file_out_4[7]));
PU pu4_5(.X(file_out_3[8]), .Y(file_out_3[9]), .W_real(W0[39:20]),.W_image(W0[19:0]),.fft_a(file_out_4[8]), .fft_b(file_out_4[9]));
PU pu4_6(.X(file_out_3[10]),.Y(file_out_3[11]),.W_real(W0[39:20]),.W_image(W0[19:0]),.fft_a(file_out_4[10]),.fft_b(file_out_4[11]));       
PU pu4_7(.X(file_out_3[12]),.Y(file_out_3[13]),.W_real(W0[39:20]),.W_image(W0[19:0]),.fft_a(file_out_4[12]),.fft_b(file_out_4[13]));
PU pu4_8(.X(file_out_3[14]),.Y(file_out_3[15]),.W_real(W0[39:20]),.W_image(W0[19:0]),.fft_a(file_out_4[14]),.fft_b(file_out_4[15]));     

always@(*)begin
    fft_d0  = file_out_4[0];
    fft_d8  = file_out_4[1];
    fft_d4  = file_out_4[2];
    fft_d12 = file_out_4[3];
    fft_d2  = file_out_4[4];
    fft_d10 = file_out_4[5];
    fft_d6  = file_out_4[6];
    fft_d14 = file_out_4[7];
    fft_d1  = file_out_4[8];
    fft_d9  = file_out_4[9];
    fft_d5  = file_out_4[10];
    fft_d13 = file_out_4[11];
    fft_d3  = file_out_4[12];
    fft_d11 = file_out_4[13];
    fft_d7  = file_out_4[14];
    fft_d15 = file_out_4[15];
    
end
       
endmodule
       