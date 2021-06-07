# Delete a queue

Use this request to delete queues.

## Request format {#section_nnm_hdt_sfb}

To delete a queue, use an HTTP `DELETE` request:

```json
DELETE /{{ ver }}/queues/<queue-id>
Host: {{ host }}
Authorization: OAuth <token>
X-Org-ID: <organization ID> 
```

#### Resource {#req-resource}

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

## Response format {#section_p1j_lgt_sfb}

{% list tabs %}

- Request executed successfully

  If the request is successful, the API returns a response with code 204. The response body is missing.

- Request failed

  If the request is processed incorrectly, the API returns a message with error details:

  | HTTP error code | Error description |
  | ----- | ----- |
  | 403 Forbidden | The user or application has no access rights to the resource, the request is rejected. |
  | 404 Not Found | The requested resource not found. |
  | 500 Internal Server Error | Internal service error. Try again later. |
  | 503 Service Unavailable | The API service is temporarily unavailable. |

{% endlist %}

