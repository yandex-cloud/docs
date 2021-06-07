# Import an issue

{% note warning %}

This request can only be made on behalf of the company's administrator.

{% endnote %}

Use it to import to {{ tracker-name }} tasks from other project management systems.

## Request format {#section_i14_lyb_p1b}

To import an issue, use an HTTP `POST` request. Issue parameters are passed in the request body in JSON format:

```json
POST /{{ ver }}/issues/_import 
Host: {{ host }}Authorization: OAuth <token>
X-Org-ID: <organization ID>
Content-Type: application/json

{
  "queue": "TEST",
  "summary": "Test",
  "key": "TEST-1",
  "createdAt": "2017-08-29T12:34:41.740+0000",
  "createdBy": 1110000000011111,
  "updatedAt": "2017-09-09T11:24:31.140+0000",
  "updatedBy": 1110000000011111,
  "resolvedAt": "2017-09-08T09:33:42.250+0000",
  "resolvedBy": 1110000000011111,
  "status": 17,
  "deadline": "2017-09-07",
  "resolution": 1,
  "type": 2,
  "description": "Test",
  "start": "2017-09-04",
  "end": "2017-09-07",
  "assignee": 1110000000011111,
  "priority": 3,
  "affectedVersions": [1, 2, 3],
  "fixVersions": [4, 5, 6],
  "components": [7, 8, 9],
  "tags": ["test", "tag"],
  "sprint": [1, 2, 3],
  "followers": [1110000000011111, 2220000000022222],
  "access": [1110000000011111, 2220000000022222],
  "unique": "issue_5182786599824772824459",
  "followingMaillists": ["test@test.yaconnect.com", "mail@test.yaconnect.com"],
  "originalEstimation": 3600000,
  "estimation": 3600000,
  "spent": 3600000,
  "storyPoints": 1.0,
  "votedBy": [1110000000011111, 2220000000022222],
  "favoritedBy": [1110000000011111, 2220000000022222]
}
```

