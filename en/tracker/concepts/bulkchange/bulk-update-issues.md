# Make bulk changes to issues

Use this request to change parameters for multiple issues at once.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To edit issues, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format.

```json
POST /{{ ver }}/bulkchange/_update
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>

{
  "issues": ["TEST-1", "TEST-2", "TEST-3"],
  "values": {
    "<parameter>": "<parameter value>",
    "<parameter>": "<parameter value>"
  }
}
```

#### Request parameters {#req-params}

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| notify | Flag indicating if users should be notified about issue changes:<ul><li>`true`: Users specified in the issue fields are notified.</li><li>`false` (by default): No users are notified.</li></ul> | Logical. |

#### Request body parameters {#req-body-params}

**Required parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| issues | IDs of issues to be edited. | String. |
| values | Issue parameters that will be updated. Use the parameters that are available when [editing the issue](../issues/patch-issue.md#req-get-params). | String. |

> Example: Edit issues.
>- An HTTP POST method is used.
>- The type for issues <q>TEST-1</q>, <q>TEST-2</q>, and <q>TEST-3</q> is changed to <q>Bug</q>.
>```
>POST /{{ ver }}/bulkchange/_update
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>X-Org-Id: <organization ID>
>{
>  "issues": ["TEST-1","TEST-2","TEST-3"],
>  "values": {
>    "type": {"name": "Bug"}
>  }
>}
>```

## Response format {#answer}

{% list tabs %}

- Successful execution of the request

    If the request is successful, the API returns a response with code `201 Created`.

    The response body contains information about the bulk change operation in JSON format.

    ```json
    {
        "id": "1ab23cd4e56789012fg345h6",
        "self": "https://api.tracker.yandex.net/v2/bulkchange/1ab23cd4e56789012fg345h6",
        "createdBy": {
            "self": "https://api.tracker.yandex.net/v2/users/1234567890",
            "id": "1234567890",
            "display": "First and Last name"
        },
        "createdAt": "2020-12-15T11:52:53.665+0000",
        "status": "CREATED",
        "statusText": "Bulk change task created.",
        "executionChunkPercent": 0,
        "executionIssuePercent": 0
    }
    ```

    #### Response parameters {#answer-params}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | id | Bulk change operation ID. | String. |
    | self | Address of the API resource with information about the bulk change. | String. |
    | [createdBy](#createdBy) | Object with information about the user who made the bulk change. | Object. |
    | createdAt | Date and time when the bulk change operation was created. | String. |
    | status | Bulk change operation status. | String. |
    | statusText | Description of the bulk change operation status. | String. |
    | executionChunkPercent | Service parameter. | Number. |
    | executionIssuePercent | Service parameter. | Number. |

    **Object fields** `createdBy` {#createdBy}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the user. | String. |
    | id | User ID. | Number. |
    | display | User's name displayed. | String. |

- The request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    400
    :   One or more request parameters have an invalid value.

    401
    :  The user isn't authorized. Make sure that actions described in [{#T}](../access.md) are performed.

    403
    :  Insufficient rights to perform this action. You can check what rights you have in the {{ tracker-name }} interface. The same rights are required to perform an action via the API and interface.

    422
    :  Validation error. The request body may contain an invalid or non-existent parameter.

{% endlist %}

