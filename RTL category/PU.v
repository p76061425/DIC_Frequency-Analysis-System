module PU(X,Y,W_real,W_image,fft_a,fft_b);

input signed[31:0]X,Y;
input signed[19:0]W_real,W_image;
output[31:0]fft_a,fft_b;
reg[31:0] fft_a,fft_b;
reg[31:0]fft_b_Rtemp;
reg[31:0]fft_b_Itemp;
reg signed[15:0]a_c,b_d;

always@(*)begin
    fft_a[31:16] = X[31:16]+Y[31:16];
    fft_a[15:0] =  X[15:0]+Y[15:0];
    
    a_c = X[31:16]-Y[31:16];
    b_d = X[15:0]-Y[15:0];
    
    fft_b_Rtemp = (a_c*W_real) - (b_d*W_image);
    fft_b_Itemp = (a_c*W_image) + (b_d*W_real);
    
    fft_b[31:16] = fft_b_Rtemp[31:16]+fft_b_Rtemp[15];
    fft_b[15:0]  = fft_b_Itemp[31:16]+fft_b_Itemp[15];
 
end

endmodule





