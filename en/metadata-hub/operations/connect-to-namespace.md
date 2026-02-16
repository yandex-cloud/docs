# Connecting to a namespace


To connect to a namespace, use cURL or Debezium.


Before connecting to a namespace, [create a service account](../../iam/operations/sa/create.md#create-sa) and assign it the relevant [roles](../security/schema-registry-roles.md).


{% list tabs group=instructions %}

- cURL

  1. Install the certificate:

      ```bash
      sudo mkdir --parents /usr/local/share/ca-certificates/Yandex && \
      sudo wget "https://crls.yandex.net/YandexInternalCA.crt" \
         --output-document /usr/local/share/ca-certificates/Yandex/IntermediateCA.crt && \
      sudo chmod 655 /usr/local/share/ca-certificates/Yandex/IntermediateCA.crt && \
      sudo update-ca-certificates
      ```

  
  1. Create an [API key](../../iam/concepts/authorization/api-key.md) with a limited scope and place it in the `SECRET` local variable:

      ```bash
      yc iam api-key create --folder-id <folder_ID> \
        --service-account-name <name_of_service_account_for_operations_with_Schema_Registry> \
        --scopes yc.schema-registry.schemas.manage \
        --expires-at '2030-01-01T00:00:00Z' >./api-key.yaml && \
      SECRET=`cat ./api-key.yaml | grep 'secret:' | awk '{print $2}'`
      ```

      If using a key with a limited scope, you can set any TTL you need.

  1. Connect to the namespace:

      ```bash
      curl -X GET "https://<namespace_ID>.{{ schema-registry-endpoint }}/subjects" \
         -H "accept: application/json" --user 'api-key:'$SECRET
      ```


- Debezium

  1. Install the certificate:

      ```bash
      sudo mkdir ./cert && \
      sudo wget "https://{{ s3-storage-host }}/cloud-certs/CA.pem" --output-document ./cert/CA.pem && \
      sudo openssl x509 -outform der -in ./cert/CA.pem -out ./cert/CA.der && \
      sudo keytool -importcert -noprompt -alias ca -file ./cert/CA.der -keystore ./cert/CA.p12 -storepass STOREPASSW0RD
      ```
  
  1. Download an up-to-date [Debezium connector](https://debezium.io/releases/) and unpack it to the `/etc/debezium/plugins/` directory.

  
  1. Create an [API key](../../iam/concepts/authorization/api-key.md) with a limited scope and place it in the `SECRET` local variable:

      ```bash
      yc iam api-key create --folder-id <folder_ID> \
        --service-account-name <name_of_service_account_for_operations_with_Schema_Registry> \
        --scopes yc.schema-registry.schemas.manage \
        --expires-at '2030-01-01T00:00:00Z' >./api-key.yaml && \
      SECRET=`cat ./api-key.yaml | grep 'secret:' | awk '{print $2}'`
      ```

      If using a key with a limited scope, you can set any TTL you need.

  1. Add the following parameters to the Debezium connector configuration file:

      ```bash
      "ssl.truststore.location": "/cert/CA.p12",
      "ssl.truststore.type": "PKCS12",
      "ssl.truststore.password": "STOREPASSW0RD",
      "value.converter": "io.confluent.connect.json.JsonSchemaConverter",
      "value.converter.schema.registry.url": "https://<namespace_ID>.{{ schema-registry-endpoint }}",
      "value.converter.basic.auth.credentials.source": "USER_INFO",
      "value.converter.basic.auth.user.info": "api-key:%SECRET%"
      ```


  1. To connect to the namespace, run Debezium.

{% endlist %}
