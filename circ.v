module top(input CLK, IE, inout IO);
  wire a, b;
  DFF dff(.CLK(CLK), .D(b), .Q(a));
  DFF dff2(.CLK(CLK), .D(a), .Q(b));

  wire oe;
  INV invv(.A(IE), .QN(oe));
  TRI buff1(.A(IO), .ENA(IE), .Q(a));
  TRI buff2(.A(a), .ENA(oe), .Q(IO));

endmodule
