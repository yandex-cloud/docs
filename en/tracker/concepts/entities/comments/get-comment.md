---
sourcePath: en/tracker/api-ref/concepts/entities/comments/get-comment.md
---
# Getting an entity comment

The request allows you to get an [entity](../about-entities.md) comment.

## Request format {#query}

Before making a request, [get permission to access the API](../../access.md).

To get a comment, use an HTTP `GET` request.

```json
GET /{{ ver }}/entities/<entity_type>/<entity_ID>/comments/<comment_ID>
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity-comment.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| expand | Additional information to be included into the response: <ul><li>`all`: All</li><li>`html`: Comment HTML markup</li><li>`attachments`: Attached files</li><li>`reactions`: Reactions to a comment</li></ul> | String |

{% endcut %}

> Example: Getting a comment
>
> - An HTTP GET method is used.
> - The response displays information about the comment.
>
> ```
> GET /v2/entities/project/<project_ID>/comments/15?expand=all
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../../_includes/tracker/api/answer-200.md) %}

   The response body contains information about the entity comment in JSON format.

   ```json
   {
       "self": "{{ host }}/v2/entities/project/6586d6fee2b9ef74********/comments/15",
       "id": 15,
       "longId": "65a156a29d5d2000********",
       "text": "Comment **number one.**",
       "textHtml": "<p>Comment <strong>number one.</strong></p>\n",
       "attachments": [
           {
               "self": "{{ host }}/v2/entities/project/6586d6fee2b9ef74********/attachments/25",
               "id": "25",
               "display": "image.jpg"
           }
       ],
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
       "createdAt": "2024-01-12T15:11:30.278+0000",
       "updatedAt": "2024-01-12T16:33:35.988+0000",
       "usersReacted": {
           "like": [
               {
                   "self": "{{ host }}/v2/users/19********",
                   "id": "19********",
                   "display": "Full Name",
                   "cloudUid": "ajeppa7dgp71********",
                   "passportUid": "16********"
               }
           ]
       },
       "ownReactions": ["like"],
       "summonees": [
           {
               "self": "{{ host }}/v2/users/19********",
               "id": "19********",
               "display": "Full Name",
               "cloudUid": "ajeppa7dgp32********",
               "passportUid": "12********"
           }
       ],
       "version": 3,
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
   | usersReacted | User reactions (present in the response if the `expand` parameter in the request is set to `all` or `reactions`):<ul><li>`like`</li><li>`dislike`</li><li>`laugh`</li><li>`tada`</li><li>`hooray`</li><li>`confused`</li><li>`heart`</li><li>`rocket`</li><li>`eyes`</li><li>`fire`</li><li>`ok`</li><li>`facepalm`</li><li>`check`</li></ul> | Object with a list of reactions and responders |
   | reactionsCount | Number of reactions (present in the response if the `expand` parameter in the request is not set to `all` or `reactions`). | Object with a list and number of reactions |
   | ownReactions | Reactions of the comment author:<ul><li>`like`</li><li>`dislike`</li><li>`laugh`</li><li>`tada`</li><li>`hooray`</li><li>`confused`</li><li>`heart`</li><li>`rocket`</li><li>`eyes`</li><li>`fire`</li><li>`ok`</li><li>`facepalm`</li><li>`check`</li></ul> | List of strings |
   | summonees | List of users summoned in comments. | List of objects |
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

   `usersReacted` **object fields** {#users-reacted}

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
