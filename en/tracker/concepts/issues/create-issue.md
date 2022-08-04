---
sourcePath: en/tracker/api-ref/concepts/issues/create-issue.md
---
# Create an issue

Use this request to create issues.

## Request format {#section_rnm_x4j_p1b}

Before making the request, [get permission to access the API](../access.md).

To create an issue, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format:

```json
POST /{{ ver }}/issues/
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
    "summary": "issue name",
    "queue": {
        "id": "111",
        "key": "test"
        }
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Request body parameters" %}

The request body contains the information required to create a new issue:

**Required parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| summary | Issue name. | String |
| [queue](#queue) | Queue to create the issue in. | Can be set as an object, a string (if the [queue key](../../manager/create-queue.md#key) is passed), or a number (if the queue ID is passed). |

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| [parent](#parent) | Parent issue. | Object or string. |
| description | Issue description. | String |
| sprint | Block with information about sprints. | Array of objects or strings. |
| [type](#type) | Issue type. | Can be set as an object, a string (if the issue type key is passed), or a number (if the issue type ID is passed). |
| [priority](#priority) | Issue priority. | Can be set as an object, a string (if the priority key is passed), or a number (if the priority ID is passed). |
| [followers](#followers) | IDs or usernames of issue followers. | Array of objects or strings. |
| [assignee](#assignee) | ID or username of the issue assignee. | Array of objects or strings. |
| unique | Field with a unique value that disables creation of duplicate issues. If you try to create an issue with the same value of this parameter again, no duplicate will be created and the response will contain an error with code 409. | String |
| attachmentIds | List of [attachment IDs](temp-attachment.md). | Array of strings |

**Object fields** `queue` {#queue}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Queue ID. | String |
| key | Queue key. | String |

**Object fields** `parent` {#parent}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | ID of the parent issue. | String |
| key | Key of the parent issue. | String |

**Object fields** `type` {#type}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | ID of the issue type. | String |
| key | Key of the issue type. | String |

**Object fields** `priority` {#priority}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Priority ID. | String |
| key | Priority key. | String |

**Object fields** `followers` {#followers}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Employee ID. | String |

**Object fields** `assignee` {#assignee}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Employee ID. | String |

{% endcut %}

> Example: Create an issue
>
>- An HTTP POST method is used.
>- We're creating an issue named <q>Test Issue</q> in the queue with the [key](../../manager/create-queue.md#key) <q>TREK</q>.
>- The new issue is a sub-issue of <q>JUNE-2</q>.
>- Type of the new issue: <q>Bug</q>.
>- Assignee: <user_login>
>
>```
>POST /v2/issues/ HTTP/1.1
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>{{ org-id }}
>
>{
>    "queue": "TREK",
>    "summary": "Test Issue",
>    "parent":"JUNE-2",
>    "type": "bug",
>    "assignee": "<user_login>",
>    "attachmentIds": [55, 56]
>}
>```

## Response format {#section_xc3_53j_p1b}

{% list tabs %}

- Request executed successfully

  {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

  The request body contains information about the created issue in JSON format.

  {% include [answer-issue](../../../_includes/tracker/api/answer-issue.md) %}

- Request failed

  {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

  {% include [answer-error-409](../../../_includes/tracker/api/answer-error-409.md) %}

{% endlist %}

