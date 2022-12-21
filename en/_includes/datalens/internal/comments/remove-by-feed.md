## Delete a comment{#remove-feed}

`DELETE` `https://charts.yandex-team.ru/api/v1/comments?feed={feed}`

In the query parameter of a query, a comment feed is passed.

### Example query{#example-request-rbf}

```bash
curl -X DELETE "https://charts.yandex-team.ru/api/v1/comments?feed=apanchuk/sales-by-region" \
  -H "Content-Type: application/json" \
```

### Response example {#example-response-rbf}

```json
[
  "69b7c450-59e5-11e8-a90e-f7c9d12c535d"
]
```
