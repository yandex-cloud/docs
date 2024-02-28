TrustStore — это хранилище доверенных сертификатов, которое используется в файлах JKS (Java KeyStore). Оно применяется для аутентификации клиента при его подключении к серверу. Сервер валидирует клиента с помощью сертификатов, которые хранятся в TrustStore. При этом клиент хранит приватный ключ и сертификат на своей стороне, в хранилище KeyStore.

В примере ниже TrustStore используется, чтобы подключиться к кластеру {{ mkf-name }}. Без создания TrustStore в веб-интерфейсе {{ KF }} не появится информация о кластере.

Чтобы использовать TrustStore:

1. Создайте SSL-сертификат:

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

1. Загрузите сертификат `YandexCA.crt` в файл `truststore.jks`:

   ```bash
   sudo keytool -import \
                -file {{ crt-local-dir }}YandexCA.crt \
                -alias "kafka-ui-cert" \
                -keystore /truststore/truststore.jks
   ```

   Команда предложит создать пароль. Запомните его — он понадобится для развертывания веб-интерфейса {{ KF }}.
