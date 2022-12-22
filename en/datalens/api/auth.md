# Authentication

Service support OAuth token authentication.

{% include [datalens-api-oath](../../_includes/datalens/internal/oauth.md) %}

### Sample request {#example}

{% list tabs %}

- For Workbook API

   The data is transmitted in JSON format by default. You can change this behavior by specifying YAML in `Content-Type: application/yaml` and `Accept: application/yaml`.

   You can get the [workbook](https://datalens.yandex-team.ru/navigation/za53cicd0cwqr-example-1) configuration using the query:

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

      [The response in JSON format](https://paste.yandex-team.ru/9068273)

   * YAML

      ```
      POST /external_api/v0/workbook/rpc HTTP/1.1
      Host: upload.datalens.yandex-team.ru
      Content-Type: application/yaml; charset=utf-8
      Accept: application/yaml

      kind: wb_read
      workbook_id: examples/API/example_1
      ```

      [The response in YAML format](https://paste.yandex-team.ru/9068408)

- For all other API

   * cURL, using the path string

      ```bash
      curl -X POST "https://charts.yandex-team.ru/api/run" \
        -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN" \
        -H "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
        --data-urlencode "path=/editor/Examples/parametrized-stat-graph"
      ```

   * cURL, using the path hash

      ```bash
      curl -X POST "https://charts.yandex-team.ru/api/run" \
        -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN" \
        -H "Content-Type: application/json; charset=utf-8" \
        -d "{\"path\":\"editor/Examples/parametrized-stat-graph\"}"
      ```

{% endlist %}
