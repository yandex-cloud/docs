---
sourcePath: en/tracker/api-ref/concepts/issues/patch-issue.md
---
# Editing an issue

Use this request to make changes to issues.

{% note warning %}

You can only change the issue status with the [Status transition](new-transition.md) request.

{% endnote %}

## Request format {#section_rnm_x4j_p1b}

Before making the request, [get permission to access the API](../access.md).

To edit an issue, use an HTTP `PATCH` request. Request parameters are provided in the request body in JSON format.

```json
PATCH /{{ ver }}/issues/<issue_ID_or_key>
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
{
   Request body in JSON format
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| version | Issue version. Changes are only made to the current version of the issue. | Number |

{% endcut %}

{% cut "Request body parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| summary | Issue name. | String |
| [parent](#req-parent) | Parent issue. | Object or string |
| description | Issue description. | String |
| [sprint](#req-sprint) | Block with information about sprints. | Array of objects or strings |
| [type](#req-type) | Issue type. | Can be set as an object, a string (if the issue type key is provided), or a number (if the issue type ID is provided). |
| [priority](#req-priority) | Issue priority. | Can be set as an object, a string (if the priority key is provided), or a number (if the priority ID is provided). |
| [followers](#req-followers) | IDs or usernames of issue followers. | Array of objects or strings |

`parent` **object fields** {#req-parent}

| Parameter | Description | Data type |
----- | ----- | -----
| id | Parent issue ID | String |
| key | Parent issue key | String |

`sprint` **object fields** {#req-sprint}

| Parameter | Description | Data type |
----- | ----- | -----
| id | Sprint ID. You can get sprint information using the [request](../../get-sprints.md). | Number |

`type` {#req-type} **object fields**

| Parameter | Description | Data type |
----- | ----- | -----
| id | Issue type ID | String |
| key | Issue type key. | String |

`priority` **object fields** {#req-priority}

| Parameter | Description | Data type |
----- | ----- | -----
| id | Priority ID | String |
| key | Priority key. | String |

`followers` **object fields** {#req-followers}

| Parameter | Description | Data type |
----- | ----- | -----
| id | Employee ID | String |

{% endcut %}

{% cut "Request body format" %}

The request body includes a JSON object with the [IDs of updated fields and their values](../../common-format.md#body).

{% endcut %}

> Example 1: Change the name, description, type, and priority of an issue.
>
> - An HTTP PATCH method is used.
> - We are editing the TEST-1 issue.
> - New issue type: **Error**.
> - New issue priority: **Low**.
>
> ```
> PATCH /v2/issues/TEST-1
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
>
> {
>     "summary": "<new_issue_name>",
>     "description": "<new_issue_description>",
>     "type": {
>         "id": "1",
>         "key": "bug"
>         },
>     "priority": {
>         "id": "2",
>         "key": "minor"
>         }
> }
> ```

> Example 2: Change the parent issue, add it to sprints, and add followers.
>
> - An HTTP PATCH method is used.
> - We are editing the TEST-1 issue.
> - New parent issue: TEST-2.
> - The issue is added to sprints with ID 3 and ID 2. The sprints must be on different boards.
> - Followers added: `userlogin-1` and `userlogin-2`.
>
> ```
> PATCH /v2/issues/TEST-1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> {{ org-id }}
>
> {
>     "parent": {
>         "key": "TEST-2"},
>     "sprint": [{"id": "3"}, {"id": "2"}],
>     "followers": {
>         "add": ["userlogin-1", "userlogin-2"]
>         }
> }
> ```

## Response format {#section_xc3_53j_p1b}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   The response body contains information about the edited issue in JSON format.

   {% include [answer-issue](../../../_includes/tracker/api/answer-issue.md) %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

   {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [answer-error-409](../../../_includes/tracker/api/answer-error-409.md) %}

{% endlist %}

