---
title: How to create a certificate in {{ iot-full-name }}
description: Follow this guide to create a certificate in {{ iot-full-name }}.
---

# Creating a certificate

{% include [iot-sunset-warning](../../../_includes/iot-core/sunset-warning.md) %}

Devices require X.509 certificates to communicate with each other. If you do not have a certificate, you can create one, e.g., with [OpenSSL](https://www.openssl.org).

To create a certificate, install OpenSSL and run the following command in the command line:

```bash
openssl req -x509 \
  -newkey rsa:4096 \
  -keyout key.pem \
  -out cert.pem \
  -nodes \
  -days 365 \
  -subj '/CN=localhost'
```

Where:

* `-x509`: X.509 certificate.
* `newkey`: Encryption algorithm.
* `-keyout`: File to write the private key to.
* `-out`: File to save the certificate to.
* `-nodes`: Flag to use when you do not need to encrypt the public key.
* `-days`: Certificate validity period, in days.
* `-subj`: Request subject.
