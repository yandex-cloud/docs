# Get queue versions

Use this request to get information about [queue versions](../../manager/versions.md). The queue is selected when the ID or key is specified.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get queue versions, use an HTTP `GET` request.

```
GET /v2/queues/<queue-id>/versions
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<queue-id\> | Queue ID or key. The queue key is case-sensitive. | String or number |

{% endcut %}

> Example: Get `TEST` queue versions.
>
>- An HTTP `GET` method is used.
>
>```
>GET /v2/queues/TEST/versions HTTP/1.1
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>{{ org-id }}
>```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

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

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Link to the version object | String |
    | id | Version ID | Number |
    | version | Version number | Number |
    | [queue](#queue) | Object with information about the queue | Object |
    | name | Version name | String |
    | description | Text description of the version | String |
    | startDate | Start date of the queue | String |
    | dueDate | End date of the queue | String |
    | released | Flag of the released version | Boolean |
    | archived | Flag of the archived version | Boolean |

    **Object fields** `queue` {#queue}

    {% include [queue](../../../_includes/tracker/api/queue.md) %}

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

