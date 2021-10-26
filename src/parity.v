module parity #(
    //parameters
)
(
    input [7:0] data,
    output parity
);
    assign parity = (^data); //Se hace XOR entre los bits del dato para determinar la paridad.
                            //Paridad: "0" si se tiene cantidad par de 1s, "1" si se tiene cantidad impar de 1s.

endmodule