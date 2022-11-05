#!/bin/bash

cd contracts/circuits/LessThan10/LessThan10_js
node generate_witness.js LessThan10.wasm input.json witness.wtns

cd ../../../..