---
sourcePath: en/tracker/api-ref/concepts/issues/create-issue.md
---
# Creating an issue

Use this request to create an issue.

## Request format {#section_rnm_x4j_p1b}

Before making the request, [get permission to access the API](../access.md).

To create an issue, use an HTTP `POST` request. Request parameters are provided in the request body in JSON format:

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
| [queue](#queue) | Queue in which to create the issue. | Can be set as an object, a string (if the [queue key](../../manager/create-queue.md#key) is provided), or a number (if the queue ID is provided). |

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| [parent](#parent) | Parent issue. | Object or string. |
| description | Issue description. | String |
| sprint | Block with information about sprints. | Array of objects or strings. |
| [type](#type) | Issue type. | Can be set as an object, a string (if the issue type key is provided), or a number (if the issue type ID is provided). |
| [priority](#priority) | Issue priority. | Can be set as an object, a string (if the priority key is provided), or a number (if the priority ID is provided). |
| [followers](#followers) | IDs or usernames of issue followers. | Array of objects, numbers, or strings. |
| [assignee](#assignee) | ID or username of issue assignee. | Object, number, or string. |
| [author](#author) | ID or username of issue author. | Object, number, or string. |
| unique | Field with a unique value that disables creation of duplicate issues. If you try to create an issue with the same value of this parameter again, no duplicate will be created and the response will contain an error with code 409. | String |
| attachmentIds | List of [attachment IDs](temp-attachment.md). | Array of strings |

**Object fields** `queue` {#queue}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Queue ID | String |
| key | Queue key | String |

**Object fields** `parent` {#parent}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Parent issue ID | String |
| key | Parent issue key | String |

**Object fields** `type` {#type}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Issue type ID | String |
| key | Issue type key | String |

**Object fields** `priority` {#priority}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Priority ID | String |
| key | Priority key | String |

**Object fields** `followers` {#followers}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Employee ID | String |

**Object fields** `assignee` {#assignee}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Employee ID | String |

**Object fields** `author` {#author}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Employee ID | String |

{% endcut %}

> Example: Create an issue
>
> - Method: HTTP POST.
> - We are creating an issue named <q>Test Issue</q> in the queue with the <q>TREK</q> [key](../../manager/create-queue.md#key).
> - The new issue is a sub-issue of <q>JUNE-2</q>.
> - Type of the new issue: <q>Bug</q>.
> - Assignee: <user_login>
>
> ```
> POST /v2/issues/ HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> {{ org-id }}
>
> {
>     "queue": "TREK",
>     "summary": "Test Issue",
>     "parent":"JUNE-2",
>     "type": "bug",
>     "assignee": "<user_login>",
>     "attachmentIds": [55, 56]
> }
> ```

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
