# Аутентификация

Сервис поддерживает аутентификацию через OAuth-токен.

{% include [datalens-api-oath](../../_includes/datalens/internal/oauth.md) %}

### Пример запроса {#example}

{% list tabs %}

- Для API воркбуков

  По умолчанию данные передаются в формате JSON. Вы можете изменить это поведение, указав формат YAML в `Content-Type: application/yaml` и `Accept: application/yaml`.

  Получить конфигурацию [воркбука](https://datalens.yandex-team.ru/navigation/za53cicd0cwqr-example-1) можно c помощью запроса:

  * JSON
  
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
    
  * YAML
  
    ```
    POST /external_api/v0/workbook/rpc HTTP/1.1
    Host: upload.datalens.yandex-team.ru
    Content-Type: application/yaml; charset=utf-8
    Accept: application/yaml
    
    kind: wb_read
    workbook_id: examples/API/example_1
    ```

    [Ответ в формате YAML](https://paste.yandex-team.ru/9068408)

- Для остальных API

  * cURL, используя строку path

    ```bash
    curl -X POST "https://charts.yandex-team.ru/api/run" \
      -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN" \
      -H "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
      --data-urlencode "path=/editor/Examples/parametrized-stat-graph"
    ```

  * cURL, используя хэш path

    ```bash
    curl -X POST "https://charts.yandex-team.ru/api/run" \
      -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN" \
      -H "Content-Type: application/json; charset=utf-8" \
      -d "{\"path\":\"editor/Examples/parametrized-stat-graph\"}"
    ```

{% endlist %}
