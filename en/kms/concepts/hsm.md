---
title: "Hardware security module (HSM) in {{ kms-full-name }}"
description: "In this tutorial, you will learn about the hardware security module, its implementation in {{ kms-name }}, and how you can use it."
---

# Hardware security module (HSM)

This functionality is at the [Preview](../../overview/concepts/launch-stages.md) stage and is free of charge.

A hardware security module ([HSM](https://en.wikipedia.org/wiki/Hardware_security_module)) is a specialized computing device that is designed to perform cryptographic operations with a high level of security.

Traditionally, HSMs are used in applications where encryption must provide a level of protection at which the cost and complexity of a successful attack limit potential perpetrators to a small number of highly skilled individuals.

## HSM in {{ kms-name }}

HSMs that are used in {{ yandex-cloud }} are special-purpose protected physical servers supplied by CRYPTO-PRO LLC, a manufacturer of information encryption tools.

This hardware implements a set of solutions to protect a cryptographic asset throughout its life cycle, such as:
* Trusted operating system.
* Tamper-proof housing.
* Protection from power supply voltage and ambient temperature fluctuations.
* Robust random number generators.
* Protection against human error (minimized chance of hardware misconfiguration).
* Trusted operating system bootup.

### HSM operating procedure

In {{ kms-name }}, you can create a symmetric encryption key whose every cryptographic operation will be handled only inside the HSM. The HSM will also generate the key itself. In this situation, the user's key resides in the {{ kms-name }} service database only in encrypted form. The HSM uses its master key, which never leaves the HSM, to encrypt the user key.

For all cryptographic operations, the symmetric key will be transmitted to the HSM. The HSM handles all cryptographic operations with the user key only internally and only returns the results of such operations to {{ kms-name }}.

A cryptographic operation using the HSM includes the following steps:

1. The {{ kms-name }} database supplies a user key in encrypted form.
1. The encrypted key is forwarded to the HSM along with the user data.
1. The HSM decrypts the user key using the HSM master key.
1. The HSM performs a cryptographic operation with the user data using the decrypted key.
1. The HSM destroys the decrypted user key.
1. The data goes back to the user.

### Enabling the HSM for a key

To use the HSM, select `AES-256 HSM` as the algorithm type when creating a symmetric key. The HSM will handle all operations with this key internally, and no additional actions are required.
