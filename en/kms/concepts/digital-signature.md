---
title: "Digital signature in {{ kms-short-name }}"
description: "This article describes the features of digital signatures in {{ kms-short-name }}."
---

# Digital signature in {{ kms-short-name }}

_Digital signature_ is a product of a cryptographic operation that provides additional data protection. Digital signatures serve these main purposes:

* Validating data
* Checking data integrity
* Protecting data against modification
* Identifying the data source

The digital signature algorithm supports two operations: creating a signature and [verifying a signature](#signature-verification).

Digital signatures are based on [asymmetric cryptography](asymmetric-encryption.md). An asymmetric key pair of a digital signature consists of two parts: a public key and a private key. The private key is used to create a signature and the public key to verify it.

You can use a digital signature to validate the source code, binary files, and container images. For example, you can validate an image signed with a digital signature. If the verification shows that the signature is invalid, it means that the image was changed or damaged. You can also use a digital signature to verify the subject of a certificate issued by a [Certificate Authority](https://en.wikipedia.org/wiki/Certificate_authority).

{% include [asymmetric-keys-quota](../../_includes/kms/asymmetric-keys-quota.md) %}

## Using a digital signature {#digital-signing}

The digital signature process actors are the owner of a key pair's private key and the recipients of signed data. Digital signatures are created and verified as follows:

1. The signature owner creates an asymmetric key pair with digital signature support.
1. The owner creates a digital signature for their own data. At this step, a hash value of user data is calculated, which is then signed by the private key based on a specified algorithm. The employed hash function is specified in the name of the algorithm.
1. The signature owner transmits the data, the digital signature, and the public key of the asymmetric key pair to a recipient.
1. The recipient uses the public key to verify the digital signature.
1. If the hash decrypted by the recipient matches that of the data, it means the signature is correct.

### Supported digital signature algorithms {#supported-algorithms}

{{ kms-short-name }} provides [ECDSA](https://en.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm) and [RSA](https://en.wikipedia.org/wiki/RSA_(cryptosystem)) cryptographic algorithms for using digital signatures. For both encryption algorithms, you can choose key size and hashing algorithm (digest):

* `RSA_2048_SIGN_PSS_SHA_256`
* `RSA_2048_SIGN_PSS_SHA_384`
* `RSA_2048_SIGN_PSS_SHA_512`
* `RSA_3072_SIGN_PSS_SHA_256`
* `RSA_3072_SIGN_PSS_SHA_384`
* `RSA_3072_SIGN_PSS_SHA_512`
* `RSA_4096_SIGN_PSS_SHA_256`
* `RSA_4096_SIGN_PSS_SHA_384`
* `RSA_4096_SIGN_PSS_SHA_512`
* `ECDSA_NIST_P256_SHA_256`
* `ECDSA_NIST_P384_SHA_384`
* `ECDSA_NIST_P521_SHA_512`
* `ECDSA_NIST_SECP256_K1_SHA_256`

## Verifying digital signatures {#signature-verification}

Digital signature verification is performed by the side that has no access to the digital signature's private key. The signature is verified using the public key.

### ECDSA signature {#ecdsa-verification}

To verify a digital signature:

1. Get the public key of the digital signature.

1. Perform verification:

    {% include [signature-verification-ecdsa](../../_includes/kms/signature-verification-ecdsa.md) %}

### RSA signature {#rca-verification}

To verify a digital signature:

1. Get the public key of the digital signature.

1. Perform verification:

    {% include [signature-verification-rsa](../../_includes/kms/signature-verification-rsa.md) %}