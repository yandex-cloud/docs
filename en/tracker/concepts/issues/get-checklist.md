# Get checklist parameters

Use this request to get the parameters of the checklist in the issue.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get checklist parameters, use an HTTP `GET` request:

```json
GET /{{ ver }}/issues/<issue-id>/checklistItems
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Resource

- **\<issues-id\>**
   
   Issue ID or key.

{% include [headings](../../../_includes/tracker/api/headings.md) %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    If the request is successful, the API returns a response with code `200 OK`.

    The response body contains information about checklist items in JSON format.

    ```json
    {
        "id": "5fde5f0a1aee261dd3b62edb",
        "text": "Checklist item",
        "textHtml": "Item text in HTML format",
        "checked": false,
        "checklistItemType": "standard"
    }
    ```

    #### Response parameters

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | id | ID of the checklist item. | String |
    | text | Text of the checklist item. | String |
    | textHtml | Text of the checklist item in HTML format. | String |
    | checked | Flag indicating that the checklist item is completed:<ul><li>`true`: The item is marked as completed.</li><li>`false`: The item is not marked as completed.</li></ul> | Boolean |
    | checklistItemType | Type of the checklist item. | String |

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    400
    : One or more request parameters have an invalid value.

    401
    : The user isn't authorized. Make sure that actions described in the [API access](../access.md) section are performed.

    403
    : Insufficient rights to perform this action. You can check what rights you have in the {{ tracker-name }} interface. The same rights are required to perform an action via the API and interface.

    404
    : The requested object was not found. You may have specified an invalid object ID or key.

{% endlist %}

