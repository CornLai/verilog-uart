module fsm_TX (
  input clk_50M,
  input rst_n,
  input en,
  input tick_uart,
  output busy

);
  
reg [1:0] state;
reg [1:0] next;
wire countflag;
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
      if(tick_uart == 1'b1 && countflag == 1'b1)
        next = STOP;
      else
        next = SHIFT;  
    end
    STOP: begin
      if (tick_uart == 1'b1) begin
        next = IDLE;
      end
      else 
        next = STOP;
    end
    default:
      next = IDLE; 
  endcase
  
end
//counter
reg [2:0] counter;
always @(posedge clk_50M) begin
  if (!rst_n) begin
    counter <= 1'b0;
  end
  else begin
    if (state == SHIFT) begin
      if (counter == 3'd7) begin
        counter <= 1'b0;
      end
      else begin
        counter <= counter + 1'b1;
      end
    end
    else begin
      counter <= 1'b0;
    end
  end
end
assign countflag = (counter == 3'd7);
endmodule
