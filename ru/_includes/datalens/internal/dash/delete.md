## Удаление {#delete}

[Аутентификация](../../../../datalens/api/auth.md) • [Идентификация](../../../../datalens/api/identification.md)

`DELETE` `https://api.dash.yandex.net/v1/dashboards/<id>`

### Пример запроса

```bash
curl -X DELETE "https://api.dash.yandex.net/v1/dashboards/ujnm9ovaaewur" \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN"
```

### Пример ответа

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
