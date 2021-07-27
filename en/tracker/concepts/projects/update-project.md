---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Edit a project

Use this request to update information about a [project](../../manager/projects.md).

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To edit a project, use an HTTP `PUT` request. Request parameters are passed in the request body in JSON format.

```
PUT /{{ ver }}/projects/<project-id>?version=<version number>
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>

{
    "queues": "<queue key>" 
}
```

#### Request parameters

**Resource**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<project-id> | Project ID. | Number |

**Required parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| version | Project version. Changes are only made to the current version of the project. | Number |

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| expand | Additional fields to be included in the response: <ul><li>`queues`: Project queues. </li></ul> | String |

#### Request body parameters

**Required parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| queues | Issues to include in the project. | String |

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| name | Project name. | String |
| description | Project description. This parameter isn't displayed in the {{ tracker-name }} interface. | String |
| lead | ID or username of the project assignee. | Number / String |
| status | Stage of the project:<ul><li>`DRAFT`: Draft.</li><li>`IN_PROGRESS`: In progress.</li><li>`LAUNCHED`: Launched.</li><li>`POSTPONED`: Postponed. </li></ul> | String |
| startDate | Project start date in `YYYY-MM-DD` format. | String |
| endDate | Project end date in `YYYY-MM-DD` format. | String |

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    If the request is successful, the API returns a response with code `200 OK`.

    The response body contains information about the updated project in JSON format.

    ```json
    {
        "self": "https://api.tracker.yandex.net/v2/projects/9",
        "id": "9",
        "version": 5,
        "key": "Project",
        "name": "Project",
        "description": "Project with updates",
        "lead": {
            "self": "https://api.tracker.yandex.net/v2/users/12314567890",
            "id": "1234567890",
            "display": "First and Last name"
        },
        "status": "launched",
        "startDate": "2020-11-16",
        "endDate": "2020-12-16"
    }
    ```

    #### Response parameters

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the project. | String |
    | id | Project ID. | Number |
    | version | Project version. Each change of the parameters increases the version number. | Number |
    | key | Project key. Matches the project name. | String |
    | name | Project name. | String |
    | description | Project description. This parameter isn't displayed in the {{ tracker-name }} interface. | String |
    | lead | Block with information about the project assignee. | Object |
    | status | Stage of the project:<ul><li>`DRAFT`: Draft.</li><li>`IN_PROGRESS`: In progress.</li><li>`LAUNCHED`: Launched.</i><li>`POSTPONED`: Postponed. </li></ul> | String |
    | startDate | Project start date in `YYYY-MM-DD` format. | String |
    | endDate | Project end date in `YYYY-MM-DD` format. | String |

    **Object fields** `lead`

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the user. | String |
    | id | User ID. | Number |
    | display | User's name displayed. | String |

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    400
    :   One or more request parameters have an invalid value.

    401
    :  The user isn't authorized. Make sure that actions described in the [API access](../access.md) section are performed.

    403
    :  Insufficient rights to perform this action. You can check what rights you have in the {{ tracker-name }} interface. The same rights are required to perform an action via the API and interface.

    412
    :   There was a conflict when editing the object. The error may be due to an invalid update version.

    428
    :   Access to the resource is denied. Make sure all required conditions for the request are specified.

{% endlist %}

