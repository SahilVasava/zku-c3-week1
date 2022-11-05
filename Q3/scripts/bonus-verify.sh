#!/bin/bash

cd contracts/bonus/SystemOfEquations/

snarkjs wtns export json SystemOfEquations_js/witness.wtns SystemOfEquations_js/witness.json

snarkjs groth16 prove circuit_final.zkey SystemOfEquations_js/witness.wtns proof.json public.json

snarkjs groth16 verify verification_key.json public.json proof.json