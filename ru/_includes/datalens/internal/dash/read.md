## Чтение {#read}

[Аутентификация](../../../../datalens/api/auth.md) • [Идентификация](../../../../datalens/api/identification.md)

`GET` `https://api.dash.yandex.net/v1/dashboards/<id>`

Для того, чтобы получить актуальную версию дашборда, необходимо добавить get-параметр `branch=published`. Без переданного параметра в ответ вернется последняя сохраненная версия (черновик), а не актуальная. Подробнее см. [Версионирование дашбордов](../../../../datalens/concepts/dashboard.md).

Если необходимо получить неактуальную версию (версия не является черновиком или актуальной), то добавляется get-параметр `revId=<revisionId>` со значением версии (например, `revId=a2tdb10qebvw2`).

### Пример запроса {#example-request-read-dash}

```bash
curl -X GET "https://api.dash.yandex.net/v1/dashboards/pjbe43i0rgw8m?branch=published" \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN"
```

### Пример ответа {#example-response-read-dash}

```json
{
  "entryId": "pjbe43i0rgw8m",
  "key": "Dash API Test/My Test API Dash",
  "data": {
    "tabs": [
      ...
    ],
  },
  ...
}
```
