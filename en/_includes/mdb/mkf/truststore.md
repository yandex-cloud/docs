A _TrustStore_ is a trusted certificate store used in JKS (Java KeyStore) files. It serves for authenticating a client connecting to the server. The server validates the client using certificates stored in the TrustStore. The client stores its private key and certificate locally in a KeyStore.

The example below uses a TrustStore to connect to the {{ mkf-name }} cluster. With no TrustStore created, the {{ KF }} web UI will lack information about the cluster.

To use a TrustStore:

1. Upload an SSL certificate:

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

1. Import the certificates from `YandexCA.crt` into `truststore.jks`:
   
   {% list tabs group=operating_system %}

   - Linux (Bash) {#linux}

     ```bash
     awk '/-----BEGIN CERTIFICATE-----/ {n++} n {print > "YandexCA-" n ".crt"}' \
       < {{ crt-local-dir }}YandexCA.crt

     for cert in YandexCA-*.crt; do
       alias=$(
         openssl x509 -noout -text -in "${cert}" |
         perl -ne 'next unless /Subject:/; s/.*(CN=|CN = )//; print'
       )

       year=$(openssl x509 -noout -enddate -in "${cert}" | awk '{print $(NF-1)}')

       echo "Importing ${alias}-${year}"

       keytool -importcert \
               -alias "${alias}-${year}" \
               -file "${cert}" \
               -keystore /truststore/truststore.jks \
               -storepass <secure_store_password> \
               -noprompt

       rm "${cert}"
     done

     chmod 0655 /truststore/truststore.jks
     ```

   - macOS (Zsh) {#macos}
     
     ```bash     
     split -p "-----BEGIN CERTIFICATE-----" \
            {{ crt-local-dir }}YandexCA.crt \
            YandexCA-

     for cert in YandexCA-*.crt; do
       alias=$(
         openssl x509 -noout -text -in "${cert}" |
         perl -ne 'next unless /Subject:/; s/.*(CN=|CN = )//; print'
       )

       year=$(openssl x509 -noout -enddate -in "${cert}" | awk '{print $(NF-1)}')

       echo "Importing ${alias}-${year}"

       keytool -importcert \
               -alias "${alias}-${year}" \
               -file "${cert}" \
               -keystore /truststore/truststore.jks \
               -storepass <secure_store_password> \
               -noprompt

       rm "${cert}"
     done

     chmod 0655 /truststore/truststore.jks
     ```

   {% endlist %}

   Where `-storepass` is the certificate store password. It must contain at least six characters. Save the password, as you will need it to deploy the {{ KF }} web UI.