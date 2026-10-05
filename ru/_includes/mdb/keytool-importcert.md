Добавьте SSL-сертификат в хранилище доверенных сертификатов Java (Java Key Store), чтобы драйвер {{ KF }} мог использовать этот сертификат при защищенном подключении к хостам кластера:

* {% cut "Скрипт для Linux (Bash)" %}

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
            -storepass <пароль_хранилища_сертификатов> \
            -noprompt

    rm "${cert}"
  done

  chmod 0655 ssl
  ```

  Где `-storepass` — пароль хранилища сертификатов. Пароль должен содержать не менее 6 символов.
  
  {% endcut %}

* {% cut "Скрипт для macOS (Zsh)" %}

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
            -storepass <пароль_хранилища_сертификатов> \
            -noprompt

    rm "${cert}"
  done

  chmod 0655 ssl
  ```

  Где `-storepass` — пароль хранилища сертификатов. Пароль должен содержать не менее 6 символов.
  
  {% endcut %}