# Аутентификация

Сервис поддерживает аутентификацию через OAuth-токен.

{% include [datalens-api-oath](../../../_includes/datalens/internal/oauth.md) %}

### Пример запроса {#example}

По умолчанию данные передаются в формате JSON. Вы можете изменить это поведение, указав формат YAML в `Content-Type: application/yaml` и `Accept: application/yaml`.

Получим конфигурацию [воркбука](https://datalens.yandex-team.ru/navigation/za53cicd0cwqr-example-1) c помощью запроса:

{% list tabs %}

- JSON
  
    ```
    POST /external_api/v0/workbook/rpc HTTP/1.1
    Host: upload.datalens.yandex-team.ru
    Content-Type: application/json; charset=utf-8
    Accept: application/json
    
    {
        "kind": "wb_read",
        "workbook_id": "examples/API/example_1"
    }
    ```
    [Ответ в формате JSON](https://paste.yandex-team.ru/9068273)
    
- YAML
  
    ```
    POST /external_api/v0/workbook/rpc HTTP/1.1
    Host: upload.datalens.yandex-team.ru
    Content-Type: application/yaml; charset=utf-8
    Accept: application/yaml
    
    kind: wb_read
    workbook_id: examples/API/example_1
    ```

    [Ответ в формате YAML](https://paste.yandex-team.ru/9068408)

{% endlist %}