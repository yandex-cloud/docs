# Create a certificate

For devices to interact, you need X.509 certificates. If don't have one, you can create a certificate, for example, with [OpenSSL](https://www.openssl.org):

```
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
* `-nodes`: This flag is set when no public key encryption is required.
* `-days`: Certificate validity period in days.
* `-subj`: Request object.

