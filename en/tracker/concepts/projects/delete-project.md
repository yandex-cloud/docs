# Delete a project

Use this request to delete [projects](../../manager/projects.md).

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To delete a project, use an HTTP `DELETE` request.

```
DELETE /{{ ver }}/projects/<project-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Request parameters

**Resource**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<project-id> | Project ID. | Number. |

## Response format {#answer}

{% list tabs %}

- Successful execution of the request

    If the project is deleted, the API returns a response with code `204 No Content`.

- The request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    401
    :  The user isn't authorized. Make sure that actions described in the [API access](../access.md) section are performed.

    403
    :  Insufficient rights to perform this action. You can check what rights you have in the {{ tracker-name }} interface. The same rights are required to perform an action via the API and interface.

    404
    :   The requested object was not found. You may have specified an invalid object ID or key.

{% endlist %}

