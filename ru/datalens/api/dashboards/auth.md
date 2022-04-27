# Аутентификация

Сервис поддерживает аутентификацию следующими способами:
  - Domain Cookie
  - OAuth-токен
    

{% include [datalens-api-oath](../../../_includes/datalens/internal/oauth.md) %}

### Пример (cURL, используя строку path) {#example-string-path}

```bash
curl -X POST "https://charts.yandex-team.ru/api/run" \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN" \
  -H "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --data-urlencode "path=/editor/Examples/parametrized-stat-graph"
```

### Пример (cURL, используя хэш path) {#example-hash-path}

```bash
curl -X POST "https://charts.yandex-team.ru/api/run" \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "{\"path\":\"editor/Examples/parametrized-stat-graph\"}"
```
