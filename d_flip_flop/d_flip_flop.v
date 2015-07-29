module d_flip_flop (
input   data    ,
input   clk     ,
output reg q
);

always @ (negedge clk) begin
    q = data;
end

endmodule
