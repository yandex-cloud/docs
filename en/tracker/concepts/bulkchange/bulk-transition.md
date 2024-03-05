---
sourcePath: en/tracker/api-ref/concepts/bulkchange/bulk-transition.md
---
# Bulk changes to issue statuses

Use this request to complete a transition to a new status for multiple issues at the same time.

{% note info %}

To find out what status transitions are available for an issue, make a [request for a list of transitions](../issues/get-transitions.md). For some statuses, e.g., **Closed**, the request body needs to specify the [resolution]({{ link-admin-resolutions }}) in the `value` parameter.

{% endnote %}

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To update issue statuses, use an HTTP `POST` request. Request parameters are provided in the request body in JSON format.

```json
POST /{{ ver }}/bulkchange/_transition
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
  "transition": "start_progress",
  "issues": ["TEST-1","TEST-2","TEST-3"]
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| notify | Flag indicating if users should be notified about issue changes:<ul><li>`true`: Users specified in the issue fields are notified.</li><li>`false` (by default): No users are notified.</li></ul> | Logical |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| transition | Transition ID. | String |
| issues | IDs of the issues to change the status of. | String |

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| values | Issue parameters that will be updated after the status change. Use the parameters that are available when [editing the issue](../issues/patch-issue.md#req-get-params). | String |

{% endcut %}

> Example. Bulk change of multiple issues' statuses.
>
> - An HTTP POST method is used.
> - The status for the **TEST-1**, **TEST-2**, and **TEST-3** issues changes to **Closed** with the **Resolved** resolution.
>
> ```json
> POST /{{ ver }}/bulkchange/_transition
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
> {
> "transition": "close",
> "issues": ["TEST-1", "TEST-2", "TEST-3"],
> "values": {
>    "resolution": "fixed"
>   }
> }
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

   The response body contains information about the bulk change operation in JSON format.

   ```json
   {
       "id": "1ab23cd4e5678901********",
       "self": "https://{{ host }}/v2/bulkchange/1ab23cd4e5678901********",
       "createdBy": {
           "self": "https://{{ host }}/v2/users/12********",
           "id": "12********",
           "display": "Full name"
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
   -------- | -------- | ----------
   | id | Bulk change operation ID. | String |
   | self | Address of the API resource with information about the bulk change. | String |
   | [createdBy](#createdBy) | Object with information about the user who made the bulk change. | Object |
   | createdAt | Date and time when the bulk change operation was created. | String |
   | status | Bulk change operation status. | String |
   | statusText | Description of the bulk change operation status. | String |
   | executionChunkPercent | Service parameter | Number |
   | executionIssuePercent | Service parameter | Number |

   `createdBy` **object fields** {#createdBy}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the user. | String |
   | id | User ID. | Number |
   | display | Displayed user name. | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-401.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}

