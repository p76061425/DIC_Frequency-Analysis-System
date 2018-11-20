
# Frequency Analysis System

## Introduction
&ensp;&ensp;&ensp;&ensp;近來加速度感測器被廣泛地被應用在 3C 產品、通訊設備、車輛安全、醫療電子、工業監控…等方面，其中以加速度感測器的應用更為常見；加速度感測器可提供加速度、速度及位移的資訊，可以進行時域（time domain）、頻域（frequency domain）資料的分析，依據其提供的資料可分析、檢測出機械設備的軸承的平衡、故障…等問題，用以預防機械設備的嚴重損壞及提高產品的可靠度及安全性。本運算分析電路是一個應用在感測系統中，判斷儀器、設備運作震動訊號的運算分析電路。系統前端將會讀取感測電路所傳出的重力加速度值，由此重力加速度值所產生的時域訊號，經過濾波器（Filter），鎖定儀器、設備的震動頻率範圍，並將環境所產生的雜訊及高頻訊號過濾，並由 FFT（快速傅利葉轉換）電路，將時域訊號轉換為頻域訊號，最後分析頻率資訊，找出主要頻段，請完成一有限脈衝響應濾波器（Finite Impulse Response Filter，FIR Filter）、一快速傅利葉轉換( FFT：Fast Fourier transform)及一頻譜分析電路（Analysis）。本系統有 4 只信號輸入（clk, rst, data, data_valid）、21 只信號輸出（fir_d, fir_valid,fft_d0~fft_d15 , fft_valid, done, freq），如圖一所示。</br>

![](https://i.imgur.com/i1E7t4e.png)

