# Import comments

{% note warning %}

This request can only be executed if the user has permission to edit the issue that comments are imported to.

{% endnote %}

Use this request to import to {{ tracker-name }} comments on issues.

## Request format {#section_i14_lyb_p1b}

To import a comment, use an HTTP `POST` request. Comment parameters are passed in the request body in JSON format:

```json
POST /{{ ver }}/issues/<issue_id>/comments/_import
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}

{
  "text": "Test",
  "createdAt": "2017-08-29T12:34:41.740+0000",
  "createdBy": 1110000000011111
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| --- | --- | --- |
| \<issues-id\> | Key of the issue to attach the file to. | String |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| text | Text of the comment, no more than 512,000 characters. | String |
| createdAt | Comment creation date and time in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. You can specify any value in the interval from the issue's creation time to its latest update. | String |
| createdBy | Username or ID of the user who made the comment. | <ul><li>String for the username</li><li>Number for the ID</li></ul> |

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| updatedAt | Date and time of the comment's last update in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. You can specify any value in the interval from the time of issue creation to the time it was last updated.<br/><br/>The parameter is only used together with the `updatedBy` parameter. | String |
| updatedBy | Username or ID of the user who edited the comment last.<br/><br/>The parameter is only used together with the `updatedAt` parameter. | <ul><li>String for the username</li><li>Number for the ID</li></ul> |

{% endcut %}

## Response format {#section_isd_myb_p1b}

{% list tabs %}

- Successful execution of the request

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains the parameters of the attached file in JSON format:

    ```json
    {
            "self": "{{ host }}/v2/issues/JUNE-2/comments/9849018",
            "id": 9849018,
            "longId" : "5fa15a24ac894475dd14ff07",
            "text": "Comment",
            "createdBy": {
                "self": "{{ host }}/v2/users/1120000000049224",
                "id": "<employee ID>",
                "display": "<employee name displayed>"
            },
            "updatedBy": {
                "self": "{{ host }}/v2/users/1120000000049224",
                "id": "<employee ID>",
                "display": "<employee name displayed>"
            },
            "createdAt": "2017-06-11T05:11:12.347+0000",
            "updatedAt": "2017-06-11T05:11:12.347+0000",
            "version": 1,
            "type" : "standard",
            "transport" : "internal"   
    }
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Link to the comment object | String |
    | id | Comment ID | Number |
    | longId | ID of the comment in string format. | String |
    | text | Text of the comment. | String |
    | [createdBy](#createdBy) | Object with information about the user who added the comment. | Object |
    | [updatedBy](#updatedBy) | Object with information about the user who edited the comment last. | Object |
    | createdAt | Comment creation date and time in <br/>``` YYYY-MM-DDThh:mm:ss.sss±hhmm ``` format | String |
    | updatedAt | Comment update date and time.<br/>``` YYYY-MM-DDThh:mm:ss.sss±hhmm ``` | String |
    | version | Comment version. Each change to the comment increases its version number. | Number |
    | type | Comment type:<ul><li>**standard**: Comment sent via the {{ tracker-name }} interface.</li><li>**incoming**: Comment created from an incoming message.</li><li>**outcoming**: Comment created from an outgoing message.</li></ul> | String |
    | transport | Method of adding a comment:<ul><li>**internal**: Via the {{ tracker-name }} interface.</li><li>**email**: Via email.</li></ul> | String |

    **Object fields** `createdBy` {#createdBy}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Link to the user. | String |
    | id | User ID. | String |
    | display | User's name displayed. | String |

    **Object fields** `updatedBy` {#updatedBy}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Link to the user. | String |
    | id | User ID. | String |
    | display | User's name displayed. | String |

    {% endcut %}

- The request failed

    If the request is processed incorrectly, the API returns a message with error details:

    {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-422.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}