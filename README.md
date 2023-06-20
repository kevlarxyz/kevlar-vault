# Kevlar-Vault

A Flexible, Open Source, Warm Custody Solution for EVM Chains. 

## Overview
Kevlar relies largely on the [Hashicorp Vault](https://www.vaultproject.io/) project for its core functionality. Vault is a tool for securely accessing secrets. A secret is anything that you want to tightly control access to, such as API keys, passwords, certificates, and more. In this case it is tightly scoped private keys for EVM Chains. Vault provides a unified interface to any secret, while providing tight access control and recording a detailed audit log.

We see this as a very lightweight, flexible, and secure solution for warm custody and a good alternative to slow, expensive, and complex cold custody solutions.

## Notes 
This project is largely a work in progress, is not ready for production use and is made in a large part thanks to immutability's [vault-ethereum](github.com/immutability-io/vault-ethereum) repository.
