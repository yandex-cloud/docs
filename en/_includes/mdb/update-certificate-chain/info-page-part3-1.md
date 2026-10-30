For most users, no additional actions are required when the certificate chain is updated. If the client trusts the `YandexInternalRootCA` root certificate and does not fix an intermediate certificate or specific server certificates, the connection will continue to operate.

Issues may occur after updating the certificate chain in the following cases:

* **Certificate fixing**. The client trusts only the current intermediate or server certificate. We recommend to avoid fixing such certificates: they are changed during routine rotation.
* **Own certificate store**. In [Java KeyStore](https://en.wikipedia.org/wiki/Java_KeyStore) or another secure certificate store (trust store), only the old intermediate certificate is imported and used.
* **`CA.pem` usage**. Certain import methods, in particular a single `keytool` call, add only the first (intermediate) chain certificate from this file.