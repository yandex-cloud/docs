## Reads {#read}

[Authentication](../../../../datalens/api/auth.md)

`GET` `https://api.dash.yandex.net/v1/dashboards/<id>`

To get the latest version of the dashboard, you need to add the GET parameter `branch=published`. If the parameter is not passed, the last saved version (draft) is returned instead of the latest version. For more information, see [Dashboard versioning](../../../../datalens/concepts/dashboard.md).

If you need to get a version that is neither latest nor draft, add the GET parameter `revId=<revisionId>` with the version value (such as `revId=a2tdb10qebvw2`).

### Example query{#example-request-read-dash}

```bash
curl -X GET "https://api.dash.yandex.net/v1/dashboards/pjbe43i0rgw8m?branch=published" \
  -H "Authorization: OAuth $CHARTS_OAUTH_TOKEN"
```

### Response example {#example-response-read-dash}

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
