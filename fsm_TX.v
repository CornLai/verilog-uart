module fsm_TX (
  input clk_50M,
  input rst_n,
  input en,
  input tick_uart,
  input [2:0] count,
  output reg LDEN,
  output reg SHEN,
  output reg rstcount,
  output reg countEN,
  output reg TX_D,
  output busy

);
  
reg [1:0] state;
reg [1:0] next;
parameter IDLE = 2'd0;
parameter START = 2'd1;
parameter SHIFT = 2'd2;
parameter STOP = 2'd3;

assign busy = (state != IDLE);

always @(posedge clk_50M) begin
  if (!rst_n) begin
   state <= IDLE; 
  end
  else begin
    state <= next;
  end
  
end
always @* begin
  case (state)
    IDLE: begin
      if(en)
        next = START;
      else
        next = IDLE;
    end
    START: begin
      if(tick_uart)
        next = SHIFT;
      else 
        next = START; 
    end
    SHIFT: begin
      
    end
    default: 
  endcase
  
end
endmodule