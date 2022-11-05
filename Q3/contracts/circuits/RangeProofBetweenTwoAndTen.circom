pragma circom 2.0.0;

include "./RangeProof.circom";

template RangeProofBetweenTwoAndTen() {
    signal input in;
    signal output out;

    component rp = RangeProof(32);

    rp.in <== in;
    rp.range[0] <== 2;
    rp.range[1] <== 10;

    out <== rp.out;
}

component main = RangeProofBetweenTwoAndTen();