## Удаление {#delete}

[Аутентификация](../../../../datalens/api/dashboards/auth.md) • [Идентификация](../../../../datalens/api/dashboards/identification.md)

`DELETE` `https://api.dash.yandex.net/v1/dashboards/<id>`

### Пример запроса {#example-request-delete-dash}

```bash
curl -X DELETE "https://api.dash.yandex.net/v1/dashboards/ujnm9ovaaewur" \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN"
```

### Пример ответа {#example-response-delete-dash}

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
