# Сделать контейнер публичным

Чтобы любой пользователь мог вызвать контейнер без передачи заголовка авторизации, сделайте контейнер публичным.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится контейнер.
  1. Перейдите в сервис **Serverless Containers**.
  1. Выберите контейнер, который хотите сделать публичным.
  1. На вкладке **Обзор** включите опцию **Публичный контейнер**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
    
    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы сделать контейнер публичным, выполните команду:

    ```bash
    yc serverless container allow-unauthenticated-invoke <имя_контейнера>
    ```

    Результат:

    ```text
    done (1s)
    ```

- API {#api}

  Чтобы сделать контейнер публичным, воспользуйтесь методом REST API [setAccessBindings](../containers/api-ref/Container/setAccessBindings.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/SetAccessBindings](../containers/api-ref/grpc/Container/setAccessBindings.md).

  **Пример запроса**

  Чтобы воспользоваться примером, установите [cURL](https://curl.haxx.se) и [аутентифицируйтесь](../api-ref/containers/authentication.md) в API.

  1. Подготовьте файл `body.json` с телом запроса:

      ```json
      {
        "accessBindings": [
          {
            "roleId": "serverless-containers.containerInvoker",
            "subject": {
              "id": "allUsers",
              "type": "system"
            }
          }
        ]
      }
      ```

      Где:
      * `roleId` — роль, которую нужно назначить. Вызывать контейнер позволяет роль `serverless-containers.containerInvoker`.
      * `id` — субъект, которому нужно назначить роль. `allUsers` — любой пользователь, прохождение аутентификации не требуется.
      * `type` — тип субъекта, которому назначается роль. `system` — [публичная группа](../../iam/concepts/access-control/public-group.md).

  1. Выполните запрос, указав IAM-токен, путь к файлу `body.json` и идентификатор контейнера:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer <IAM-токен>" \
          --data "@<путь_к_файлу_body.json>" \
          https://serverless-containers.api.cloud.yandex.net/containers/v1/containers/<идентификатор_контейнера>:setAccessBindings
      ```

      Результат:

      ```json
      {
       "done": false,
       "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.access.SetAccessBindingsMetadata",
        "resourceId": "bba8dkc667bj********"
       },
       "id": "bbaoi3jn8plq********",
       "description": "operationSetAccessBindings",
       "createdAt": "2023-12-22T10:30:58.348672821Z",
       "createdBy": "aje07l4q4vmo********",
       "modifiedAt": "2023-12-22T10:30:58.348672821Z"
      }
      ```

  1. Убедитесь, что роль назначена. Для этого выполните запрос, указав IAM-токен и идентификатор контейнера:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer <IAM-токен>" \
          https://serverless-containers.api.cloud.yandex.net/containers/v1/containers/<идентификатор_контейнера>:listAccessBindings
      ```

      Результат:

      ```json
      {
       "accessBindings": [
        {
         "subject": {
          "id": "allUsers",
          "type": "system"
         },
         "roleId": "serverless.containers.invoker"
        }
       ]
      }
      ```

{% endlist %}