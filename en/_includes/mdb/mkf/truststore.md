A _TrustStore_ is a trusted certificate store used in JKS (Java KeyStore) files. It serves for authenticating a client connecting to the server. The server validates the client using certificates stored in the TrustStore. The client stores its private key and certificate locally in a KeyStore.

The example below uses a TrustStore to connect to the {{ mkf-name }} cluster. With no TrustStore created, the {{ KF }} web UI will lack information about the cluster.

To use a TrustStore:

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

   It will store the `truststore.jks` file. You need a separate directory to ensure the file path is correctly recognized in commands and configuration files.

1. Import the `YandexCA.crt` certificate into the `truststore.jks` file:

   ```bash
   sudo keytool -import \
                -file {{ crt-local-dir }}YandexCA.crt \
                -alias "kafka-ui-cert" \
                -keystore /truststore/truststore.jks
   ```

   You will be prompted to create a password. Note it down, as you will need it to deploy the {{ KF }} web UI.
