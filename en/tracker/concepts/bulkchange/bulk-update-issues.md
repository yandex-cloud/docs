---
sourcePath: en/tracker/api-ref/concepts/bulkchange/bulk-update-issues.md
---
# Make bulk changes to issues

Use this request to change parameters for multiple issues at once.

{% note info %}

The maximum number of issues per change is 10,000.

{% endnote %}

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To edit issues, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format.

```json
POST /{{ ver }}/bulkchange/_update
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
  "issues": ["TEST-1", "TEST-2", "TEST-3"],
  "values": {
    "<parameter>": "<parameter value>",
    "<parameter>": "<parameter value>"
  }
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| notify | Flag indicating if users should be notified about issue changes:<ul><li>`true`: Users specified in the issue fields are notified.</li><li>`false` (by default): No users are notified.</li></ul> | Logical |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| issues | Array of issue IDs or a filter in the [query language](../../user/query-filter.md). | Array or String |
| values | Issue parameters that will be updated. Use the parameters that are available when [editing the issue](../issues/patch-issue.md#req-get-params). | String |

{% endcut %}

> Example 1: Edit issues.
>
>- An HTTP POST method is used.
>- The type for issues <q>TEST-1</q>, <q>TEST-2</q>, and <q>TEST-3</q> is changed to <q>Bug</q>.
>
>```json
>POST /{{ ver }}/bulkchange/_update
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>{{ org-id }}
>{
>  "issues": ["TEST-1","TEST-2","TEST-3"],
>  "values": {
>    "type": {"name": "Error"}
>  }
>}
> ```

> Example 2: Edit issues using a filter in the query language.
>
>- An HTTP POST method is used.
>- For issues with the word `Test` in their names, the priority changes to `Blocker` and a comment saying "Updated via API" is added.
>
>```json
>POST /{{ ver }}/bulkchange/_update
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>{{ org-id }}
>{
>  "issues": "Summary: Test"
>  "values": {
>    "comment": "Updated via API",
>    "priority": {"key": "blocker"}
>  }
>}
>```
## Response format {#answer}

{% list tabs %}

- The request is executed successfully

    {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

    The response body contains information about the bulk change operation in JSON format.

    ```json
    {
        "id": "1ab23cd4e56789012fg345h6",
        "self": "{{ host }}/v2/bulkchange/1ab23cd4e56789012fg345h6",
        "createdBy": {
            "self": "{{ host }}/v2/users/1234567890",
            "id": "1234567890",
            "display": "First and last name"
        },
        "createdAt": "2020-12-15T11:52:53.665+0000",
        "status": "CREATED",
        "statusText": "Bulk change task created.",
        "executionChunkPercent": 0,
        "executionIssuePercent": 0
    }
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | id | Bulk change operation ID | String |
    | self | Address of the API resource with information about the bulk change | String |
    | [createdBy](#createdBy) | Object with information about the user who made the bulk change. | Objects |
    | createdAt | Date and time when the bulk change operation was created. | String |
    | status | Bulk change operation status | String |
    | statusText | Description of the bulk change operation status | String |
    | executionChunkPercent | Service parameter | Number |
    | executionIssuePercent | Service parameter | Number |

    **Object fields** `createdBy` {#createdBy}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the user | String |
    | id | User ID | Number |
    | display | Displayed user name | String |

    {% endcut %}

- The request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
