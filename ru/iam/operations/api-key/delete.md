# Удаление API-ключа

{% list tabs %}

- CLI

  1. Посмотрите список API-ключей для сервисного аккаунта, указав его имя, например `my-robot`:

      ```bash
      yc iam api-key list --service-account-name my-robot
      ```

      По умолчанию для поиска сервисного аккаунта используется каталог, указанный в профиле CLI. Вы можете указать другой каталог с помощью флага `--folder-name` или `--folder-id`.

  1. Удалите API-ключ, указав его идентификатор:

      ```bash
      yc iam api-key delete <API-KEY-ID>
      ```

- API

  1. Удалите API-ключ с помощью метода [delete](../../api-ref/ApiKey/delete.md) для ресурса [ApiKey](../../api-ref/ApiKey/index.md):

      ```bash
      export APIKEY_ID=ajeke74kbp5bfq7m6ka2
      export IAM_TOKEN=CggaATEVAgA...
      curl -X DELETE -H "Authorization: Bearer $IAM_TOKEN" \
        https://iam.api.cloud.yandex.net/iam/v1/apiKeys/$APIKEY_ID
      ```

{% endlist %}
