Чтобы сохранить сертификат и закрытый ключ в отдельных файлах формата `.pem`, вы можете воспользоваться утилитой [openssl](https://docs.openssl.org/1.1.1/man1/pkcs12) в Linux:

```bash
openssl pkcs12 -in Certificates.p12 -nokeys -nodes -out certificate.pem
openssl pkcs12 -in Certificates.p12 -nocerts -nodes -out privatekey.pem
```
