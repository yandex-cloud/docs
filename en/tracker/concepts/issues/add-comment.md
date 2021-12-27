---
sourcePath: en/tracker/api-ref/concepts/issues/add-comment.md
---
# Add a comment

Use this request to add a comment to an issue.

## Request format {#section_rkq_bhl_dfb}

To add a comment to an issue, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format:

```json
POST /{{ ver }}/issues/<issue-id>/comments?isAddToFollowers=<true|false>
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>

{
   "text": "<comment text>",
   "attachmentIds": [<comma-separated IDs of attached files>],
   "summonees": ["<username of the user>", {"id": "<user ID>"}],
   "maillistSummonees": ["<comma-separated addresses of mentioned mailing lists>"]
}
```

#### Resource {#resource}

- **\<issue-id\>**
Issue ID or key.

#### Headers {#titles}

- **Host**
Address of the node that provides the API:

     ```
     {{ host }}
     ```
- **Authorization**
OAuth token in `OAuth <token value>` format, such as:

     ```
     OAuth 0c4181a7c2cf4521964a72ff57a34a07
     ```
- **X-Org-ID**
Organization ID.

#### Request parameters {#req-params}

- **isAddToFollowers**
Add the author of the comment to issue followers (**true** by default).

#### Request body {#req-body-params}

| Parameter | Value | Data type |
| ----- | ----- | ----- |
| text | Comment on the issue. Required. | String |
| attachmentIds | List of [attachment IDs](temp-attachment.md). | Array of strings |
| summonees | IDs or usernames of invited users. | Array of objects or strings |
| maillistSummonees | List of mailing lists mentioned in the comment. | Array of strings |

## Response format {#section_rcd_ysf_2fb}

{% list tabs %}

- Request executed successfully

    If the request is successful, the API returns a response with code 201. The response body contains information about the added comment in JSON format.

    ```json
    [ 
    {
      "self" : "https://api.tracker.yandex.net/v2/issues/TREK-1/comments/626",
      "id" : 626,  
      "longId" : "5fa15a24ac894475dd14ff07",  
      "text" : "<comment text>",
      "createBody" : {
       "self" : "https://api.tracker.yandex.net/v2/users/1120000000016876",
       "id" : "<user ID>",
       "display" : "<user's name displayed"
      },
      "updateBody" : {
       "self" : "https://api.tracker.yandex.net/v2/users/1120000000016876",
       "id" : "<user ID>",
       "display" : "<user's name displayed"
      },
      "createdAt" : "2020-11-03T13:24:52.575+0000",  
      "updatedAt" : "2020-11-03T13:24:52.575+0000",  
      "summonees" : [
       { 
        "self" : "https://api.tracker.yandex.net/v2/users/1120000000016576",
        "id" : "<user ID>",
        "display" : "<user's name displayed"
       } 
      ],
     "maillistSummonees" : [
       { 
        "self" : "https://api.tracker.yandex.net/v2/maillists/usertest@test.ru",
        "id" : "<mailing list address>",
        "display" : "<mailing list name displayed>"
       } 
      ], 
      "version" : 1,  
      "type" : "standard",  
      "transport" : "internal"
    }
    ]
    ```

    #### Response parameters {#answer-params}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Link to the comment. | String |
    | id | Comment ID. | Number |
    | longId | ID of the comment in string format. | String |
    | text | Comment on the issue. | String |
    | [createdBy](#object-fields-createdBy) | Block with information about the user who added the comment. | Object |
    | [updatedBy](#object-fields-updatedBy) | Block with information about the user who edited the comment last. | Object |
    | createdAt | Comment creation date and time. | String |
    | updatedAt | Comment update date and time. | String |
    | [summonees](#object-fields-summonees) | Block with information about users who are invited in comments. | Object |
    | [maillistsummonees](#object-fields-maillistsummonees) | Block with information about mailing lists mentioned in comments. | Object |
    | version | Comment version. Each change to the comment increases its version number. | Number |
    | type | Comment type:<ul><li>**standard**: Comment sent via the {{ tracker-name }} interface.</li><li>**incoming**: Comment created from an incoming message.</li><li>**outcoming**: Comment created from an outgoing message.</li></ul> | String |
    | transport | Method of adding a comment:<ul><li>**internal**: Via the {{ tracker-name }} interface.</li><li>**email**: Via email.</li></ul> | String |

    #### Object fields {#object-fields}

    **Object fields** `createdBy` {#object-fields-createdBy}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Link to the user. | String |
    | id | User ID. | String |
    | display | User's name displayed. | String |

    **Object fields** `updatedBy` {#object-fields-updatedBy}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Link to the user. | String |
    | id | User ID. | String |
    | display | User's name displayed. | String |

    **Object fields** `summonees` {#object-fields-summonees}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Link to the user. | String |
    | id | User ID. | String |
    | display | User's name displayed. | String |

    **Object fields** `maillistsummonees` {#object-fields-maillistsummonees}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Link to the mailing list. | String |
    | id | Mailing list address. | String |
    | display | Mailing list name displayed. | String |

- Request failed

    If the request is processed incorrectly, the API returns a response with error code 404. The requested object was not found. You may have specified an invalid object ID or key.

{% endlist %}

