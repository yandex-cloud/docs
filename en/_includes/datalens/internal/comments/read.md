## Get a list of comments{#get}

`GET` `https://charts.yandex-team.ru/api/v1/comments`

Request parameters:

| Parameter | Description | Required / By default |
|:---|:---|:---
| feed | Comment feed | Required |
| dateFrom | ISO interval start date | Required |
| dateTo | ISO interval end date | Required |
| params | Clarifying parameters |
| matchType | Comment matching method: `contains` means clarifying parameters are a subset and `full` is full match. | `full` |

### Example query{#example-request-read}

```bash
curl -X GET "https://charts.yandex-team.ru/api/v1/comments?feed=comment%2Ffeed&dateFrom=2018-01-01T00%3A00%3A00.000Z&dateTo=2019-01-01T00%3A00%3A00.000Z&params\[scale\]=d&params\[region\]=RU"
```

### Response example {#example-response-read}

```json
[
  {
    "id": "69b7c450-59e5-11e8-a90e-f7c9d12c535d",
    "feed": "comment/feed",
    "creatorLogin": "username",
    "createdDate": "2017-12-31T23:59:59.000Z",
    "modifierLogin": null,
    "modifiedDate": null,
    "type": "band-x",
    "date": "2018-01-02T12:34:56.000Z",
    "dateUntil": "2018-02-03T23:45:12.000Z",
    "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    "meta": {
      "color": "#5a6ea9",
      "visible": true
    },
    "params": {
      "scale": ["d"],
      "region": ["RU"]
    }
  }
]
```
