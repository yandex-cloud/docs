---
title: How to get a VM instance identity document
description: Follow this guide to get a VM instance identity document.
---

# Getting a VM instance identity document

When you create a VM, an [identity document](../../concepts/metadata/identity-document.md) that stores information about the VM is generated. It contains the IDs of the VM instance, Marketplace product, disk image, etc.

To request an identity document:

1. Connect to the VM:

   ```bash
   ssh <VM_IP_address>
   ```

1. Run this command to get the identity document in Google Compute Engine [format](../../../compute/concepts/vm-metadata.md#metadata-formats):

   ```bash
   curl \
     --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/document
   ```

   Here is a response example:

   ```json
   {"instanceId":"fhmm5252k8vl********","productCodes":null,"imageId":"fd8evlqsgg4e********","productIds":["f2e3ia802lab********"],"createdAt":"2023-05-29T09:46:59Z","version":"2023-03-01"}
   ```

{% note info %}

If you created your VM before June 9, 2023, and you cannot get its identity document, stop and restart the VM.

{% endnote %}

## Checking identity document signature {#check-id-signature}

Apart from the identity document itself, the VM instance [metadata service](../../../compute/concepts/vm-metadata.md) provides its cryptographic signatures.

You can use these signatures to verify the document's origin, authenticity, and integrity. To do this:

{% list tabs %}

- RSA

  1. Connect to the VM:

     ```bash
     ssh <VM_IP_address>
     ```

  1. Get an RSA signature from the VM metadata and save it to a file named `rsa2048`:

     ```bash
     curl \
       --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/rsa > rsa2048
     ```

  1. Create a file named `certificate` and add a public certificate to it:




  1. Verify the signature and save the contents of the document to a file named `document`:

     ```bash
     openssl smime -verify -in rsa2048 -inform PEM -certfile certificate -noverify | tee document
     ```

     If the signature is valid, you will see a message saying `Verification successful`.

- DSA

  1. Connect to the VM:

     ```bash
     ssh <VM_IP_address>
     ```

  1. Get a signature from the VM metadata and save it to a file named `dsa2048`:

     ```bash
     curl \
       --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/dsa > dsa2048
     ```

  1. Create a `certificate` file and save a public certificate to it:

     
     ```text
     -----BEGIN CERTIFICATE-----
     MIIERjCCA+ugAwIBAgIULIUmuptqf9Pz7nMGMHeW+BPNneYwCwYJYIZIAWUDBAMC
     MAAwHhcNMjMwNjA3MDY1NjI0WhcNMzMwNjA0MDY1NjI0WjAAMIIDRjCCAjkGByqG
     SM44BAEwggIsAoIBAQDFyteKPnUOauqiHzsLCw2Z//c1IjSqVVPpIbETQ1NUCsUI
     o6+at1VkxJ76K/HqvFlhC87nSGWuQMgflQXcVIEQ8c0wnQGRj4lwkkjm8WClo4xv
     t/FsNyv4uEcPgcz45A2YxE4+5odjicKMCz4pPW+kc9t4BiKw4I9uGySBhA1p21e+
     fmR4AzDSHdHGRlvlYOfYANZlVeWm+qLsb+VfyeETTOD+ooMA9Y4ue3dw2l8Clib8
     WummF2PNRnnOeEFGbwZErtdObla2TjdNzFWc6QWo1EcqqkBXG1TutY/FgNcTj+Ps
     nFoUu4ZIy7o8p8YgzyffSCQbP5ppRGpfh4DuIS+vAiEA8tkwKyKmcCxTWnpRNWlY
     O6kUanHgEQczpLtP3mDvcdUCggEAMhbW4syX5p7X1qs0OnFCLcd4tYA2DnR1dLu3
     ZPusUh6c9+cH3ICEnK22KB1nplMAHDyXjtV2rCvIGlNUcT6OkSulnkvNE185cfM0
     UKofG4t6VJNpa8bngF7Ccyf6QBPcUzigHv+QDQDZuA4k3IcQp0hC9ppOaN6J9rKp
     5cSPyLzJ2vyY6mG650omxgnwG4OGZSRX8c1JN/MvIj79m3LqM7civ8l6ljnC+LNm
     1T7mcgZcf9iYc5+OWICoeDtFUdr+qsNIXonIMku6FpJu0pBgVgE6GI+nD4oaXSQS
     bckxB24DEYvTlVALuXqPS8MZyQZz5ltoI8xnbEOMqtU3IPox1AOCAQUAAoIBADcS
     Pt2SC+cGUCKNhrPquESB2/dZKUDuyEtYIYMidfoyoBGhz2QuqOqf5tEcLY9gCeMP
     NxmaXW1AQtcAX/+tyCZrVxEc31btW3alLmu/NtKxmb6PRshsASI/LIE1wH82TV8C
     4ymFDyKUGCb5AWN+Ziv5AP5/6Q08awQ7YAuz/sw0xOMqDuUfYkLerPEuQg5Sozs0
     DWucS/ex7l+VqNAZUBZykta961bhplIDTRG05YD3Lz0w/WIBMdZzzolA7F3jgFJg
     rCfZwQeDbf1iorfxRS5DqR0Vt7XE6/yqRUzDjOMctKY68jLZGFfOfTQ9iX2R9K/f
     7kJPxaHnA+WWo13ExwGjUzBRMB0GA1UdDgQWBBTj+x+t2VJhAWI57o9xRwMOeTFj
     mzAfBgNVHSMEGDAWgBTj+x+t2VJhAWI57o9xRwMOeTFjmzAPBgNVHRMBAf8EBTAD
     AQH/MAsGCWCGSAFlAwQDAgNIADBFAiAX2ABj/9ea1Q4ssAgIGkA4vJywoUoT4Sbg
     LFFIJGlNWgIhAO0b749SY5+6UMEOLsxgvNzKKcv58BKADfBdJAXE6fRk
     -----END CERTIFICATE-----
     ```



  1. Verify the signature and save the contents of the document to a file named `document`:

     ```bash
     openssl smime -verify -in dsa2048 -inform PEM -certfile certificate -noverify | tee document
     ```

     If the signature is valid, you will see a message saying `Verification successful`.

- Base64

  1. Connect to the VM:

     ```bash
     ssh <VM_IP_address>
     ```

  1. Get a base64 signature from the VM metadata and save it to a file named `signature`:

     ```bash
     curl \
       --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/base64 | \
         base64 -d > signature
     ```

  1. Get an identity document and save it to a file named `document`:

     ```bash
     curl \
       --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/document > document
     ```

  1. Create a `certificate` file and save a public certificate to it:

     ```text
     -----BEGIN CERTIFICATE-----
     MIIC4TCCAcmgAwIBAgIUP0zcGO1MeRwze8VdSMEt/OdBXoIwDQYJKoZIhvcNAQEL
     BQAwADAeFw0yMzA2MDcwNjU4MTBaFw0zMzA2MDQwNjU4MTBaMAAwggEiMA0GCSqG
     SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDw6TvAvrbJvY4tzIIuDnLEVfRUW4BZJD3y
     K8fyyxXrYDvC69RKCKk9+TQhnUOLhZNlDST4HFfSPlakOjXUduyJE5M1EmoLAstN
     81aP3TejseDavxmaNijXRsa9E731T5H+zo44PgAHfQJmiD7rtcr+QOIosKUB2dwp
     F2acp9hLKd389BfNctziG0Oxq7hlISTDBnhzBg7eKuqWtShjVW5RqQvp3bARfUPa
     RWdYjmZvR+AnmozV1SGnpAnatzhnF6tNAb5XSEw49tumsX1D4A11J6mtrafO6bsP
     wdIPwy9W15iCszUNlFcdBaZhESc34VbyCyLMvA5T0Uj1FJHz1RFlAgMBAAGjUzBR
     MB0GA1UdDgQWBBQq0z6Vcmjcn8wnRTwKGSm5YGas9TAfBgNVHSMEGDAWgBQq0z6V
     cmjcn8wnRTwKGSm5YGas9TAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUA
     A4IBAQBplippQ/Pxn7AkuwOTSwSTeJ7S+rMSb6iSL9chNHetanft0Ikr5BDsSrd6
     TeHV0sEMilDIjX0EjSNHwYtYrDPk6cGjkzDTYb6/U10c5Xhwi0g7/lMH/RPihPz5
     co80VEqXWlgfgHuE7/cAiTJ61PiFD9oI494bQcIISQNDfbUUiYfn32+8nK20rn8C
     w7PbGoIv6zz6A0c6DJT7yXJF5sAHgX4M03Oi9edzQ077ZOboXSuUKe4VfHIpjTjZ
     0sM/NbG5BFstyetVc3FZOGWGukTRb0C0GSASOm6hCyh5ctmpwlS4menc/OAx9BYO
     r9ZBjEa0oLFVV0pP5Tj4Gf1DDpuJ
     -----END CERTIFICATE-----
     ```

  1. Extract a public key from the certificate and save it to a file named `key`:

     ```bash
     openssl x509 -pubkey -noout -in certificate > key
     ```

  1. Verify the signature and save the contents of the document to a file named `document`:

     ```bash
     openssl dgst -sha256 -verify key -signature signature document
     ```

     If the signature is valid, you will see a message saying `Verified OK`.

{% endlist %}

Map the identity document from the VM metadata to the document saved to the file:

```bash
curl http://169.254.169.254/latest/vendor/instance-identity/document | \
openssl dgst -sha256
```

```bash
openssl dgst -sha256 < document
```

If they have the same hash, the identity document saved to the file matches the document from the VM metadata.