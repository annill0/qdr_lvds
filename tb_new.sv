`timescale 1ns / 1ps

module tb_new;


    
    logic clk;
    logic reset;
    logic [13:0] data_in;  
    logic [3:0] DA; 
    logic DACLKM;
    logic DAFRAMEM;
    logic DACLKP;
    logic DAFRAMEP;


  
    new_mdl dut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .DA(DA),
        .DACLKM(DACLKM),
        .DAFRAMEM(DAFRAMEM),
        .DACLKP(DACLKP),
        .DAFRAMEP(DAFRAMEP)
    );

 
    always #5 clk = ~clk;


    initial begin

        clk = 0;
        reset = 1;
        data_in = 14'b00000000000000;

      
        #20 reset = 0;

    
        
        #5 data_in = 14'b01111111111111; 
        #80 data_in = 14'b10000000000000; 
        #80 data_in = 14'b01101111000011; 
        #80 data_in = 14'b00001111001011; 
        #80 data_in = 14'b10100010111000; 
        #80 data_in = 14'b11111111111111; 
        #80 data_in = 14'b00000000000000; 

        #100;
        $stop; 
    end

endmodule
