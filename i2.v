
module top (input [1:0]A, output [1:0]Q);
  INV n[1:0](.A(A), .QN(Q));
endmodule
