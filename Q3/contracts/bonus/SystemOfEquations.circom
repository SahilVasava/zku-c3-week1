pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/comparators.circom";
include "../../node_modules/circomlib-matrix/circuits/matElemMul.circom"; // hint: you can use more than one templates in circomlib-matrix to help you
include "../../node_modules/circomlib-matrix/circuits/matElemSum.circom";
include "../../node_modules/circomlib-matrix/circuits/matMul.circom";
include "../../node_modules/circomlib/circuits/comparators.circom";

template SystemOfEquations(n) { // n is the number of variables in the system of equations
    signal input x[n]; // this is the solution to the system of equations
    signal input A[n][n]; // this is the coefficient matrix
    signal input b[n]; // this are the constants in the system of equations
    signal output out; // 1 for correct solution, 0 for incorrect solution

    component mul = matMul(n,n+1,1);
    // component sum[n];
    for(var i=0; i<n; i++) {
        for(var j=0; j<n+1; j++) {
            if (j<n) {
                mul.a[i][j] <== A[i][j];
                // mul.b[j][0] <== x[j];
            } else {
                mul.a[i][j] <== b[i];
                // mul.b[j][0] <== -1;
            }
        }
    }
    // for(var i=0; i<n+1; i++) {
    //     for(var j=0; j<n; j++) {
    //         if (i<n) {
    //             // mul.a[i][j] <== A[i][j];
    //             mul.b[i][0] <== x[j];
    //         } else {
    //             // mul.a[i][j] <== b[i];
    //             mul.b[i][0] <== -1;
    //         }
    //     }
    // }
    component isZero = IsZero();
    var sum=0;
    for (var i=0; i<n+1; i++) {
        sum += mul.out[i][0];
    }
    isZero.in <== sum;
    out <== isZero.out;

    // component isEqual[n];
    // signal tmp[n];
    // // // first check
    // isEqual[0] = IsEqual();
    // isEqual[0].in[0] <== mul.out[0][0];
    // isEqual[0].in[1] <== b[0];
    // tmp[0] <== isEqual[0].out;

    // If these is one equation that is not satisfied, the output is 0.
    // for (var i=1; i<n; i++) {
    //     isEqual[i] = IsEqual();
    //     isEqual[i].in[0] <== mul.out[i][0];
    //     isEqual[i].in[1] <== b[i];
    //     tmp[i] <== tmp[i-1] * isEqual[i].out;
    //     log(mul.out[i][0] == b[i]);
    //     log(isEqual[i].out);
    // }

    // log(tmp[n-1]);
    // out <== tmp[n-1];
    // log(mtMul.out[0][0]);
    // log(mtMul.out[1][0]);
    // log(mtMul.out[2][0]);
    // log(b[0]);
    // log(b[1]);
    // log(b[2]);
    // var andAll = 1;
    // component isE[n];
    // for(var i=0; i<n; i++) {
    //     isE[i] = IsEqual();
    //     isE[i].in[0] <== mtMul.out[i][0];
    //     isE[i].in[1] <== b[i];
    // }
    // for(var i=0; i<n; i++) {
    //     andAll &= isE[i].out;
    //     log(isE[i].out);
    // }
    // log(andAll);
    // out <== 1;
}

component main {public [A, b]} = SystemOfEquations(3);