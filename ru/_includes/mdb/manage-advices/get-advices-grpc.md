1. Получите IAM-токен для аутентификации в API и поместите токен в переменную среды окружения:

    {% include [api-auth-token](../../mdb/api-auth-token.md) %}

1. {% include [grpc-api-setup-repo](../../mdb/grpc-api-setup-repo.md) %}

1. Воспользуйтесь [вызовом](../../../api-design-guide/concepts/about-adviser.md) `IssueService.List` и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/adviser/v1/issue_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
                "cloud_id": "<идентификатор_облака>",
                "folder_id": "<идентификатор_каталога>",
                "resource_id": "<идентификатор_кластера>"
            }' \
        adviser.{{ api-host }}:{{ port-https }} \
        yandex.cloud.adviser.v1.IssueService.List
    ```

    Где:

    * `cloud_id` — идентификатор облака. Обязательный параметр.
    * `folder_id` — идентификатор каталога. Если параметр не указан, сервер вернет рекомендации для всех каталогов облака.
    * `resource_id` — идентификатор кластера. Если параметр не указан, сервер вернет рекомендации для всех ресурсов каталога или облака.

1. Убедитесь, что запрос был выполнен успешно, изучив ответ сервера.

    {% cut "Пример ответа" %}

    ```json
    {
      "issues": [
        {
          "id": "1090...",
          "resource": {
            "type": "RESOURCE_TYPE_MANAGED_<DB>",
            "resourceId": "c9ql6kum9...",
            "folderId": "b1g681qpe...",
            "cloudId": "b1gia87mb..."
          },
          "createdAt": "2026-11-26T19:34:44.232731Z",
          "updatedAt": "2026-11-26T19:34:44.232731Z",
          "state": "ISSUE_STATE_ACTIVE",
          "severity": "ISSUE_SEVERITY_INFO",
          "category": "ISSUE_CATEGORY_FAULT_TOLERANCE",
          "visibility": "ISSUE_VISIBILITY_VISIBLE",
          "service": "mdb_adviser_cp_agent",
          "slug": "<db>_disk_autoscaling",
          "shortDescr": "Автомасштабирование дискового пространства не настроено",
          "fullDescr": "В шарде data-manager не настроено автомасштабирование дискового пространства. Настройте автомасштабирование для предотвращения переполнения диска.",
          "docUrl": "<ссылка_на_документацию>",
          "title": "Возможность автомасштабирования"
        },
        ...
      ]
    }
    ```

    {% endcut %}
