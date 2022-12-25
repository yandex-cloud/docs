## Create a comment {#create}

`POST` `https://charts.yandex-team.ru/api/v1/comments`

The values of general parameters are passed in the request body.

### Example query{#example-request-create}

```bash
curl -X POST "https://charts.yandex-team.ru/api/v1/comments" \
  -H "Content-Type: application/json" \
  -d '{
    "feed": "comment/feed",
    "type": "band-x",
    "date": "2018-01-02T12:34:56.000Z",
    "dateUntil": "2018-02-03T23:45:12.000Z",
    "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    "meta": {
      "color": "#5a6ea9",
      "visible": true
    },
    "params": {
      "scale": "d",
      "region": ["RU"]
    }
  }'
```

### Response example {#example-response-create}

```json
{
  "id": "69b7c450-59e5-11e8-a90e-f7c9d12c535d",
  "creatorLogin": "username",
  "createdDate": "2017-12-31T23:59:59.000Z"
}
```
