module t_flip_flop (
input   data    ,
input   clk     ,
output reg q
);

always @ (posedge clk) begin
if(data) begin
    q = ~q;
end
end

endmodule
