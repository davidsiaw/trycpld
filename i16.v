
module top (input [15:0]A, output [15:0]Q);
  INV n[15:0](.A(A), .QN(Q));
endmodule
