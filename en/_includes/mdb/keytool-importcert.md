Add the SSL certificate to the Java trusted certificate store (Java Key Store) so the {{ KF }} driver could use it for secure connections to cluster hosts:

* {% cut "Linux script (Bash)" %}

  ```bash
  awk '/-----BEGIN CERTIFICATE-----/ {n++} n {print > "YandexInternalRootCA-" n ".crt"}' \
    < {{ crt-local-dir }}{{ crt-local-file }}

  for cert in YandexInternalRootCA-*.crt; do
    alias=$(
      openssl x509 -noout -text -in "${cert}" |
      perl -ne 'next unless /Subject:/; s/.*(CN=|CN = )//; print'
    )

    year=$(openssl x509 -noout -enddate -in "${cert}" | awk '{print $(NF-1)}')

    echo "Importing ${alias}-${year}"

    keytool -importcert \
            -alias "${alias}-${year}" \
            -file "${cert}" \
            -keystore ssl \
            -storepass <certificate_store_password> \
            -noprompt

    rm "${cert}"
  done

  chmod 0655 ssl
  ```

  Where `-storepass` is the certificate store password. The password must contain at least six characters.
  
  {% endcut %}

* {% cut "macOS script (Zsh)" %}

  ```bash
  split -p "-----BEGIN CERTIFICATE-----" \
    {{ crt-local-dir }}{{ crt-local-file }} \
    YandexInternalRootCA-

  for cert in YandexInternalRootCA-*.crt; do
    alias=$(
      openssl x509 -noout -text -in "${cert}" |
      perl -ne 'next unless /Subject:/; s/.*(CN=|CN = )//; print'
    )

    year=$(openssl x509 -noout -enddate -in "${cert}" | awk '{print $(NF-1)}')

    echo "Importing ${alias}-${year}"

    keytool -importcert \
            -alias "${alias}-${year}" \
            -file "${cert}" \
            -keystore ssl \
            -storepass <certificate_store_password> \
            -noprompt

    rm "${cert}"
  done

  chmod 0655 ssl
  ```

  Where `-storepass` is the certificate store password. The password must contain at least six characters.
  
  {% endcut %}