{% list tabs %}

- Консоль управления

  Чтобы добавить сертификат в федерацию:

  1. Откройте страницу каталога в [консоли управления]({{ link-console-main }}).
  1. В меню слева выберите вкладку **Федерации**.
  1. Нажмите на имя федерации, которой вы хотите добавить сертификат.
  1. Нажмите на кнопку **Добавить сертификат** внизу страницы.
  1. Выберите способ добавления сертификата:
      * Чтобы добавить сертификат в виде файла, нажмите **Выбрать файл** и укажите путь к нему.
      * Чтобы вставить скопированное содержимое сертификата, выберите способ **Текст** и вставьте содержимое.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды добавления сертификата:

      ```
      yc iam certificate create --help
      ```

  1. Добавьте сертификат для федерации, указав путь к файлу сертификата:

      ```
      yc iam certificate create --federation-name my-federation \
        --name "my-certificate" \
        --certificate-file test.pem
      ```

- API

  Чтобы добавить сертификат, воспользуйтесь методом [create](../../iam/api-ref/Certificate/create.md) для ресурса [Certificate](../../iam/api-ref/Certificate/index.md):

  1. Сформируйте тело запроса, указав содержимое сертификата в свойстве `data`:

      ```json
      {
        "federationId": "<ID федерации>",
        "name": "my-certificate",
        "data": "MII...=="
      }
      ```

  2. Отправьте запрос на добавление сертификата:

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \
          "https://iam.{{ api-host }}/iam/v1/saml/certificates"
      ```

{% endlist %}
