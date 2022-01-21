# Edit a project

Use this request to update information about a [project](../../manager/projects.md).

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To edit a project, use an HTTP `PUT` request. Request parameters are passed in the request body in JSON format.

```
PUT /{{ ver }}/projects/<project-id>?version=<version number>
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
    "queues": "<queue key>" 
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<project-id> | Project ID. | Number |

{% endcut %}

{% cut "Request parameters" %}

**Required parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| version | Project version. Changes are only made to the current version of the project. | Number |

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| expand | Additional fields to be included in the response: <ul><li>`queues`: Project queues. </li></ul> | String |

{% endcut %}

{% cut "Request body parameters" %}

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

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Successful execution of the request

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains information about the updated project in JSON format.

    ```json
    {
        "self": "{{ host }}/v2/projects/9",
        "id": "9",
        "version": 5,
        "key": "Project",
        "name": "Project",
        "description": "Project with updates",
        "lead": {
            "self": "{{ host }}/v2/users/12314567890",
            "id": "1234567890",
            "display": "First and Last name"
        },
        "status": "launched",
        "startDate": "2020-11-16",
        "endDate": "2020-12-16"
    }
    ```

   {% cut "Response parameters" %}

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

    {% endcut %}

- The request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-412](../../../_includes/tracker/api/answer-error-412.md) %}

    {% include [answer-error-428](../../../_includes/tracker/api/answer-error-428.md) %}

{% endlist %}

