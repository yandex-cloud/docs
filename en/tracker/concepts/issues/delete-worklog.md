---
sourcePath: en/tracker/api-ref/concepts/issues/delete-worklog.md
---
# Delete a record of time spent

Use this request to delete a record of the time spent on an issue.

## Request format {#section_fkp_5ng_jfb}

To delete records of time spent on issues, use an HTTP `DELETE` request:

```json
DELETE /{{ ver }}/issues/<issue-id>/worklog/<worklog-id>
Host: {{ host }}
Authorization: OAuth <token>
X-Org-ID: <organization ID>
```

#### Resource {#req-resource}

- **\<issue-id\>**

    Issue ID or key.

- **\<worklog-id\>**

    ID of the record of time spent.

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

## Response format {#section_wlq_d5g_jfb}

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

