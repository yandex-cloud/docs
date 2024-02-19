---
sourcePath: en/tracker/api-ref/concepts/entities/comments/patch-comment.md
---
# Editing a comment

The request allows you to edit an [entity](../about-entities.md) comment.

## Request format {#query}

Before making a request, [get permission to access the API](../../access.md).

To edit an entity comment, use an HTTP `PATCH` request. Request parameters are provided in the request body in JSON format.

```json
PATCH /{{ ver }}/entities/<entity_type>/<entity_ID>/comments
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}

{
  "text": "<comment_text>",
  "summonees": ["<summonee_ID_or_login>"]
}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity-comment.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| isAddToFollowers | Adding a comment author to followers. The default value is `true`. | Logical |
| notify | Notify the users specified in the **Author**, **Responsible**, **Members**, **Clients**, and **Followers** fields. The default value is `true`. | Logical |
| notifyAuthor | Notify the author of the changes. The default value is `false`. | Logical |
| expand | Additional information to be included into the response: <ul><li>`all`: All</li><li>`attachments`: HTML markup of a comment</li><li>`attachments`: Attached files</li><li>`reactions`: Reactions to a comment</li></ul> | String |

{% endcut %}

{% cut "Request body parameters" %}

The request body contains the information needed to edit a comment:

**Additional parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| text | Text of the comment. | String |
| attachmentIds | List of [attachment IDs](../../issues/temp-attachment.md). | Array of strings |
| summonees | IDs or usernames of invited users. | Array of objects or strings |
| maillistSummonees | List of mailing lists mentioned in the comment. | Array of strings |

{% endcut %}

> Example: Editing a comment
>
> - An HTTP PATCH method is used.
> - The comment text is modified: Edited comment text.
> - The list of summonees is modified.
> ```
> PATCH /v2/entities/project/<project_ID>/comments/31
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
>
> {
>    "text": "<modified_comment_text>",
>    "summonees": ["<user_1_ID_or_login>", "<user_2_ID_or_login>"]
> }
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../../_includes/tracker/api/answer-200.md) %}

   The response body contains information about the comment in JSON format.

   ```json
   {
       "self": "{{ host }}/v2/entities/project/6586d6fee2b9ef74********/comments/31",
       "id": 31,
       "longId": "65a1ba7b46b9746d********",
       "text": "Edited comment text.",
       "createdBy": {
           "self": "{{ host }}/v2/users/19********",
           "id": "19********",
           "display": "Full Name",
           "cloudUid": "ajeppa7dgp53********",
           "passportUid": "15********"
       },
       "updatedBy": {
           "self": "{{ host }}/v2/users/19********",
           "id": "19********",
           "display": "Full Name",
           "cloudUid": "ajeppa7dgp53********",
           "passportUid": "15********"
       },
       "createdAt": "2024-01-12T22:17:31.176+0000",
       "updatedAt": "2024-01-12T22:17:31.176+0000",
       "summonees": [
           {
               "self": "{{ host }}/v2/users/19********",
               "id": "19********",
               "display": "Full Name",
               "cloudUid": "ajeppa7dgp53********",
               "passportUid": "15********"
           },
           {
               "self": "{{ host }}/v2/users/19********",
               "id": "19********",
               "display": "Full Name",
               "cloudUid": "ajeppa7dgp32********",
               "passportUid": "12********"
           }
       ],
       "maillistSummonees" : [
           {
               "self" : "{{ host }}/v2/maillists/usertest@test.ru",
               "id" : "usertest@test.ru",
               "display" : "Ivan's mailing list"
    }
   ],
       "version": 1,
       "type": "standard",
       "transport": "internal"
   }
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the comment object. | String |
   | id | Comment ID. | Number |
   | longId | Comment ID as a string. | String |
   | text | Text of the comment. | String |
   | textHtml | Comment HTML markup. | String |
   | attachments | Attached files. | String |
   | [createdBy](#created-by) | Object with information about the author of the comment. | Object |
   | [updatedBy](#updated-by) | Object with information about the last user to have updated the comment. | Object |
   | createdAt | Comment creation date and time in the format:<br/>```YYYY-MM-DDThh:mm:ss.sss±hhmm ``` | String |
   | updatedAt | Comment update date and time in the format:<br/>```YYYY-MM-DDThh:mm:ss.sss±hhmm ```. | String |
   | summonees | List of users summoned in comments. | List of objects |
   | maillistSummonees | List of mailing lists mentioned in the comment. | List of objects |
   | version | Comment version. Each update increases the comment's version number. | Number |
   | type | Comment type:<ul><li>`standard`: Comment sent via the {{ tracker-name }} interface.</li><li>`incoming`: Comment created from an incoming message.</li><li>`outcoming`: Comment created from an outgoing message.</li></ul> | String |
   | transport | Method of adding a comment:<ul><li>`internal`: Via the {{ tracker-name }} interface.</li><li>`email`: Via email.</li></ul> | String |

   `createdBy` **object fields** {#created-by}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user. | String |
   | id | User ID. | Number |
   | display | Displayed user name. | String |
   | cloudUid | User unique ID in {{ org-full-name }}. | String |
   | passportUid | Unique ID of the user account in the {{ ya-360 }} organization and Yandex ID. | String |

   `updatedBy` **object fields** {#updated-by}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user. | String |
   | id | User ID. | Number |
   | display | Displayed user name. | String |
   | cloudUid | User unique ID in {{ org-full-name }}. | String |
   | passportUid | Unique ID of the user account in the {{ ya-360 }} organization and Yandex ID. | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [error-400](../../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error-404](../../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [error-422](../../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
