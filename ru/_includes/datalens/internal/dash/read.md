## Чтение {#read}

[Аутентификация](../../../../datalens/api/auth.md) • [Идентификация](../../../../datalens/api/identification.md)

`GET` `https://api.dash.yandex.net/v1/dashboards/<id>`

### Пример запроса {#example-request-read-dash}

```bash
curl -X GET "https://api.dash.yandex.net/v1/dashboards/ujnm9ovaaewur" \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN"
```

### Пример ответа {#example-response-read-dash}

```json
{
  "entryId": "ujnm9ovaaewur",
  "key": "Dash API Test/My Test API Dash",
  "data": {
    "tabs": [
      ...
    ],
  },
  ...
}
```
