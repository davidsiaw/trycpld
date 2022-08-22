trycpld
-------

Attempt to use Yosys to make CPLD jed file and based on whitequark's prjbureau.

```
yosys -p "read_verilog -lib prjbureau/cells.v; read_verilog and.v; hierarchy; write_edif -top top -attrprop" -o and.edif

./fit1502.exe -i and.edif -o and.jed -strategy ifmt=edif -strategy optimize=on -device P1502C44 -strategy pin_keep on
```



Notes
-----

1. fit1502 is freely available but is a licensed product, download it from microchips site under WinCupl. You need to run the installer and extract the files from the installation directory.
2. the verilog file needs to use the modules in `cells.v`. Just using like


```
module top(input A, input B, output C);
  assign C = B & A;
endmodule
```

creates an edif file that the fitter refuses to read. mostly because it names stuf id00001 and the fitter does not like it. I guess we could post process the file.
3. setting the pins don't seem to be required, the fitter can decide them for you.
4. you can run this all in cygwin if you use windows and you won't need wine. not that it matters.
5. if you get a Internal Error from the fitter, you have an error that is somehow permitted by verilog and yosys but produces an edif that makes no sense to the fitter.


VVV
---

You can generate a verilog file using the `bin/vvv` util. It reads an expression and writes out the equivalent verilog.

It reads files passed by name, or STDIN if no arguments are provided.
If the first argument is '-' it will read the rest of the command line for the input.

Available operators in order of precedence:

```
- `!` - not
- `*` - and
- `+` - or
- `^` ^ xor 
- `<=` - assign
```

You can use parens to reorder computation.

Example usage

```
$ echo "q <= a * b + c * d" | bin/vvv
module top(
    input a, b, c, d,
    output q
);

    wire n0, n1;
    AND2 and_a_b(.A(a), .B(b), .Q(n0));
    AND2 and_c_d(.A(c), .B(d), .Q(n1));
    OR2 or_n0_n1(.A(n0), .B(n1), .Q(q));

endmodule
```

```
$ echo "q <= a * (b + c) * d" | bin/vvv
module top(
    input a, b, c, d,
    output q
);

    wire n0, n1;
    OR2 or_b_c(.A(b), .B(c), .Q(n0));
    AND2 and_a_n0(.A(a), .B(n0), .Q(n1));
    AND2 and_n1_d(.A(n1), .B(d), .Q(q));

endmodule
```

```
$ bin/vvv - "a <= b ^ ~c"
module top(
    input b, c,
    output a
);

    wire n0;
    INV not_c(.A(c), .QN(n0));
    XOR2 xor_b_n0(.A(b), .B(n0), .Q(a));

endmodule
```

```
$ bin/vvv - "a <= b ^ ~c; d <= b + c"
module top(
    input b, c,
    output a, d
);

    wire n0;
    INV not_c(.A(c), .QN(n0));
    XOR2 xor_b_n0(.A(b), .B(n0), .Q(a));
    OR2 or_b_c(.A(b), .B(c), .Q(d));

endmodule
```
