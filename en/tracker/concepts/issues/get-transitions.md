---
sourcePath: en/tracker/api-ref/concepts/issues/get-transitions.md
---
# Getting transitions

Use this request to get a list of possible issue transitions. The issue is selected when its ID or key is specified.

## Request format {#section_rnm_x4j_p1b}

Before making the request, [get permission to access the API](../access.md).

To get a list of possible transitions, use an HTTP `GET` request:

```json
GET /v2/issues/<issue-id>/transitions
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %}

## Response format {#section_xc3_53j_p1b}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains the results in JSON format.

    ```json
    [
        {
            "id": "resolve",
            "self": "https://{{ host }}/v2/issues/JUNE-2/transitions/resolve",
            "display": "Resolve",
            "to": {
                "self": "https://{{ host }}/v2/statuses/1",
                "id": "1",
                "key": "open",
                "display": "Open"
            }
        },
        ...
    ]
    ```

  {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | id | Transition ID. | String |
    | self | Address of the API resource with information about the transition. | String |
    | display | Transition name displayed. Matches the corresponding button name in the {{ tracker-name }} interface. | String |
    | [to](#to) | Object with information about a new issue status. | Object |

    `to` **object fields** {#to}

    {% include [status](../../../_includes/tracker/api/status.md) %}

  {% endcut %}

- Request failed

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}
