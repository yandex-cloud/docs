---
sourcePath: en/tracker/api-ref/concepts/projects/create-project.md
---
# Create a project

Use this request to create [project](../../manager/project-new.md).

You can also use a new, extended [entity creation](../entities/create-entity.md) API that provides a unified method for creating projects and portfolios.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To create a project, use an HTTP `POST` request. Request parameters are provided in the request body in JSON format.

```json
POST /{{ ver }}/projects/
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
    "name": "Project name",
    "queues": "<queue key>"
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Request body parameters" %}

The request body contains the information required to create a new project:

**Required parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| name | Project name | String |
| queues | Issues to include in the project | String |

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| description | Project description. This parameter is not displayed in the {{ tracker-name }} interface. | String |
| lead | ID or username of the project assignee | Number / String |
| status | Stage of the project:<ul><li>`DRAFT`: Draft</li>`IN_PROGRESS`: In progress</li><li>`LAUNCHED`: Launched</li><li>`POSTPONED`: Postponed</li></ul> | String |
| startDate | Project start date in `YYYY-MM-DD` format | String |
| endDate | Project end date in `YYYY-MM-DD` format | String |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

    The response body contains information about the created project in JSON format.
    ```json
    {
        "self": "{{ host }}/v2/projects/9",
        "id": "9",
        "version": 1,
        "key": "Project",
        "name": "Project",
        "description": "New project",
        "lead": {
            "self": "{{ host }}/v2/users/12314567890",
            "id": "1234567890",
            "display": "First and Last Name"
        },
        "status": "launched",
        "startDate": "2020-11-16",
        "endDate": "2020-12-16"
    }
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the project | String |
    | id | Project ID | Number |
    | version | Project version. Each change of the parameters increases the version number. | Number |
    | key | Project key. Matches the project name. | String |
    | name | Project name | String |
    | description | Project description. This parameter is not displayed in the {{ tracker-name }} interface. | String |
    | lead | Block with information about the project assignee | Object |
    | status | Stage of the project:<ul><li>`DRAFT`: Draft</li><li>`IN_PROGRESS`: In progress</li><li>`LAUNCHED`: Launched</li><li>`POSTPONED`: Postponed</li></ul> | String |
    | startDate | Project start date in `YYYY-MM-DD` format | String |
    | endDate | Project end date in `YYYY-MM-DD` format | String |


    **Object fields** `lead`

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the user | String |
    | id | User ID | Number |
    | display | Displayed user name | String |

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-409](../../../_includes/tracker/api/answer-error-409.md) %}

{% endlist %}