If necessary, you can extend the list of fields available for import. To do this, [create](https://yandex.ru/support/connect-tracker/user/create-param.html) additional fields in {{ tracker-name }} and specify them in the request body in the following format:

```
"field_name": "field value"
```

#### Request headers {request-headers}

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

- **Content-Type**

  Request body format. Must be `application/json`.

#### Request body {#request-body-parameters}

The request body contains the issue parameters:

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| queue | Queue key. | String |
| summary | Issue name, no more than 255 characters. | String |
| key | Issue key. The key must belong to the queue that the issue is imported to.<br/><br/>If this parameter is omitted, the issue is assigned a key automatically. | String |
| createdAt | Issue creation date and time in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. Must be no later than the current time. | String |
| createdBy | Username or ID of the user who created the issue. | <ul><li>String for the username</li><li>Number for the ID</li></ul> |
| updatedAt | Date and time of the issue's last update in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. You can specify any value in the interval from issue creation to the current time.<br/><br/>The parameter is only used together with the `updatedBy` parameter. | String |
| updatedBy | Username or ID of the user who edited the issue last.<br/><br/>The parameter is only used together with the `updatedAt` parameter. | <ul><li>String for the username</li><li>Number for the ID</li></ul> |
| resolvedAt | Date and time when the resolution is added, in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. You can specify any value in the interval from issue creation to the time it was last updated.<br/>The parameter is only used together with the `resolution` and `resolvedBy` parameters. | String |
| resolvedBy | Username or ID of the user who set the resolution.<br/><br/>The parameter is only used together with the `resolution` and `resolvedAt` parameters. | <ul><li>String for the username</li><li>Number for the ID</li></ul> |
| status | Issue status ID. The status must be present in the queue workflow for the selected issue type.<br/><br/>If not specified, the initial status of the workflow is used. | Number |
| deadline | Deadline in `YYYY-MM-DD` format. | String |
| resolution | Issue resolution ID.<br/><br/>The parameter is only used together with the `resolvedBy` and `resolvedAt` parameters. | Number |
| type | ID of the issue type. The issue type must be present in the queue.<br/><br/>If not specified, the issue type that is selected as the default for the queue is used. | Number |
| description | Issue description, no more than 512,000 characters. | String |
| start | Start date in `YYYY-MM-DD` format. | String |
| end | End date in `YYYY-MM-DD` format. | String |
| assignee | Username or ID of the assignee. | <ul><li>String for the username</li><li>Number for the ID</li></ul> |
| priority | Priority ID.<br/><br/>If no priority is specified, the priority that is selected as the default for the queue is used. | Number |
| affectedVersions | Version IDs listed in the **Affected Version** field. The versions must exist in the queue. | JSON array |
| fixVersions | Version IDs listed in the **Fix Version** field. The versions must exist in the queue. | JSON array |
| components | IDs of the components that apply to the issue. The components must exist in the queue. | JSON array |
| tags | Array of issue tags. | JSON array |
| sprint | IDs of the sprints that the issue is part of. | JSON array |
| followers | Array of IDs or usernames of issue followers. | JSON array |
| access | Array of IDs or usernames of users listed in the **Access** field. | JSON array |
| unique | Unique issue ID. You can set any ID. | String |
| followingMaillists | IDs of mailing lists (teams and departments subscribed to the issue). | JSON array |
| originalEstimation | Value of the "Original Estimate" parameter in milliseconds. | Number |
| estimation | Value of the "Estimate" parameter in milliseconds. | Number |
| spent | Value of the "Time Spent" parameter in milliseconds. | Number |
| storyPoints | Value of the Story Points parameter. | Floating-point number |
| votedBy | Array of IDs or usernames of users who voted for the issue. | JSON array |
| favoritedBy | Array of IDs or usernames of users who added the issue to favorites. | JSON array |

## Response format {#section_isd_myb_p1b}

{% list tabs %}

- Request executed successfully

  If the request is successful, the API returns a response with code 201. The request body contains information about the imported issue in JSON format.

    ```json
    {
      "self": "https://api.tracker.yandex.net/v2/issues/TEST-1",
      "id": "141b2ef1e4b036e9f8397458",
      "key": "TEST-1",
      "version": 1,
      "summary": "Test",
      "originalEstimation": "P1H",
      "estimation": "P1H",
      "spent": "P1H",
      "updatedBy": {
        "self": "https://api.tracker.yandex.net/v2/users/1110000000011111",
        "id": "1110000000011111",
        "display": "Ivan Ivanov"
      },
      "resolvedAt": "2017-09-08T09:33:42.250+0000",
      "start": "2017-09-04",
      "resolvedBy": {
        "self": "https://api.tracker.yandex.net/v2/users/1110000000011111",
        "id": "1110000000011111",
        "display": "Ivan Ivanov"
      },
      "description": "Test",
      "followingMaillists": [
        {
          "self": "https://api.tracker.yandex.net/v2/maillists/test@test.yaconnect.com",
          "id": "test@test.yaconnect.com",
          "display": "test"
        },
        {
          "self": "https://api.tracker.yandex.net/v2/maillists/mail@test.yaconnect.com",
          "id": "mail@test.yaconnect.com",
          "display": "mail"
        }
      ],
      "fixVersions": [
        {
          "self":"https://api.tracker.yandex.net/v2/versions/4",
          "id":"4",
          "display":"Version 4"
        },
        {
          "self":"https://api.tracker.yandex.net/v2/versions/5",
          "id":"5",
          "display":"Version 5"
        },
        {
          "self":"https://api.tracker.yandex.net/v2/versions/6",
          "id":"6",
          "display":"Version 6"
        }
      ],
      "type": {
        "self": "https://api.tracker.yandex.net/v2/issuetypes/2",
        "id": "2",
        "key": "task",
        "display": "Task"
      },
      "priority": {
        "self":"https://api.tracker.yandex.net/v2/priorities/3",
        "id":"3",
        "key":"normal",
        "display":"Normal"
      },
      "resolution": {
        "self":"https://api.tracker.yandex.net/v2/resolutions/1",
        "id":"1",
        "key":"fixed",
        "display":"Fixed"
      },
      "createdAt": "2017-08-29T12:34:41.740+0000",
      "followers": [
        {
          "self": "https://api.tracker.yandex.net/v2/users/1110000000011111",
          "id": "1110000000011111",
          "display": "Ivan Ivanov"
        },
        {
          "self": "https://api.tracker.yandex.net/v2/users/2220000000022222",
          "id": "2220000000022222",
          "display": "Petr Petrov"
        }
      ],
      "assignee": {
        "self": "https://api.tracker.yandex.net/v2/users/1110000000011111",
        "id": "1110000000011111",
        "display": "Ivan Ivanov"
      },
      "createdBy": {
        "self": "https://api.tracker.yandex.net/v2/users/1110000000011111",
        "id": "1110000000011111",
        "display": "Ivan Ivanov"
      },
      "commentWithoutExternalMessageCount": 0,
      "votes": 0,
      "affectedVersions": [
        {
          "self":"https://api.tracker.yandex.net/v2/versions/1",
          "id":"1",
          "display":"Version 1"
        },
        {
          "self":"https://api.tracker.yandex.net/v2/versions/2",
          "id":"2",
          "display":"Version 2"
        },
        {
          "self":"https://api.tracker.yandex.net/v2/versions/3",
          "id":"3",
          "display":"Version 3"
        }
      ],
      "commentWithExternalMessageCount": 0,
      "end": "2017-09-07",
      "deadline": "2018-05-28",
      "queue": {
        "self": "https://api.tracker.yandex.net/v2/queues/TEST",
        "id": "1",
        "key": "TEST",
        "display": "Test"
      },
      "updatedAt": "2017-09-09T11:24:31.140+0000",
      "storyPoints": 1.0,
      "status": {
        "self": "https://api.tracker.yandex.net/v2/statuses/17",
        "id": "17",
        "key": "closed",
        "display": "Closed"
      },
      "components":[
        {
          "self":"https://api.tracker.yandex.net/v2/components/7",
          "id":"7",
          "display":"Component 7"
        },
        {
          "self":"https://api.tracker.yandex.net/v2/components/8",
          "id":"8",
          "display":"Component 8"
        },
        {
          "self":"https://api.tracker.yandex.net/v2/components/9",
          "id":"9",
          "display":"Component 9"
        }
      ],
      "access": [
        {
          "self": "https://api.tracker.yandex.net/v2/users/1110000000011111",
          "id": "1110000000011111",
          "display": "Ivan Ivanov"
        },
        {
          "self": "https://api.tracker.yandex.net/v2/users/2220000000022222",
          "id": "2220000000022222",
          "display": "Petr Petrov"
        }
      ],
      "unique": "issue_5182786599824772824459",
      "favorite": false
    }
    ```

  #### Response parameters {answer-parameters}

  | Parameter | Description | Data type |
  | --------- | --------- | ---------- |
  | self | Address of the API resource with information about the issue. | String |
  | id | Address of the API resource with information about the issue. | String |
  | key | Issue key. | String |
  | version | Issue version. Each change to the issue parameters increases its version number. | Number |
  | summary | Issue name. | String |
  | originalEstimation | Value of the "Original Estimate" parameter. | String |
  | estimation | Value of the "Estimate" parameter. | String |
  | spent | Value of the "Time Spent" parameter. | String |
  | [updatedBy](#updatedBy) | Object with information about the user who edited the issue last. | Object |
  | resolvedAt | Date and time of the resolution. | String |
  | start | Date when work on the issue started. | String |
  | [resolvedBy](#resolvedBy) | Object with information about the user who added the resolution. | Object |
  | description | Issue description. | String |
  | [followingMaillists](#followingMaillists) | Array of objects with information about mailing lists (teams and departments subscribed to the issue). | Array of objects |
  | [fixVersions](#fixVersions) | Versions listed in the "Fix Version" field. | JSON array |
  | [type](#type) | Issue type. | JSON array |
  | [priority](#priority) | Object with information about the priority. | Object |
  | [resolution](#resolution) | Object with information about the resolution. | Object |
  | createdAt | Issue creation date and time. | String |
  | [followers](#followers) | Array of objects with information about issue followers. | Array of objects |
  | [assignee](#assignee) | Array of objects with information about the assignee. | Array of objects |
  | [createdBy](#createdBy) | Array of objects with information about the issue author. | Array of objects |
  | [affectedVersions](#affectedVersions) | Versions listed in the "Affected Versions" field. | JSON array |
  | [queue](#queue) | Object with information about the queue that the issue belongs to. | Object |
  | [status](#status) | Object with information about the issue status. | Object |
  | [components](#components) | Array of objects with information about the components of the issue. | Array of objects |
  | [access](#access) | Array of objects with information about the users listed in the "Access" field. | Array of objects |
  | commentWithoutExternalMessageCount | Number of comments on the issue. | Number |
  | votes | Number of votes for the issue. | Number |
  | commentWithExternalMessageCount | Number of messages sent from the issue page. | Number |
  | end | Date when work on the issue was completed. | String |
  | deadline | Deadline | String |
  | updatedAt | Date and time when the issue was last updated. | String |
  | storyPoints | Value of the Story Points parameter. | Floating-point number |
  | unique | Unique ID of the issue that was set when importing it. | String |
  | favorite | Shows if the user added the issue to favorites<br/><ul><li>true: Yes.</li><li>false: No.</li></ul> | Boolean |

  **Object fields** `updatedBy` {#updatedBy}

  | Parameter | Description | Data type |
  | -------- | -------- | ---------- |
  | self | Address of the API resource with information about the user. | String |
  | id | User ID. | String |
  | display | User's name displayed. | String |

  **Object fields** `resolvedBy` {#resolvedBy}

  | Parameter | Description | Data type |
  | -------- | -------- | ---------- |
  | self | Address of the API resource with information about the user. | String |
  | id | User ID. | String |
  | display | User's name displayed. | String |

  **Object fields** `followingMaillists` {#followingMaillists}

  | Parameter | Description | Data type |
  | -------- | -------- | ---------- |
  | self | Address of the API resource with information about the mailing list. | String |
  | id | Mailing list ID. | String |
  | display | Mailing list name displayed. | String |

  **Object fields** `fixVersions` {#fixVersions}

  | Parameter | Description | Data type |
  | -------- | -------- | ---------- |
  | self | Address of the API resource with information about the version. | String |
  | id | Version ID. | String |
  | display | Version name. | String |

  **Object fields** `type` {#type}

  | Parameter | Description | Data type |
  | -------- | -------- | ---------- |
  | self | Address of the API resource with information about the issue type. | String |
  | id | ID of the issue type. | String |
  | key | Key of the issue type. | String |
  | display | Issue type name displayed. | String |

  **Object fields** `priority` {#priority}

  | Parameter | Description | Data type |
  | -------- | -------- | ---------- |
  | self | Address of the API resource with information about the priority. | String |
  | id | Priority ID. | String |
  | key | Priority key. | String |
  | display | Priority name displayed. | String |

  **Object fields** `resolution` {#resolution}

  | Parameter | Description | Data type |
  | -------- | -------- | ---------- |
  | self | Address of the API resource with information about the resolution. | String |
  | id | Resolution ID. | String |
  | key | Resolution key. | String |
  | display | Resolution name displayed. | String |

  **Object fields** `followers` {#followers}

  | Parameter | Description | Data type |
  | -------- | -------- | ---------- |
  | self | Address of the API resource with information about the user. | String |
  | id | User ID. | String |
  | display | User's name displayed. | String |

  **Object fields** `assignee` {#assignee}

  | Parameter | Description | Data type |
  | -------- | -------- | ---------- |
  | self | Address of the API resource with information about the user. | String |
  | id | User ID. | String |
  | display | User's name displayed. | String |

  **Object fields** `createdBy` {#createdBy}

  | Parameter | Description | Data type |
  | -------- | -------- | ---------- |
  | self | Address of the API resource with information about the user. | String |
  | id | User ID. | String |
  | display | User's name displayed. | String |

  **Object fields** `affectedVersions` {#affectedVersions}

  | Parameter | Description | Data type |
  | -------- | -------- | ---------- |
  | self | Address of the API resource with information about the version. | String |
  | id | Version ID. | String |
  | display | Version name. | String |

  **Object fields** `queue` {#queue}

  | Parameter | Description | Data type |
  | -------- | -------- | ---------- |
  | self | Address of the API resource with information about the queue. | String |
  | id | Queue ID. | String |
  | key | Queue key. | String |
  | display | Queue name. | String |

  **Object fields** `status` {#status}

  | Parameter | Description | Data type |
  | -------- | -------- | ---------- |
  | self | Address of the API resource with information about the status. | String |
  | id | Status ID. | String |
  | key | Status key. | String |
  | display | Status name displayed. | String |

  **Object fields** `components` {#components}

  | Parameter | Description | Data type |
  | -------- | -------- | ---------- |
  | self | Address of the API resource with information about the component. | String |
  | id | Component ID. | String |
  | key | Component key. | String |
  | display | Component name displayed. | String |

  **Object fields** `access` {#access}

  | Parameter | Description | Data type |
  | -------- | -------- | ---------- |
  | self | Address of the API resource with information about the version. | String |
  | id | Version ID. | String |
  | display | Version name. | String |

- Request failed

    If the request is processed incorrectly, the API returns a message with error details:

    | HTTP error code | Error description |
    | --------------- | --------------- |
    | 400 Bad Request | One of the request parameters has an invalid value or data format. |
    | 403 Forbidden | The user or application has no access rights to the resource, the request is rejected. |
    | 404 Not Found | The requested resource not found. |
    | 409 Conflict | The request can't be executed due to a name conflict. |
    | 422 Unprocessable Entity | JSON validation error, the request is rejected. |
    | 500 Internal Server Error | Internal service error. Try again later. |
    | 503 Service Unavailable | The API service is temporarily unavailable. |

{% endlist %}

