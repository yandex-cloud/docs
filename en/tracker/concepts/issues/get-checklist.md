---
sourcePath: en/tracker/api-ref/concepts/issues/get-checklist.md
---
# Get checklist parameters

Use this request to get the parameters of an issue's [checklist](../../user/checklist.md).

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get checklist parameters, use an HTTP `GET` request:

```json
GET /{{ ver }}/issues/<issue-id>/checklistItems
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| --- | --- | --- |
| \<issues-id\> | Issue ID or key | String |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains information about the checklist items in JSON format.

    ```json
    {
        "id": "5fde5f0a1aee261dd3b62edb",
        "text": "Checklist item",
        "textHtml": "Item text in HTML format",
        "checked": false,
        "assignee": {
            "id": 1134669209,
            "display": "First and Last name",
            "passportUid": 1134669209,
            "login": "user_login",
            "firstName": "First name",
            "Lastname": "Last name",
            "email": "user_login@example.com",
            "trackerUid": 1134669209
        },
        "deadline": {
            "date": "2021-05-09T00:00:00.000+0000",
            "deadlineType": "date",
            "isExceeded": false
        },
        "checklistItemType": "standard"
    }
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | id | ID of the checklist item. | String |
    | text | Text of the checklist item. | String |
    | textHtml | Text of the checklist item in HTML format. | String |
    | checked | Flag indicating that the checklist item is completed:<ul><li>`true`: The item is marked as completed.</li><li>`false`: The item is not marked as completed.</li></ul> | Boolean |
    | [assignee](#assignee) | Assignee of the checklist item. | Object |
    | [deadline](#deadline) | Deadline for the checklist item. | Object |
    | checklistItemType | Type of the checklist item. | String |

    **Object fields** `assignee` {#assignee}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | id | User ID. | Number |
    | display | User's name displayed. | String |
    | passportUid | Unique ID of the user's Yandex account. | Number |
    | login | Username of the user. | String |
    | firstName | User's first name. | String |
    | lastName | Last name of the user. | String |
    | email | User's email address. | String |
    | trackerUid | Unique ID of the user's {{ tracker-name }} account. | Number |

    **Object fields** `deadline` {#deadline}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | date | Deadline in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | Date |
    | deadlineType | The `deadline` parameter data type. | String |
    | isExceeded | Flag indicating if the deadline has passed: <ul><li>`true`: Passed.</li><li>`false`: Not passed.</li></ul> | Boolean |

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

