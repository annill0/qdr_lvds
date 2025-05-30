module new_mdl (
    input  logic        clk,            
    input  logic        reset,         
    input  logic [13:0] data_in,        
    output logic [3:0]  DA,             
    output logic        DAFRAME,        
    output logic        DACLK
);


logic [1:0] count;
logic int_clk;
    
initial int_clk=0;

always @(posedge clk) begin
    int_clk <= ~int_clk;
end

//always_ff @(posedge int_clk or posedge reset) begin
//    if (reset) 
//        count <= 2'b00;
//    else if (count == 2'b11)
//        count <= 2'b00;
//    else 
//        count <= count + 1; 
//end 



always_ff @(posedge int_clk or posedge reset) begin
    if (reset) begin
        DA <= 4'b0;
        DAFRAME <= 1'b0;
        count <= 2'b00;
    end
//    else if (count == 2'b11) count <= 2'b00;
    else begin
      
        case(count)
            2'b00: begin
                DA <= data_in[13:10]; 
                DAFRAME <= 1'b1;      
                count <= count + 1;
            end
            2'b01: begin
                DA <= data_in[9:6]; 
                DAFRAME <= 1'b1;
                count <= count + 1;
            end
            2'b10: begin
                DA <= data_in[5:2]; 
                DAFRAME <= 1'b0;
                count <= count + 1;
            end
            2'b11: begin
                DA <= {data_in[1:0], 2'b00}; 
                DAFRAME <= 1'b0;
                count <= count + 1;
            end
        endcase
    end
end
always_ff @(negedge int_clk) begin
    if (reset) begin
        DA <= 4'b0;
        DAFRAME <= 1'b0;
        count <= 2'b00;
    end
//    else if (count == 2'b11) count <= 2'b00;
    else begin
      
        case(count)
            2'b00: begin
                DA <= data_in[13:10]; 
                DAFRAME <= 1'b1;      
                count <= count + 1;
            end
            2'b01: begin
                DA <= data_in[9:6]; 
                DAFRAME <= 1'b1;
                count <= count + 1;
            end
            2'b10: begin
                DA <= data_in[5:2]; 
                DAFRAME <= 1'b0;
                count <= count + 1;
            end
            2'b11: begin
                DA <= {data_in[1:0], 2'b00}; 
                DAFRAME <= 1'b0;
                count <= count + 1;
            end
        endcase
    end
end



assign DACLK = int_clk;

endmodule
