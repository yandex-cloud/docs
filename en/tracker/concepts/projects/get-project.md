# Get project parameters

Use this request to get information about [projects](../../manager/projects.md).

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get project parameters, use an HTTP `GET` request.

```
GET /{{ ver }}/projects/<project-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Request parameters

**Resource**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<project-id> | Project ID. | Number. |

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| expand | Additional fields to be included in the response: <ul><li>`queues`: Project queues. </li></ul> | String. |

## Response format {#answer}

{% list tabs %}

- Successful execution of the request

    If the request is successful, the API returns a response with code `200 OK`.

    The response body contains information about the project in JSON format.

    ```json
    {
        "self": "https://api.tracker.yandex.net/v2/projects/9",
        "id": "9",
        "version": 1,
        "key": "Project",
        "name": "Project",
        "description": "New project",
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
    | self | Address of the API resource with information about the project. | String. |
    | id | Project ID. | Number. |
    | version | Project version. Each change of the parameters increases the version number. | Number. |
    | key | Project key. Matches the project name. | String. |
    | name | Project name. | String. |
    | description | Project description. This parameter isn't displayed in the {{ tracker-name }} interface. | String. |
    | lead | Block with information about the project assignee. | Object. |
    | status | Stage of the project:<ul><li>`DRAFT`: Draft.</li><li>`IN_PROGRESS`: In progress.</li><li>`LAUNCHED`: Launched.</li><li>`POSTPONED`: Postponed. </li></ul> | String. |
    | startDate | Project start date in `YYYY-MM-DD` format. | String. |
    | endDate | Project end date in `YYYY-MM-DD` format. | String. |

    **Object fields** `lead`
    Parameter | Description | Data type
    -------- | -------- | ----------
    self | Address of the API resource with information about the user. | String.
    id | User ID. | Number.
    display | User's name displayed.. | String.

- The request failed

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

