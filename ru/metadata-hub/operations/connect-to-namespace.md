# Подключение к пространству имен

Вы можете подключиться к пространству имен при помощи cURL или Debezium.


Перед подключением к пространству имен [создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) и назначьте ему нужные [роли](../security/schema-registry-roles.md).


{% list tabs group=instructions %}

- cURL

  1. Установите сертификат:

      ```bash
      sudo mkdir --parents /usr/local/share/ca-certificates/Yandex && \
      sudo wget "https://crls.yandex.net/YandexInternalCA.crt" \
         --output-document /usr/local/share/ca-certificates/Yandex/IntermediateCA.crt && \
      sudo chmod 655 /usr/local/share/ca-certificates/Yandex/IntermediateCA.crt && \
      sudo update-ca-certificates
      ```

  
  1. Создайте [API-ключ](../../iam/concepts/authorization/api-key.md) с ограниченной областью действия и поместите его в локальную переменную `SECRET`:

      ```bash
      yc iam api-key create --folder-id <идентификатор_каталога> \
        --service-account-name <имя_сервисного_аккаунта_для_работы_со_Schema_Registry> \
        --scope yc.schema-registry.schemas.manage \
        --expires-at '2030-01-01T00:00:00Z' >./api-key.yaml && \
      SECRET=`cat ./api-key.yaml | grep 'secret:' | awk '{print $2}'`
      ```

      Использование ключа с ограниченной областью действия позволяет выставить любой TTL.

  1. Подключитесь к пространству имен:

      ```bash
      curl -X GET "https://<идентификатор_пространства_имен>.{{ schema-registry-endpoint }}/subjects" \
         -H "accept: application/json" --user 'api-key:'$SECRET
      ```
  

- Debezium

  1. Установите сертификат:

      ```bash
      sudo mkdir ./cert && \
      sudo wget "https://{{ s3-storage-host }}/cloud-certs/CA.pem" --output-document ./cert/CA.pem && \
      sudo openssl x509 -outform der -in ./cert/CA.pem -out ./cert/CA.der && \
      sudo keytool -importcert -noprompt -alias ca -file ./cert/CA.der -keystore ./cert/CA.p12 -storepass STOREPASSW0RD
      ```
  
  1. Скачайте и распакуйте актуальный [Debezium-коннектор](https://debezium.io/releases/) в директорию `/etc/debezium/plugins/`.

  
  1. Создайте [API-ключ](../../iam/concepts/authorization/api-key.md) с ограниченной областью действия и поместите его в локальную переменную `SECRET`:

      ```bash
      yc iam api-key create --folder-id <идентификатор_каталога> \
        --service-account-name <имя_сервисного_аккаунта_для_работы_со_Schema_Registry> \
        --scope yc.schema-registry.schemas.manage \
        --expires-at '2030-01-01T00:00:00Z' >./api-key.yaml && \
      SECRET=`cat ./api-key.yaml | grep 'secret:' | awk '{print $2}'`
      ```

      Использование ключа с ограниченной областью действия позволяет выставить любой TTL.

  1. Добавьте в файл конфигурации коннектора Debezium следующие параметры:

      ```bash
      "ssl.truststore.location": "/cert/CA.p12",
      "ssl.truststore.type": "PKCS12",
      "ssl.truststore.password": "STOREPASSW0RD",
      "value.converter": "io.confluent.connect.json.JsonSchemaConverter",
      "value.converter.schema.registry.url": "https://<идентификатор_пространства_имен>.{{ schema-registry-endpoint }}",
      "value.converter.basic.auth.credentials.source": "USER_INFO",
      "value.converter.basic.auth.user.info": "api-key:%SECRET%"
      ```
  

  1. Чтобы подключиться к пространству имен, запустите Debezium.

{% endlist %}
