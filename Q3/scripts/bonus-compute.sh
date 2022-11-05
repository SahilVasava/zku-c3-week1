#!/bin/bash

cd contracts/bonus/SystemOfEquations/SystemOfEquations_js
node generate_witness.js SystemOfEquations.wasm input.json witness.wtns

cd ../../../..