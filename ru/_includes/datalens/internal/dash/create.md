## Создание {#create}

[Аутентификация](../../../../datalens/api/auth.md) • [Идентификация](../../../../datalens/api/identification.md)

`POST` `https://api.dash.yandex.net/v1/dashboards`

* `key` - путь до дашборда (**Примечание**: папки должны быть созданы заранее)
* `data` - схема дашборда

### Пример запроса {#example-request-create-dash}

```bash
curl -X POST "https://api.dash.yandex.net/v1/dashboards" \
  -H "Content-Type: application/json; charset=utf-8" \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN" \
  -d '{
    "key": "Dash API Test/My Test API Dash",
    "data": {
      "tabs": [
          {
            "id": "WR",
            "items": [
              {
                "id": "wmz",
                "data": {
                  "tabs": [
                    {
                      "id": "7r5",
                      "title": "Profit dynamics by product category",
                      "chartId": "7zpf4m1d48zg6"
                    }
                  ]
                },
                "type": "widget",
                "defaults": {},
                "namespace": "default"
              }
            ],
            "title": "Sales",
            "layout": [
              {
                "h": 15,
                "i": "wmz",
                "w": 19,
                "x": 0,
                "y": 0
              }
            ],
            "aliases": {},
            "connections": []
          }
        ]
    }
  }'
```

### Пример ответа {#example-response-create-dash}

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
