# Get priorities

Use this request to get a list of priorities for an issue.

## Request format {#section_rnm_x4j_p1b}

Before making the request, [get permission to access the API](../access.md).

To get a list of priorities, use an HTTP `GET` request:

```json
GET /v2/priorities
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| localized | Shows if the response contains translations. Possible values: <ul><li>`true`: The response only contains priority descriptions in the user's language. Default value.</li><li>`false`: The response contains priority descriptions in all supported languages.</li></ul> | Boolean |

{% endcut %}

> Example: Request for priorities
>
>- Use the HTTP GET method.
>
>```
>GET /v2/priorities?localized=false HTTP/1.1
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>{{ org-id }}
>```

## Response format {#section_xc3_53j_p1b}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains the results in JSON format.

    ```json
    [
        {
            "self": "{{ host }}/v2/priorities/5",
            "id": 5,
            "key": "blocker",
            "version": 1341632717561,
            "name": "Blocker",
            "order": 5
        },
        ...
    ]  
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Address of the API resource with information about the priority. | String |
    | id | Priority ID. | Number |
    | key | Priority key. | String |
    | version | Priority version. | Number |
    | name | Priority name displayed. If `localized=false` is passed in the request, this parameter duplicates the name in other languages. | String |
    | order | Priority weight. This parameter affects the order of priority display in the interface. | Number |

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

{% endlist %}

