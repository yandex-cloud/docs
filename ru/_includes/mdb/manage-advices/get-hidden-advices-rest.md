1. Получите IAM-токен для аутентификации в API и поместите токен в переменную среды окружения:

    {% include [api-auth-token](../../mdb/api-auth-token.md) %}

1. Воспользуйтесь [методом](../../../api-design-guide/concepts/about-adviser.md) `Issue.List` и выполните запрос, например, с помощью {{ api-examples.rest.tool }}, указав в параметре `visibilityFilter` значение `ISSUE_VISIBILITY_DISMISSED`:

    ```bash
    curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://adviser.{{ api-host }}/adviser/v1/resourceIssues' \
        --url-query cloudId=<идентификатор_облака>&folderId=<идентификатор_каталога>&resourceId=<идентификатор_кластера>&visibilityFilter=ISSUE_VISIBILITY_DISMISSED
    ```

    Где:

    * `cloudId` — идентификатор облака. Обязательный параметр.
    * `folderId` — идентификатор каталога. Если параметр не указан, сервер вернет рекомендации для всех каталогов облака.
    * `resourceId` — идентификатор кластера. Если параметр не указан, сервер вернет рекомендации для всех ресурсов каталога или облака.
    * `visibilityFilter` — фильтр видимости рекомендаций. Чтобы получить скрытые рекомендации, укажите значение `ISSUE_VISIBILITY_DISMISSED`.

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
          "visibility": "ISSUE_VISIBILITY_DISMISSED",
          "service": "mdb_adviser_cp_agent",
          "slug": "<db>_disk_autoscaling",
          "shortDescr": "Автомасштабирование дискового пространства не настроено",
          "fullDescr": "В шарде data-manager не настроено автомасштабирование дискового пространства. Настройте автомасштабирование для предотвращения переполнения диска.",
          "docUrl": "<ссылка на документацию>",
          "dismissalId": "...",
          "title": "Возможность автомасштабирования"
        },
        ...
      ]
    }
    ```

    {% endcut %}
