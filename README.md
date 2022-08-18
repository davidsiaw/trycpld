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

