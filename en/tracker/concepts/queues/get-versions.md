---
sourcePath: en/tracker/api-ref/concepts/queues/get-versions.md
---
# Get queue versions

Use this request to get information about [queue versions](../../manager/versions.md). The queue is selected when the ID or key is specified.

## Request format {#section_rnm_x4j_p1b}

To get queue versions, use an HTTP `GET` request:

```json
GET /v2/queues/<queue-id>/versions
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Request parameters {#req-get-params}

- **\<queue-id\>**

    Queue ID or key. The queue key is case-sensitive.

> Request for the <q>TEST</q> queue's versions:
>- Use the HTTP GET method.
>```
>GET /v2/queues/TEST/versions HTTP/1.1
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>X-Org-Id: <organization ID>
>Cache-Control: no-cache
>```

## Response format {#section_xc3_53j_p1b}

```json
[
    {
        "self": "{{ host }}/v2/versions/49650",
        "id": 49650,
        "version": 1,
        "queue": {
            "self": "{{ host }}/v2/queues/JUNE",
            "id": "1928",
            "key": "JUNE",
            "display": "june"
        },
        "name": "version1",
        "description": "iohb ±!@#$%^&*()_+=-/\\?<>.,/§:»'|;",
        "startDate": "2017-06-09",
        "dueDate": "20227-06-09",
        "released": false,
        "archived": false
    },
    ...
]
```

#### Response parameters {#answer-params}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the version object. | String |
| id | Version ID. | Number |
| version | Version number. | Number |
| [queue](#queue) | Object with information about the queue. | Object |
| name | Version name. | String |
| description | Text description of the version. | String |
| startDate | Start date of the queue. | String |
| dueDate | End date of the queue. | String |
| released | Flag of the released version. | Boolean |
| archived | Flag of the archived version. | Boolean |

**Object fields** `queue` {#queue}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Queue link. | String |
| id | Queue ID. | String |
| key | Queue key. | String |
| display | Queue name displayed. | String |

## Possible response codes {#section_otf_jrj_p1b}

200
:   Request executed successfully.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

