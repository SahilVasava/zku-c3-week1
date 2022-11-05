#!/bin/bash

cd contracts/circuits/RangeProofBetweenTwoAndTen/

snarkjs wtns export json RangeProofBetweenTwoAndTen_js/witness.wtns RangeProofBetweenTwoAndTen_js/witness.json

snarkjs groth16 prove circuit_final.zkey RangeProofBetweenTwoAndTen_js/witness.wtns proof.json public.json

snarkjs groth16 verify verification_key.json public.json proof.json