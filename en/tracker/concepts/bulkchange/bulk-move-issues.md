# Perform a bulk move of issues to a different queue

Use this request to move multiple issues to another queue at once.

Before executing the request, make sure the user has permission to edit the issues to be moved and is allowed to create them in the new queue.

{% note warning %}

If an issue you want to move has a type and status that are missing in the target queue, no transfer will be made. To reset the issue status to the initial value when moving it, use the `InitialStatus` parameter.

By default, when an issue is moved, the values of its components, versions, and projects are cleared. If the new queue has the same values of the fields specified, use the `MoveAllFields` parameter to move the components, versions, and projects.

{% endnote %}

## Request format {#section_rnm_x4j_p1b}

Before making the request, [get permission to access the API](../access.md).

To move issues to another queue, use an HTTP `POST` request:

```json
POST /{{ ver }}/bulkchange/_move
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>

{
  "queue": "<queue key>",
  "issues": ["TEST-1, TEST-2, TEST-3"]
}
```

#### Request parameters {#req-params}

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| notify | Flag indicating if users should be notified about issue changes:<ul><li>`true`: Users specified in the issue fields are notified.</li><li>`false` (by default): No users are notified.</li></ul> | Boolean |

#### Request body parameters {#req-body-params}

**Required parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| queue | [Key of the queue](../../manager/create-queue.md#key) to move the issues to. | String |
| issues | IDs of the issues to be moved. | String |

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| values | Issue parameters that will be updated during the move. Use the parameters that are available when [editing the issue](../issues/patch-issue.md#req-get-params). | String |
| moveAllFields | Shows whether to move the issue's versions, components, and projects to the new queue:<ul><li>`true`: Move them if the new queue has similar versions, components, and projects.</li><li>`false` (by default): Clear the versions, components, and projects.</li></ul> | Boolean |
| initialStatus | Resetting the issue status. The status is reset if the issue is moved to another queue with a different [workflow](../../manager/add-workflow.md):<ul><li>`true`: Reset the status.</li><li>`false` (by default): Retain the current status.</li></ul> | Boolean |

> Example: Move issues.
> - An HTTP POST method is used.
> - The issues <q>TEST-1</q>, <q>TEST-2</q>, and <q>TEST-3</q> are moved to the <q>CHECK</q> queue.
> - Each issue moved is assigned the <q>moved</q> tag.
>```
>POST /{{ ver }}/bulkchange/_move
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>X-Org-Id: <organization ID>
>{
>  "queue": "CHECK",
>  "issues": ["TEST-1","TEST-2","TEST-3"],
>  "values": {
>    "tags": {
>      "add": ["moved"]
>    }
>  },
>  "moveAllFields": true
>}
>```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    If the request is successful, the API returns a response with code `201 Created`.

    The response body contains information about the bulk move operation in JSON format.

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
    | id | Bulk change operation ID. | String |
    | self | Address of the API resource with information about the bulk change. | String |
    | [createdBy](#createdBy) | Object with information about the user who made the bulk change. | Object |
    | createdAt | Date and time when the bulk change operation was created. | String |
    | status | Bulk change operation status. | String |
    | statusText | Description of the bulk change operation status. | String |
    | executionChunkPercent | Service parameter. | Number |
    | executionIssuePercent | Service parameter. | Number |

    **Object fields** `createdBy` {#createdBy}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the user. | String |
    | id | User ID. | Number |
    | display | User's name displayed. | String |

- Request failed

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

