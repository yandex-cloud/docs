# Find out the number of issues

Use this request to find out the number of issues that meet the conditions of your request.

## Request format {#section_rnm_x4j_p1b}

Before making the request, [get permission to access the API](../access.md).

To get the number of issues that meet certain criteria, use an HTTP `POST` request. The search criteria are passed in the request body in JSON format:

```json
POST /v2/issues/_count
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
"filter": {
    "<field name>": "<field value>"
  },
  "query": "filter in the query language"
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Request body parameters" %}

**Additional parameters**

| Parameter | Description | Format |
| ----- | ----- | ----- |
| filter | Parameters for filtering issues. The parameter can specify any field and value to filter by. | Object |
| query | A filter using the [query language](../../user/query-filter.md). | String |

{% endcut %}

> Request for the number of issues with additional filtering options:
>
>- An HTTP POST method is used.
>- The response should only contain the number of issues from the <q>JUNE</q> queue that don't have an assignee.
>
>```
>POST /v2/issues/_count HTTP/1.1
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>{{ org-id }}
>
>{
>  "filter": {
>    "queue": "JUNE",
>    "assignee": "empty()"
>  }
>}
>```

## Response format {#section_xc3_53j_p1b}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response contains the number of issues that meet the conditions of your request.

    ```
    5221186
    ```

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

{% endlist %}

