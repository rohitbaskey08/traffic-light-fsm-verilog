`timescale 1ns / 1ps

`define y2rdelay  3
`define r2gdelay  2


module traffic_light(
  input x, //if there any car in country road
  input clk,clr,
  output reg [1:0] hwy,cntry
    );
    //status of light
    parameter RED = 2'd0,
              YELLOW = 2'd1,
              GREEN = 2'd2;
     //state defination    HWY            CNTRY
     parameter S0 = 3'd0,  //GREEN        RED
               S1 = 3'd1,  //YELLOW       RED
               S2 = 3'd2,  //RED          RED
               S3 = 3'd3,  //RED          GREEN
               S4 = 3'd4;  //RED          YELLOW
    
    reg [2:0] state;
    reg [3:0]count;
    
        
     always @(*)
      begin
       hwy = GREEN;
       cntry = RED;
       case(state)
        S0: ;
        S1:hwy = YELLOW;
        S2:hwy = RED;
        S3:begin
            hwy =RED;
            cntry =  GREEN;
        end
        S4:begin
            hwy = RED;
            cntry = YELLOW;
        end
        endcase
      end
      
      always @(posedge clk or  posedge clr) begin
     if(clr) begin
      state <= S0;
      count <= 0;
      end
     else begin
 case(state)

 S0: begin
      count<=0;
      if(x)
        state <= S1;
      else
        state <= S0;
     end

 S1: begin
      if(count < `y2rdelay)begin
        state <= S1;
        count <= count+1;
        end 
      else begin
        state <= S2;
        count<=0;
     end
    end
 S2: begin
      if(count < `r2gdelay) begin
        state <= S2;
        count <= count+1;
        end
      else begin
        state <= S3;
        count<=0;
     end
 end
 S3: begin
    count<=0;
      if(x)
        state <= S3;
      else
        state <= S4;
     end

 S4: begin
      if(count < `y2rdelay) begin
        state <= S4;
        count <= count+1;
        end
      else begin
       state <= S0;
        count <=0;
        end
     end

 default: begin state <= S0;
          count<=0;
          end
 endcase
end
end   
endmodule
