## Delete {#delete}

[Authentication](../../../../datalens/api/auth.md)

`DELETE` `https://api.dash.yandex.net/v1/dashboards/<id>`

### Example query{#example-request-delete-dash}

```bash
curl -X DELETE "https://api.dash.yandex.net/v1/dashboards/ujnm9ovaaewur" \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN"
```

### Response example {#example-response-delete-dash}

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
