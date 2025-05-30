`timescale 1ns / 1ps

module tb_new;


    
    logic clk;
    logic reset;
    logic [13:0] data_in;  // 14-bit ADC veri giriþi
    logic [3:0] DA; // LVDS çýkýþlarý
    logic DACLK;
    logic DAFRAME;
//    logic int_clk;

    // **Test edilecek QDR LVDS modülü**
    new_mdl dut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .DA(DA),
        .DACLK(DACLK),
        .DAFRAME(DAFRAME)
    );

    // **Clock üreteci (100MHz)**
    always #5 clk = ~clk; // 10ns period

    // **Test Senaryosu**
    initial begin
        // **Baþlangýç koþullarý**
        clk = 0;
        reset = 1;
        data_in = 14'b00000000000000; // Ýlk veri: 0

        // **Reset sinyali uygula**
        #20 reset = 0;

        // **Farklý ADC giriþ deðerlerini test et**
        
        #5 data_in = 14'b01111111111111; // Pozitif full-scale (OVRA = 0 beklenmeli)
        #80 data_in = 14'b10000000000000; // Negatif full-scale (OVRA = 1 beklenmeli)
        #80 data_in = 14'b01101111000011; // Rastgele bir veri
        #80 data_in = 14'b00001111001011; // Rastgele bir veri
        #80 data_in = 14'b10100010111000; // Rastgele bir veri
        #80 data_in = 14'b11111111111111; // En yüksek deðer (OVRA = 1 olmalý)
        #80 data_in = 14'b00000000000000; // Sýfýr verisi (OVRA = 0 olmalý)

        #100;
        $stop; // Simülasyonu durdur
    end

endmodule
