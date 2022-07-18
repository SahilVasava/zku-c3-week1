#!/bin/bash

cd contracts/circuits

mkdir HelloWorld_plonk

if [ -f ./powersOfTau28_hez_final_10.ptau ]; then
    echo "powersOfTau28_hez_final_10.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_10.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_10.ptau
fi

echo "Compiling HelloWorld.circom..."

# compile circuit

circom HelloWorld.circom --r1cs --wasm --sym -o HelloWorld_plonk
snarkjs r1cs info HelloWorld_plonk/HelloWorld.r1cs

# Start a new zkey and make a contribution

snarkjs plonk setup HelloWorld_plonk/HelloWorld.r1cs powersOfTau28_hez_final_10.ptau HelloWorld_plonk/circuit_0000.zkey
snarkjs zkey export verificationkey HelloWorld_plonk/circuit_0000.zkey HelloWorld_plonk/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier HelloWorld_plonk/circuit_0000.zkey ../HelloWorldVerifier_plonk.sol

cd ../..