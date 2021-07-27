---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Remove a tag from a queue

Use this request to remove a tag from the queue.

{% note warning %}

The tag cannot be deleted if it's used in at least one issue in the queue.

{% endnote %}

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To delete a tag, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format.

```json
POST /{{ ver }}/queues/<queue-id>/tags/_remove
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>

{
    "tag": "<tag name>"
}
```

#### Resource

- **\<queue-id\>**

    Queue ID or key. The queue key is case-sensitive.

#### Headers {#req-headers}

- **Host**

    Address of the node that provides the API:

    ```
    {{ host }}
    ```

- **Authorization**

    OAuth token in `OAuth <token value>` format. For example:

    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```

- **X-Org-ID**

    Organization ID.

#### Request body {#req-body-params}

| Parameter | Value | Data type |
| ----- | ----- | ----- |
| tag | Tag name. | String |

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    If the request is successful, the API returns a response with the code `204 No Content`. The response body is missing.

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

    422
    : The tag is used in the issue.

{% endlist %}