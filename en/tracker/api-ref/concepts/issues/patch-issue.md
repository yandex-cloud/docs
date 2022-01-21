# Edit an issue

Use this request to make changes to issues.

{% note warning %}

You can only change an issue's status using the [<q>Make a status transition</q>](new-transition.md) request.

{% endnote %}

## Request format {#section_rnm_x4j_p1b}

Before making the request, [get permission to access the API](../access.md).

To edit an issue, use an HTTP `PATCH` request. Request parameters are passed in the request body in JSON format.

```json
PATCH /{{ ver }}/issues/<issue-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
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
  | ----- | ----- | ----- |
  | version | Issue version. Changes are only made to the current version of the issue. | Number |

{% endcut %}

{% cut "Request body parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| summary | Issue name. | String |
| [parent](#req-parent) | Parent issue. | Object or string |
| description | Issue description. | String |
| [sprint](#req-sprint) | Block with information about sprints. | Array of objects or strings |
| [type](#req-type) | Issue type. | Object, string (if the issue type key is passed), or number (if the issue type ID is passed). |
| [priority](#req-priority) | Issue priority. | Object, string (if the priority key is passed), or number (if the priority ID is passed). |
| [followers](#req-followers) | IDs or usernames of issue followers. | Array of objects or strings |

**Object fields** `parent` {#req-parent}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | ID of the parent issue. | String |
| key | Key of the parent issue. | String |

**Object fields** `sprint` {#req-sprint}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Sprint ID. You can get sprint information using the [request](../../get-sprints.md). | Number |

**Object fields** `type` {#req-type}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | ID of the issue type. | String |
| key | Key of the issue type. | String |

**Object fields** `priority` {#req-priority}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Priority ID. | String |
| key | Priority key. | String |

**Object fields** `followers` {#req-followers}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Employee ID. | String |

{% endcut %}

{% cut "Request body format" %}

The request body passes a JSON object with the IDs of updated fields and their values.

- To add or remove an array value, use the `add` or `remove` command:

  - ```json
    {
          "followers": { "add": ["<user1 ID>", "<user2 ID>"] }
    }
    ```

{% note info %}

The `add` command adds new values to the array. To overwrite the array (delete the old values and add new ones), use the `set` command.

{% endnote %}

- To reset the field value, set it to `null`. To reset the array, use an empty array `[]`. You can change individual values in the array using the `target` and `replacement` commands:
  - `{"followers": null}`
  - ```json
    {
      "followers": {
        "replace": [
            {"target": "&lt;ID1&gt;", "replacement": "&lt;ID2&gt;"},
            {"target": "&lt;ID3&gt;", "replacement": "&lt;ID4&gt;"}]
      }
    }
    ```

- For example, to change the issue type to <q>Bug</q>, use one of these methods:
  - `{"type": 1}`
  - `{"type": "bug"}`
  - ```json
    {
        "type": { "id": "1" }
    }
    ```
  - ```json
    {
        "type": { "name": "Bug" }
    }
    ```
  - ```json
    {
        "type": {"set": "bug"}
    }
    ```

{% endcut %}

> Example 1: Change the name, description, type, and priority of an issue.
>
> - An HTTP PATCH method is used.
> - We're editing the TEST-1 issue.
> - New issue type: <q>Bug</q>.
> - New issue priority: <q>Low</q>.
> 
> ```
> PATCH /v2/issues/TEST-1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> {{ org-id }}
> 
> {
>     "summary": "New issue name",
>     "description": "New issue description",
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
> - We're editing the TEST-1 issue.
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

- Successful execution of the request

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains information about the edited issue in JSON format.

  {% include [answer-issue](../../../_includes/tracker/api/answer-issue.md) %}

- The request failed

  If the request is processed incorrectly, the API returns a response with an error code:

  {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

  {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

  {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

  {% include [answer-error-409](../../../_includes/tracker/api/answer-error-409.md) %}

{% endlist %}

