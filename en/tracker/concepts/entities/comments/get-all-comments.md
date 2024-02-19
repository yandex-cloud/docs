---
sourcePath: en/tracker/api-ref/concepts/entities/comments/get-all-comments.md
---
# Getting comments for the entity

The request allows you to get a list of comments for an [entity](../about-entities.md).

## Request format {#query}

Before making a request, [get permission to access the API](../../access.md).

To get comments, use an HTTP `GET` request.

```json
GET /{{ ver }}/entities/<entity_type>/<entity_ID>/comments
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| expand | Additional information to be included into the response: <ul><li>`all`: All</li><li>`html`: Comment HTML markup</li><li>`attachments`: Attached files</li><li>`reactions`: Reactions to a comment</li></ul> | String |

{% endcut %}

> Example: Getting a list of comments
>
> - An HTTP GET method is used.
> - The response displays information about all comments.
>
> ```
> GET /v2/entities/project/<project_ID>/comments?expand=all
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../../_includes/tracker/api/answer-200.md) %}

   The response body contains information about entity comments in JSON format.

   ```json
   [
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
   ]
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
   | [usersReacted](#users-reacted) | User reactions (present in the response if the `expand` parameter in the request is set to `all` or `reactions`):<ul><li>`like`</li><li>`dislike`</li><li>`laugh`</li><li>`tada`</li><li>`hooray`</li><li>`confused`</li><li>`heart`</li><li>`rocket`</li><li>`eyes`</li><li>`fire`</li><li>`ok`</li><li>`facepalm`</li><li>`check`</li></ul> | Object with a list of reactions and responders |
   | reactionsCount | Number of reactions (present in the response if the `expand` parameter in the request is not set to `all` or `reactions`). | Object with a list and number of reactions |
   | ownReactions | Reactions of the comment author:<ul><li>`like`</li><li>`dislike`</li><li>`laugh`</li><li>`tada`</li><li>`hooray`</li><li>`confused`</li><li>`heart`</li><li>`rocket`</li><li>`eyes`</li><li>`fire`</li><li>`ok`</li><li>`facepalm`</li><li>`check`</li></ul> | List of strings |
   | summonees | IDs or usernames of invited users. | Array of objects or strings |
   | maillistSummonees | List of mailing lists mentioned in the comment. | Array of strings |
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

## Paginated display of entity comments {#pagination}

For paginated display of results, use an HTTP `GET` request.

```json
GET /{{ ver }}/entities/<entity_type>/<entity_ID>/comments/_relative
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

Specify additional parameters in the query string:

#|
|| **Parameter** | **Description** | **Data type** ||
|| perPage | Defines the maximum number of comments in a response. Default value is 50 | Number ||
|| from | ID of the comment after which the list starts to be generated. The comment itself is not included in the list. Not used together with the `selected` parameter. | String ||
|| selected | ID of the comment around which the list is generated. Not specified with the `from` parameter. The list is generated in the following order (for `perPage=5`):
1. Comment with the specified ID.
2. Comment preceding the first comment.
3. Comment following the first comment.
4. Comment preceding the second comment.
5. Сomment following the third comment. | String ||
|| newCommentsOnTop | Reverses the order of comments in the list. The default value is `false`. | Logical ||
|| direction | Determines the order of comments in the list:
* `forward` (default)
* `backward`: Inverts the `newCommentsOnTop` parameter value. | String ||
|#

If no parameters are specified, the full list of entities is displayed.

> Example: Getting a list of comments
>
> - An HTTP GET method is used.
> - The response displays information about three comments starting with `65a1bdbdb02b780b31********`.
>
> ```
> GET /v2/entities/project/<project_ID>/comments/_relative?perPage=3&from=65a1bdb02b780b31********
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
> ```

## Response format with paginated comments {#answer-pagination}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../../_includes/tracker/api/answer-200.md) %}

   The response body contains information about entity comments in JSON format.

   ```json
   {
       "comments": [
           {
               "self": "{{ host }}/v2/entities/project/65a1bdb02b780b31********/comments/22",
               "id": 22,
               "longId": "65a1bdb02b780b31********",
               "text": "Previous comment.",
               ...
           },
           {
               "self": "{{ host }}/v2/entities/project/65a1bdb02b780b32********/comments/23",
               "id": 23,
               "longId": "65a1bdb02b780b32********",
               "text": "Specified comment.",
               ...
           },
           {
               "self": "{{ host }}/v2/entities/project/65a1bdb02b780b33********/comments/24",
               "id": 24,
               "longId": "65a1bdb02b780b33********",
               "text": "Next comment.",
               ...
           }
       ],
       "hasNext": True,
       "hasPrev": True
   }
   ```


   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | comments | List of comments. | List of objects |
   | hasNext | Indicates the presence of subsequent entries in the list. | Logical |
   | hasPrev | Indicates the presence of previous entries in the list. | Logical |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [error-400](../../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error-404](../../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [error-422](../../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
