TrustStore is a trusted certificate store used in JKS files. It serves for authenticating a client when connecting to the server. The server validates the client using certificates stored in TrustStore. However, the client stores the private key and the certificate on their side in KeyStore.

In the example below, TrustStore is used to connect to a {{ mkf-name }} cluster. With no TrustStore created, the {{ KF }} web interface will lack information about the cluster.

To use TrustStore:

1. Create an SSL certificate:

   ```bash
   sudo mkdir -p {{ crt-local-dir }} && \
   sudo wget "{{ crt-web-path }}" \
        --output-document {{ crt-local-dir }}YandexCA.crt && \
   sudo chmod 0655 {{ crt-local-dir }}YandexCA.crt
   ```

1. Create a directory named `/truststore`:

   ```bash
   mkdir /truststore
   ```

   It will store the `truststore.jks` file. You need a separate directory so that the file path is correctly recognized in commands and configuration files.

1. Upload the `YandexCA.crt` certificate to the `truststore.jks` file:

   ```bash
   sudo keytool -import \
                -file {{ crt-local-dir }}YandexCA.crt \
                -alias "kafka-ui-cert" \
                -keystore /truststore/truststore.jks
   ```

   You will be prompted to create a password. Memorize it: you will need it to deploy the {{ KF }} web interface.
