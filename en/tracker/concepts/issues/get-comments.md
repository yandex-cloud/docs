---
sourcePath: en/tracker/api-ref/concepts/issues/get-comments.md
---
# Get issue comments

Use this request to get a list of comments on an issue.

By default, the request returns only the first page showing 50 comments. If there are more than 50 comments, use [paginated output](#pagination).

## Request format {#section_rnm_x4j_p1b}

Before making a request, [get permission to access the API](../access.md).

To get a list of comments, use an HTTP `GET` request:

```json
GET /{{ ver }}/issues/<issue-id>/comments
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %}

{% cut "Request parameters" %}

**Additional parameters**
Parameter | Description | Data type
----- | ----- | -----
expand | Additional fields to include in the response: <ul><li>`attachments`: Attached files</li><li>`html`: Comment HTML markup</li><li>`all`: All additional fields</li></ul> | String

{% endcut %}

> Request for comments on a single issue:
>
> An HTTP GET method is used.
>
> ```
> GET /v2/issues/JUNE-3/comments?expand=all HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> {{ org-id }}
> ```

## Response format {#section_xc3_53j_p1b}

{% list tabs %}

- Request executed successfully


    {% include [answer-200](../../../_includes/tracker/api/answer-200.md %}

    The response body contains a JSON array with information about comments:

    ```json
    [
        {
            "self": "{{ host }}/v2/issues/JUNE-2/comments/9849018",
            "id": 9849018,
            "longId" : "5fa15a24ac894475dd14ff07",
            "text": "Comment **number one.**",
            "textHtml": "<p>Comment <strong>number one.</strong></p>\n",
            "attachments": [{ "self": "https://api.tracker.yandex.net/v2/issues/JUNE-3/attachments/1", "id": "1", "display": "Untitled.png" }],
            "createdBy": {
                "self": "{{ host }}/v2/users/1120000000049224",
                "id": "<employee ID>",
                "display": "<displayed employee name>"
            },
            "updatedBy": {
                "self": "{{ host }}/v2/users/1120000000049224",
                "id": "<employee ID>",
                "display": "<displayed employee name>"
            },
            "createdAt": "2017-06-11T05:11:12.347+0000",
            "updatedAt": "2017-06-11T05:11:12.347+0000",
            "version": 1,
            "type" : "standard",
            "transport" : "internal" 
        },
        ...
    ]
    ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the comment object. | String |
   | id | Comment ID. | Number |
   | longId | ID of the comment in string format. | String |
   | text | Text of the comment. | String |
   | textHtml | Comment HTML markup. | String |
   | attachments | Attached files. | String |
   | [createdBy](#object-fields-createdBy) | Object with information about the author of the comment. | Objects |
   | [updatedBy](#object-fields-updatedBy) | Object with information about the last user to have updated the comment. | Objects |
   | createdAt | Comment creation date and time in the format: <br/>```YYYY-MM-DDThh:mm:ss.sss±hhmm ``` | String |
   | updatedAt | Comment update date and time.<br/>``` YYYY-MM-DDThh:mm:ss.sss±hhmm ``` | String |
   | version | Comment version. Each update increases the comment's version number. | Number |
   | type | Comment type:<ul><li>`standard`: Comment sent via the {{ tracker-name }} interface.</li><li>`incoming`: Comment created from an incoming message.</li><li>`outcoming`: Comment created from an outgoing message.</li></ul> | String |
   | transport | Method of adding a comment:<ul><li>`internal`: Via the {{ tracker-name }} interface.</li><li>`email`: Via email.</li></ul> | String |

    **Object fields** `createdBy` {#object-fields-createdBy}

   {% include [user](../../../_includes/tracker/api/user.md) %}

    **Object fields** `updatedBy` {#object-fields-updatedBy}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

## Pagination of comments {#pagination}

For paginated results, use additional parameters in the request string:

```json
GET /{{ ver }}/issues/<issue-id>/comments?perPage=20&id=123
```

Where:

* `perPage`: Number of comments per page.

* `id`: Comment's `id` parameter value after which the requested page will begin.

The links to the first and next pages are specified in the **Link** response header.

To learn about paginated results, see also [Generic request format](../../common-format.md#displaying-results).