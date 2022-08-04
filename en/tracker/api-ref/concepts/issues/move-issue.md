# Moving an issue to another queue

Use this request to move an issue to a different queue.

Before executing the request, make sure the user has permission to edit the issues to be moved and is allowed to create them in the new queue.

{% note warning %}

If an issue you want to move has a type and status that are missing in the target queue, no transfer will be made. To reset the issue status to the initial value when moving it, use the `InitialStatus` parameter.

By default, when an issue is moved, the values of its components, versions, and projects are cleared. If the new queue has the same values of the fields specified, use the `MoveAllFields` parameter to move the components, versions, and projects.

If the issue has the [local field](../../local-fields.md) values specified, they will be reset when moving the issue to a different queue.

{% endnote %}

## Request format {#section_rnm_x4j_p1b}

Before making the request, [get permission to access the API](../access.md).

To move issues, use an HTTP `POST` request:

```json
POST /{{ ver }}/issues/<issue-id>/_move?queue=<queue-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %}

{% cut "Request parameters" %}

**Required parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<queue-id\> | Key of the queue to move the issue to. | String |

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| notify | Flag notifying users about changes to the issue:<ul><li>`true` (by default): The users specified in the issue fields are notified.</li><li>`false`: No users are notified.</li></ul> | Boolean |
| notifyAuthor | Flag notifying the issue reporter:<ul><li>`true`: The reporter is notified.</li><li>`false` (by default): The reporter is not notified.</li></ul> | Boolean |
| moveAllFields | Shows whether to move the issue's versions, components, and projects to the new queue:<ul><li>`true`: Move them if the new queue has similar versions, components, and projects.</li><li>`false` (by default): Clear the versions, components, and projects.</li></ul> | Boolean |
| initialStatus | Resetting the issue status. The status is reset if the issue is moved to another queue with a different [workflow](../../manager/add-workflow.md):<ul><li>`true`: Reset the status.</li><li>`false` (by default): Retain the status as is.</li></ul> | Boolean |
| expand | Additional fields to be included in the response:<ul><li>`attachments`: Attachments.</li><li>`comments`: Comments.</li><li>`workflow`: Issue workflow.</li><li>`transitions`: Workflow transitions between statuses.</li></ul> | String |

{% endcut %}

{% cut "Request body parameters" %}

You can use the request body if you need to change the parameters of the issue being moved. The request body has the same format as when [editing issues](patch-issue.md#req-body-params).

{% endcut %}

>Example: Move an issue
>
>- An HTTP POST method is used.
>- We're moving the <q>TEST-1</q> issue to the <q>NEW</q> queue.
>
>```
>POST /v2/issues/TEST-1/_move?queue=NEW
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>{{ org-id }}
>```

## Response format {#section_xpm_q1y_51b}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains the results in JSON format.

    ```json
    {
        "self": "{{ host }}/v2/issues/NEW-1",
        "id": "1a2345678b",
        "key": "NEW-1",
        "version": 2,
        "aliases": [
            "TEST-1"
        ],
        "previousQueue": {
            "self": "{{ host }}/v2/queues/TEST",
            "id": "3",
            "key": "TEST",
            "display": "TEST"
        },
        "description": "<issue description>",
        "type": {
            "self": "{{ host }}/v2/issuetypes/2",
            "id": "2",
            "key": "task",
            "display": "Issue"
        },
        "createdAt": "2020-09-04T14:18:56.776+0000",
        "updatedAt": "2020-11-12T12:38:19.040+0000",
        "lastCommentUpdatedAt": "2020-10-18T13:33:44.291+0000",
        },
        "summary": "Test",
        "updatedBy": {
            "self": "{{ host }}/v2/users/1234567890",
            "id": "1234567890",
            "display": "First and Last name"
        },
        "priority": {
            "self": "{{ host }}/v2/priorities/3",
            "id": "3",
            "key": "normal",
            "display": "Medium"
        },
        "followers": [
            {
                "self": "{{ host }}/v2/users/1234567890",
                "id": "1234567890",
                "display": "First and Last name"
            }
        ],
        "createdBy": {
            "self": "{{ host }}/v2/users/1234567890",
            "id": "1234567890",
            "display": "First and Last name"
        },
        "assignee": {
            "self": "{{ host }}/v2/users/1234567890",
            "id": "1234567890",
            "display": "First and Last name"
        },
        "queue": {
            "self": "{{ host }}/v2/queues/NEW",
            "id": "5",
            "key": "NEW",
            "display": "Queue"
        },
        "status": {
            "self": "{{ host }}/v2/statuses/8",
            "id": "1",
            "key": "open",
            "display": "Open"
        },
        "previousStatus": {
            "self": "{{ host }}/v2/statuses/1",
            "id": "1",
            "key": "open",
            "display": "Open"
        },
        "favorite": false
    }
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Address of the API resource with information about the issue. | String |
    | id | Issue ID. | String |
    | key | Issue key. | String |
    | version | Issue version. Each change to the issue parameters increases its version number. | Number |
    | aliases | Array with information about alternative issue keys. | Array of strings |
    | [previousQueue](#previous-queue) | Object with information about the issue's previous queue. | Object |
    | description | Issue description. | String |
    | [type](#type) | Object with information about the issue type. | Object |
    | createdAt | Issue creation date and time. | String |
    | updatedAt | Issue update date and time. | String |
    | lastCommentUpdatedAt | Date and time when the last comment was added. | String |
    | summary | Issue name. | String |
    | [updatedBy](#updated-by) | Object with information about the user who edited the issue last. | Object |
    | [priority](#priority) | Object with information about the priority. | Object |
    | [followers](#followers) | Array of objects with information about issue followers. | Array of strings |
    | [createdBy](#created-by) | Object with information about the user who created the issue. | Object |
    | [assignee](#assignee) | Object with information about the issue's assignee. | Object |
    | [queue](#queue) | Object with information about the issue queue. | Object |
    | [status](#status) | Object with information about the issue status. | Object |
    | [previousStatus](#previous-status) | Object with information about the previous status of the issue. | Object |
    | favorite | Flag indicating a favorite issue:<ul><li>`true`: Notifications are disabled.</li><li>`false`: Notifications are enabled.</li></ul> | Boolean |

    **Object fields** `previousQueue` {#previous-queue}

    {% include [queue](../../../_includes/tracker/api/queue.md) %}

    {% include [type](../../../_includes/tracker/api/type.md) %}

    **Object fields** `updatedBy` {#updated-by}

    {% include [user](../../../_includes/tracker/api/user.md) %}

    {% include [priority](../../../_includes/tracker/api/priority.md) %}

    **Object array fields** `followers` {#followers}

    {% include [user](../../../_includes/tracker/api/user.md) %}

    **Object fields** `createdBy` {#created-by}

    {% include [user](../../../_includes/tracker/api/user.md) %}

    **Object fields** `assignee` {#assignee}

    {% include [user](../../../_includes/tracker/api/user.md) %}

    **Object fields** `queue` {#queue}

    {% include [queue](../../../_includes/tracker/api/queue.md) %}

    **Object fields** `status` {#status}

    {% include [status](../../../_includes/tracker/api/status.md) %}

    **Object fields** `previousStatus` {#previousStatus}

    {% include [status](../../../_includes/tracker/api/status.md) %}

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

