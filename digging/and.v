//OPT: -device PLCC44
//OPT: -strategy pin_keep on
//PIN: CHIP "top" ASSIGNED TO PLCC44
//PIN: A : 6
//PIN: B : 5
//PIN: C : 4
module top(input A, input B, output C);
//  AND2 n( .A(A), .B(B), .Q(C) );
  assign C = A & B;
endmodule
