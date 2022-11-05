#!/bin/bash

cd contracts/circuits

mkdir RangeProofBetweenTwoAndTen

if [ -f ./powersOfTau28_hez_final_10.ptau ]; then
    echo "powersOfTau28_hez_final_10.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_10.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_10.ptau
fi

echo "Compiling RangeProofBetweenTwoAndTen.circom..."

# compile circuit

circom RangeProofBetweenTwoAndTen.circom --r1cs --wasm --sym -o RangeProofBetweenTwoAndTen
snarkjs r1cs info RangeProofBetweenTwoAndTen/RangeProofBetweenTwoAndTen.r1cs

# Start a new zkey and make a contribution

snarkjs groth16 setup RangeProofBetweenTwoAndTen/RangeProofBetweenTwoAndTen.r1cs powersOfTau28_hez_final_10.ptau RangeProofBetweenTwoAndTen/circuit_0000.zkey
snarkjs zkey contribute RangeProofBetweenTwoAndTen/circuit_0000.zkey RangeProofBetweenTwoAndTen/circuit_final.zkey --name="1st Contributor Name" -v -e="random text"
snarkjs zkey export verificationkey RangeProofBetweenTwoAndTen/circuit_final.zkey RangeProofBetweenTwoAndTen/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier RangeProofBetweenTwoAndTen/circuit_final.zkey ../RangeProofBetweenTwoAndTenVerifier.sol

cd RangeProofBetweenTwoAndTen/RangeProofBetweenTwoAndTen_js
# node generate_witness.js RangeProofBetweenTwoAndTen.wasm input.json witness.wtns
cd ../..

cd ../..