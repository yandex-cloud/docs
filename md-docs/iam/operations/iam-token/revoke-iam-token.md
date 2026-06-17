# Отзыв IAM-токена

Полученный ранее [IAM-токен](../../concepts/authorization/iam-token.md) можно отозвать. Например, это может потребоваться при его [компрометации](../compromised-credentials.md) или при получении нового IAM-токена.

Чтобы отозвать IAM-токен:

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды отзыва IAM-токена:

      ```bash
      yc iam revoke-token --help
      ```

  1. Отзовите IAM-токен, указав его в команде:

      ```bash
      yc iam revoke-token \
        --iam-token "<IAM-токен>"
      ```

      Результат:

      ```text
      subject_id: ajei280a73vc********
      ```

- API {#api}

  Выполните http-запрос, указав отзываемый IAM-токен:

  ```bash
  curl \
    --request POST \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer <IAM-токен>" \
    --data '{
        "iamToken": "<IAM-токен>"
    }' \
    https://iam.api.cloud.yandex.net/iam/v1/tokens:revoke
  ```

  Результат:

  ```json
  {
    "subjectId": "ajei280a73vc********"
  }

{% endlist %}

#### Полезные ссылки {#see-also}

* [Получение IAM-токена для аккаунта на Яндексе](create.md)
* [Получение IAM-токена для федеративного аккаунта](create-for-federation.md)
* [Получение IAM-токена для сервисного аккаунта](create-for-sa.md)