# Get a list of project queues

Use this request to get a list of queues whose issues are included in a [project](../../manager/projects.md).

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get a list of project queues, use an HTTP `GET` request:

```
GET /{{ ver }}/projects/<project-id>/queues
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Request parameters

**Resource**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<project-id> | Project ID. | Number |
| expand | Additional fields to include in the response. If there are multiple queues in the project, parameters are displayed for each queue:<ul><li>`all`: All queue parameters.</li><li>`projects`: All organization projects.</li><li>`components`: Queue components.</li><li>`versions`: Queue versions.</li><li>`types`: Queue issue types.</li><li>`team`: Queue team members.</li><li>`workflows`: Queue workflows and their issue types.</li><li>`fields`: Required queue fields.</li><li>`notification_fields`: Queue issue notification fields.</li><li>`issue_types_config`: Queue issue settings.</li><li>`enabled_features`: Queue integration settings.</li><li> `signature_settings`: Information about the queue mailbox: address, alias, and signature.</li></ul> | String |

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    If the request is successful, the API returns a response with code `200 OK`.

    The response body contains information about the project in JSON format.

    ```json
    [
        {
            "self": "https://api.tracker.yandex.net/v2/queues/ORG",
            "id": 1,
            "key": "ORG",
            "version": 6,
            "name": "Default",
            "description": "Queue description "Default" (ORG)",
            "lead": {
                "self": "https://api.tracker.yandex.net/v2/users/780889736",
                "id": "780889736",
                "display": "Tracker service robot"
            },
            "assignAuto": false,
            "defaultType": {
                "self": "https://api.tracker.yandex.net/v2/issuetypes/2",
                "id": "2",
                "key": "task",
                "display": "Issue"
            },
            "defaultPriority": {
                "self": "https://api.tracker.yandex.net/v2/priorities/3",
                "id": "3",
                "key": "normal",
                "display": "Medium"
            },
            "allowExternalMailing": true,
            "addIssueKeyInEmail": true,
            "denyVoting": false,
            "denyConductorAutolink": false,
            "denyTrackerAutolink": true,
            "useComponentPermissionsIntersection": false,
            "useLastSignature": false
        },
        {
            "self": "https://api.tracker.yandex.net/v2/queues/TEST",
            "id": 3,
            "key": "TEST",
            "version": 8,
            "name": "Testing",
            "description": "Description of the "Testing" queue (TEST)",
            "lead": {
                "self": "https://api.tracker.yandex.net/v2/users/1234567890",
                "id": "1234567890",
                "display": "First and Last name"
            },
            "assignAuto": true,
            "defaultType": {
                "self": "https://api.tracker.yandex.net/v2/issuetypes/2",
                "id": "2",
                "key": "task",
                "display": "Issue"
            },
            "defaultPriority": {
                "self": "https://api.tracker.yandex.net/v2/priorities/3",
                "id": "3",
                "key": "normal",
                "display": "Medium"
            },
            "allowExternalMailing": false,
            "addIssueKeyInEmail": false,
            "denyVoting": false,
            "denyConductorAutolink": false,
            "denyTrackerAutolink": false,
            "useComponentPermissionsIntersection": false,
            "useLastSignature": false
        }
    ]
    ```

    #### Response parameters

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the queue. | String |
    | id | Queue ID. | Number |
    | key | Queue key. | String |
    | version | Queue version. Each change to the queue increases its version number. | String |
    | name | Queue name. | String |
    | description | Text description of the queue. | String |
    | lead | Block with information about the queue owner. | Object |
    | assignAuto | Flag indicating that new issues in the queue are assigned automatically:<ul><li>`true`: Assigned.</li><li>`false`: Not assigned.</li></ul> | Boolean |
    | defaultType | Block with information about the default issue type. | Object |
    | defaultPriority | Block with information about the default issue priority. | Object |
    | allowExternalMailing | Flag that indicates if emails to external addresses are allowed:<ul><li>`true`: Allowed.</li><li>`false`: Not allowed.</li></ul> | Boolean |
    | addIssueKeyInEmail | Flag that indicates if the issue number is added to the email subject:<ul><li>`true`: Added.</li><li>`false`: Not added.</li></ul> | Boolean |
    | denyVoting | Flag that indicates if voting for issues is allowed:<ul><li>`true`: Allowed.</li><li>`false`: Not allowed. </li></ul> | Boolean |
    | denyConductorAutolink | Service parameter. | Boolean |
    | denyTrackerAutolink | Flag that indicates whether to add an automatic link to issues in other queues:<ul><li>`true`: Add a link.</li><li>`false`: Do not add a link if the key of an issue from another queue is added to the comment or description.</li></ul> | Boolean |
    | useComponentPermissionsIntersection | The method of getting access rights to issues with multiple components:<ul><li>`true`: As an overlap of component access rights.</li><li>`false`: As a combination of component access rights.</li></ul> | Boolean |
    | useLastSignature | Service parameter. | Boolean |

    **Object fields** `lead`

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the user. | String |
    | id | User ID. | Number |
    | display | User's name displayed. | String |

    **Object fields** `defaultType`

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the issue type. | String |
    | id | ID of the issue type. | Number |
    | key | Key of the issue type. | String |
    | display | Issue type name displayed. | String |

    **Object fields** `defaultPriority`

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the issue priority. | String |
    | id | Issue priority ID. | Number |
    | key | Issue priority key. | String |
    | display | Issue priority name displayed. | String |

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    400
    :   One or more request parameters have an invalid value.

    401
    :  The user isn't authorized. Make sure that actions described in the [API access](../access.md) section are performed.

    403
    :  Insufficient rights to perform this action. You can check what rights you have in the {{ tracker-name }} interface. The same rights are required to perform an action via the API and interface.

    404
    :   The requested object was not found. You may have specified an invalid object ID or key.

{% endlist %}

