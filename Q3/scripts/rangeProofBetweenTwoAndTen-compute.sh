#!/bin/bash

cd contracts/circuits/RangeProofBetweenTwoAndTen/RangeProofBetweenTwoAndTen_js
node generate_witness.js RangeProofBetweenTwoAndTen.wasm input.json witness.wtns

cd ../../../..