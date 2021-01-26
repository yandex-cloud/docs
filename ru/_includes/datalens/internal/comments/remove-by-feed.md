## Удалить комментарии

`DELETE` `https://charts.yandex-team.ru/api/v1/comments?feed={feed}`

В query-параметре запроса передается канал комментариев.

### Пример запроса

```bash
curl -X DELETE "https://charts.yandex-team.ru/api/v1/comments?feed=apanchuk/sales-by-region" \
  -H "Content-Type: application/json" \
```

### Пример ответа

```json
[
  "69b7c450-59e5-11e8-a90e-f7c9d12c535d"
]
```
