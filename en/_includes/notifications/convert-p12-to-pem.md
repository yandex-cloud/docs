To save the certificate and the private key in individual `.pem` files, use the [openssl](https://docs.openssl.org/1.1.1/man1/pkcs12) Linux utility:

```bash
openssl pkcs12 -in Certificates.p12 -nokeys -nodes -out certificate.pem
openssl pkcs12 -in Certificates.p12 -nocerts -nodes -out privatekey.pem
```
