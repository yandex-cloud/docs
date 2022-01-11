---
sourcePath: en/tracker/api-ref/concepts/issues/new-transition.md
---
# Make a status transition

Use this request to switch an issue to a new status.

## Request format {#section_rkq_bhl_dfb}

To change an issue's status, use an HTTP `POST` request. If the transition settings let you change the issue parameters, specify them in the request body in JSON format:

```json
POST /{{ ver }}/issues/<issue-id>/transitions/<transition-id>/_execute
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>

{
"<key1>":"<value1>",
"<key2>":"<value2>",
...
"comment":"<comment text>"
}
```

#### Resource {#req-resource}

- **\<issue-id\>**

    Issue ID or key.

- **\<transition-id\>**

    Transition ID.

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
| \<key\> | Issue field that can be edited during the transition. List of keys: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Depends on the parameter type |
| comment | Comment on the issue. | String |

## Response format {#section_rcd_ysf_2fb}

{% list tabs %}

- Request executed successfully

  If the request is successful, the API returns a response with code 200. The response body contains a JSON array with a list of transitions available for the issue in the new status.

    ```json
    [ 
    {
      "self" : "https://api.tracker.yandex.net/v2/issues/DESIGN-1/transitions/close",
      "id" : "close",
      "to" : {
      "self" : "https://api.tracker.yandex.net/v2/statuses/3",
        "id" : "3",
        "key" : "closed",
        "display" : "Closed"
      },
      "screen" : {
        "self" : "https://api.tracker.yandex.net/v2/screens/50c85b17e4b04b38ef31a522",
        "id" : "50c85b17e4b04b38ef31a522"
      }
     },
     ...
    ]
    ```

  #### Response parameters {#answer-params}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Transition link. | String |
  | id | Transition ID. | String |
  | [to](#to) | Block with information about the status that the issue can transition to. | Object |
  | [screen](#screen) | Block with information about the transition screen. | Object |

  **Object fields** `to` {#to}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Status link. | String |
  | id | Status ID. | String |
  | key | Status key. | String |
  | display | Status name displayed. | String |

  **Object fields** `screen` {#screen}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Link to the transition screen. | String |
  | id | Transition screen ID. | String |

- Request failed

  If the request is processed incorrectly, the API returns a response with an error code.

  | HTTP error code | Error description |
  | ----- | ----- |
  | 400 Bad Request | One of the request parameters has an invalid value or data format. |
  | 403 Forbidden | The user or application has no access rights to the resource, the request is rejected. |
  | 404 Not Found | The requested resource not found. |
  | 409 Conflict | The request can't be executed due to a name conflict. |
  | 422 Unprocessable Entity | JSON validation error, the request is rejected. |
  | 500 Internal Server Error | Internal service error. Try again later. |
  | 503 Service Unavailable | The API service is temporarily unavailable. |

{% endlist %}

