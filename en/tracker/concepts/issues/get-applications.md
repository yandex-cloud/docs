---
sourcePath: en/tracker/api-ref/concepts/issues/get-applications.md
---
# Get a list of external applications

Use this request to get a list of applications to which you can [create a link](../../external-links.md).

## Request format {#query}

To get a list of available external applications, use an HTTP `GET` request:

```json
GET /{{ ver }}/applications
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains information about external applications in JSON format.

    ```json
    [
        {
            "self": "{{ host }}/{{ ver }}/applications/my-application",
            "id": "my-application",
            "type": "my-application",
            "name": "Application name"
        },
        ...
    ]
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Address of the API resource with information about the application. | String |
    | id | Application ID. | String |
    | type | Application type. The same as the `id` parameter value. | String |
    | name | Application name. | String |

    {% endcut %}

- Request failed

    {% include [400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [500](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [500](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}

