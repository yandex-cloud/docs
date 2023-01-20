---
sourcePath: en/tracker/api-ref/concepts/projects/get-project.md
---
# Get project parameters

Use this request to get information about [projects](../../manager/project-new.md).

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get project parameters, use an HTTP `GET` request.

```
GET /{{ ver }}/projects/<project-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}
**Resource**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<project-id> | Project ID | Number |

{% endcut %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| expand | Additional fields to be included in the response: <ul><li>`queues`: Project queues. </li></ul> | String |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains information about the project in JSON format.

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
    | status | Stage of the project:<ul><li>`DRAFT`: Draft.</li><li>`IN_PROGRESS`: In progress.</li><li>`LAUNCHED`: Launched.</li><li>`POSTPONED`: Postponed. </li></ul> | String |
    | startDate | Project start date in `YYYY-MM-DD` format. | String |
    | endDate | Project end date in `YYYY-MM-DD` format. | String |

    **Object fields** `lead`
    Parameter | Description | Data type
    -------- | -------- | ----------
    self | Address of the API resource with information about the user. | String
    id | User ID. | Number
    display | User's name displayed. | String

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

