module top(input CLK, D, output Q);
  DFF dff(.CLK(CLK), .D(D), .Q(Q));
endmodule
