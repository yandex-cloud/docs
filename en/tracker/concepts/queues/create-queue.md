---
sourcePath: en/tracker/api-ref/concepts/queues/create-queue.md
---
# Create a queue

Use this request to create queues.

## Request format {#section_rbh_d1s_y2b}

To create a queue, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format:

```json
POST /{{ ver }}/queues/
Host: {{ host }}
Authorization: OAuth <OAuth token>
Content-Type: application/json 

{
    "key": "DESIGN",
    "name": "Design",
    "lead": "artemredkin",
    "defaultType": "task",
    "defaultPriority": "normal",
    "issueTypesConfig":[
                {"issueType":"task", 
                  "workflow":"oicn", 
                  "resolutions":["wontFix",...]},
  ...
  ]
}
```

#### Request headers {#req-headers}

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

- **Content-Type**

    Request body format. Must be `application/json`.

#### Request body {#req-body-params}

The request body contains the information required to create a new queue:

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| key | Queue key. Required field. | String |
| name | Queue name. Required field. | String |
| lead | Username or ID of the queue owner. Required field. | String |
| defaultType | ID or key of the default issue type. Required field. | String |
| defaultPriority | ID or key of the default issue priority. Required field. | String |
| [issueTypesConfig](#issue-types-config) | Array with settings of queue issue types. | Array of objects |

**Array object fields** `issueTypesConfig` {#issue-types-config}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| issueType | Key of the issue type. | String |
| workflow | Workflow ID. | String |
| resolutions | Array with possible resolutions' IDs or keys. | Array |

## Response format {#section_x32_lry_y2b}

{% list tabs %}

- Request executed successfully

  If the request is successful, the API returns a response with code 201. The request body contains information about the created queue in JSON format.

    ```json
    {
           "self": "https://api.tracker.yandex.net/v2/queues/DESIGN",
           "id": 111,
           "key": "DESIGN",
           "version": 1400150916068,
           "name": "Design",
           "lead": {
              "self": "https://api.tracker.yandex.net/v2/users/1120000000004859",
              "id": "artemredkin",
              "display": "Artem Redkin"
        },
           "assignAuto": false,
           "allowExternals" : false,
           "defaultType": {
              "self": "https://api.tracker.yandex.net/v2/issuetypes/2",
              "id": "2",
              "key": "task",
              "display": "Task"
       },
           "defaultPriority": {
              "self": "https://api.tracker.yandex.net/v2/priorities/2",
              "id": "2",
              "key": "normal",
              "display": "Normal"
      }
    }
    ```

  #### Response parameters {#answer-params}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Queue link. | String |
  | id | Queue ID. | String |
  | key | Queue key. | String |
  | version | Queue version. Each change to the queue increases its version number. | Number |
  | name | Queue name. | String |
  | [lead](#lead) | Block with information about the queue owner. | Object |
  | assignAuto | Automatically assign new issues in the queue:<br/><br/>`true`: Assign.<br/><br/>`false`: Do not assign. | Boolean |
  | allowExternals | Allow sending emails to external addresses. Acceptable values:<br/><br/>`true`: Allow.<br/><br/>`false`: Do not allow. | Boolean |
  | [defaultType](#default-type) | Block with information about the default issue type. | String |
  | [defaultPriority](#default-priority) | Block with information about the default issue priority | Object |

  **Object fields** `lead` {#lead}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Link to the user. | String |
  | id | User ID. | String |
  | display | User's name displayed. | String |

  **Object fields** `defaultType` {#default-type}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Link to the issue type. | String |
  | id | ID of the issue type. | String |
  | key | Key of the issue type. | String |
  | display | Issue type name displayed. | String |

  **Object fields** `defaultPriority` {#default-priority}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Link to the priority type. | String |
  | id | Priority ID. | String |
  | key | Priority key. | String |
  | display | Priority name displayed. | String |

- Request failed

  If the request is processed incorrectly, the API returns a message with error details:

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

