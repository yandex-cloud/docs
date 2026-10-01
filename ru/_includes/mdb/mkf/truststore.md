TrustStore — это хранилище доверенных сертификатов, которое используется в файлах JKS (Java KeyStore). Оно применяется для аутентификации клиента при его подключении к серверу. Сервер валидирует клиента с помощью сертификатов, которые хранятся в TrustStore. При этом клиент хранит приватный ключ и сертификат на своей стороне, в хранилище KeyStore.

В примере ниже TrustStore используется, чтобы подключиться к кластеру {{ mkf-name }}. Без создания TrustStore в веб-интерфейсе {{ KF }} не появится информация о кластере.

Чтобы использовать TrustStore:

1. Загрузите SSL-сертификат:

   ```bash
   sudo mkdir -p {{ crt-local-dir }} && \
   sudo wget "{{ crt-web-path }}" \
        --output-document {{ crt-local-dir }}YandexCA.crt && \
   sudo chmod 0655 {{ crt-local-dir }}YandexCA.crt
   ```

1. Создайте директорию `/truststore`:

   ```bash
   mkdir /truststore
   ```

   В ней будет храниться файл `truststore.jks`. Отдельная директория нужна, чтобы далее путь к файлу был корректно распознан в командах и конфигурационных файлах.

1. Импортируйте сертификаты из файла `YandexCA.crt` в файл `truststore.jks`:
   
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
               -storepass <пароль_защищенного_хранилища> \
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
               -storepass <пароль_защищенного_хранилища> \
               -noprompt

       rm "${cert}"
     done

     chmod 0655 /truststore/truststore.jks
     ```

   {% endlist %}

   Где `-storepass` — пароль хранилища сертификатов. Он должен содержать не менее 6 символов. Сохраните пароль — он понадобится для развертывания веб-интерфейса {{ KF }}.