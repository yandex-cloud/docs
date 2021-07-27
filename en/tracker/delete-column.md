---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Delete a column

Use this request to delete columns.

## Request format {#section_yrb_l2y_pfb}

To delete a column, use an HTTP `DELETE` request:

```json
DELETE /{{ ver }}/boards/<board-id>/columns/<column-id>
Host: {{ host }}
Authorization: OAuth <token>
X-Org-ID: <organization ID>
If-Match: "<version number>"
```

#### Resource {#req-resource}

- **\<board-id\>**

    Board ID.

- **\<column-id\>**

    Column ID.

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

- **If-Match**

    Number of the current board version.

## Response format {#section_tbv_lly_pfb}

{% list tabs %}

- Request executed successfully

    If the request is successful, the API returns a response with code 204. The response body is missing.

- Request failed

    If the request is processed incorrectly, the API returns a message with error details:

    | HTTP error code | Error description |
    | --------------- | --------------- |
    | 403 Forbidden | The user or application has no access rights to the resource, the request is rejected. |
    | 404 Not Found | The requested resource not found. |
    | 500 Internal Server Error | Internal service error. Try again later. |
    | 503 Service Unavailable | The API service is temporarily unavailable. |

{% endlist %}

