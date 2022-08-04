---
sourcePath: en/tracker/api-ref/concepts/issues/edit-comment.md
---
# Edit a comment

Use this request to edit comments.

## Request format {#section_rkq_bhl_dfb}

Before making the request, [get permission to access the API](../access.md).

To edit a comment previously [added to an issue](add-comment.md), use an HTTP `PATCH` request. Request parameters are passed in the request body in JSON format:

```json
PATCH /{{ ver }}/issues/<issue-id>/comments/<comment-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
   "text": "<new comment text>"
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<issue-id> | ID or key of the current issue. | String |
| \<comment-id> | [Unique ID of the comment](get-comments.md#section_xc3_53j_p1b) in numeric (id) or string format (longId). | String or number |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Value | Data type |
| ----- | ----- | ----- |
| text | Edited issue comment. | String |

**Additional parameters**

| Parameter | Value | Data type |
| ----- | ----- | ----- |
| attachmentIds | List of [attachment IDs](temp-attachment.md). | Array of strings |

{% endcut %}

## Response format {#section_rcd_ysf_2fb}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains information about the added comment in JSON format.

  ```json
  [ 
  {
    "self" : "{{ host }}/v2/issues/TREK-1/comments/684",
    "id" : "684",  
    "longId" : "5fc4bc634e121b12f44a0488",  
    "text": "<comment text>",
    "createBody" : {
     "self" : "{{ host }}/v2/users/1120000000016876",
     "id" : "<user ID>",
     "display" : "<user's name displayed"
    },
    "updateBody" : {
     "self" : "{{ host }}/v2/users/1120000000016876",
     "id" : "<user ID>",
     "display" : "<user's name displayed"
    },
    "createdAt" : "2020-11-30T09:33:23.638+0000",  
    "updatedAt" : "2020-11-30T09:39:07.631+0000",  
    "summonees" : [
     { 
      "self" : "{{ host }}/v2/users/1120000000016576",
      "id" : "<user ID>",
      "display" : "<user's name displayed"
     } 
    ],
   "maillistSummonees" : [
     { 
      "self" : "{{ host }}/v2/maillists/usertest@test.ru",
      "id" : "<mailing list address>",
      "display" : "<mailing list name displayed>"
     } 
    ], 
    "version" : 2,  
    "type" : "standard",  
    "transport" : "internal"
  }
  ]
  ```

  {% cut "Response parameters" %}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Link to the comment. | String |
  | id | Comment ID. | String |
  | longId | ID of the comment in string format. | String |
  | text | Comment on the issue. | String |
  | [createdBy](#object-fields-createdBy) | Block with information about the user who added the comment. | Object |
  | [updatedBy](#object-fields-updatedBy) | Block with information about the user who edited the comment last. | Object |
  | createdAt | Comment creation date and time. | String |
  | updatedAt | Comment update date and time. | String |
  | [summonees](#object-fields-summonees) | Block with information about users who are invited in comments. | Object |
  | [maillistsummonees](#object-fields-maillistsummonees) | Block with information about mailing lists mentioned in comments. | Object |
  | version | Comment version. Each change to the comment increases its version number. | Number |
  | type | Comment type:<ul><li>`standard`: Comment sent via the {{ tracker-name }} interface.</li><li>`incoming`: Comment created from an incoming message.</li><li>`outcoming`: Comment created from an outgoing message.</li></ul> | String |
  | transport | Method of adding a comment:<ul><li>`internal`: Via the {{ tracker-name }} interface.</li><li>`email`: Via email.</li></ul> | String |

  **Object fields** `createdBy` {#object-fields-createdBy}

  {% include [user](../../../_includes/tracker/api/user.md) %}

  **Object fields** `updatedBy` {#object-fields-updatedBy}

  {% include [user](../../../_includes/tracker/api/user.md) %}

  **Object fields** `summonees` {#object-fields-summonees}

  {% include [user](../../../_includes/tracker/api/user.md) %}

  **Object fields** `maillistsummonees` {#object-fields-maillistsummonees}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Link to the mailing list. | String |
  | id | Mailing list address. | String |
  | display | Mailing list name displayed. | String |

  {% endcut %}

- Request failed

  If the request is processed incorrectly, the API returns a response with an error code:

  {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

  {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

