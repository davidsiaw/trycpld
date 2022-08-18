module top(input [8:0]I1, input [8:0]I2, input [8:0]I3, output Q);
  wire w1,w2,w3;
  AND9 n1( .A(I1[8]), .B(I1[7]), .C(I1[6]), .D(I1[5]), .E(I1[4]), .F(I1[3]), .G(I1[2]), .H(I1[1]), .I(I1[0]), .Q(w1));
  AND9 n2( .A(I2[8]), .B(I2[7]), .C(I2[6]), .D(I2[5]), .E(I2[4]), .F(I2[3]), .G(I2[2]), .H(I2[1]), .I(I2[0]), .Q(w2));
  AND9 n3( .A(I3[8]), .B(I3[7]), .C(I3[6]), .D(I3[5]), .E(I3[4]), .F(I3[3]), .G(I3[2]), .H(I3[1]), .I(I3[0]), .Q(w3));
  AND3 q(.A(w1), .B(w2), .C(w3), .Q(Q));
endmodule
