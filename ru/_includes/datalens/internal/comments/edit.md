## Редактировать комментарий {#update}

`POST` `https://charts.yandex-team.ru/api/v1/comments/{id}`

В теле запроса передаются значения общих параметров.

### Пример запроса {#example-request-edit}

```bash
curl -X POST "https://charts.yandex-team.ru/api/v1/comments/69b7c450-59e5-11e8-a90e-f7c9d12c535d" \
  -H "Content-Type: application/json" \
  -d '{
    "feed": "comment/feed",
    "type": "line-x",
    "date": "2018-01-02T12:34:56.000Z",
    "text": "Nunc quis luctus diam, quis tincidunt velit",
    "meta": {
      "color": "#3b5998"
    }
  }'
```

### Пример ответа {#example-response-edit}

```json
{
  "id": "69b7c450-59e5-11e8-a90e-f7c9d12c535d",
  "modifierLogin": "username",
  "modifiedDate": "2018-01-01T12:34:56.000Z"
}
```
