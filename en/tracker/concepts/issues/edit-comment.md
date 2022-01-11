---
sourcePath: en/tracker/api-ref/concepts/issues/edit-comment.md
---
# Edit a comment

Use this request to edit comments.

## Request format {#section_rkq_bhl_dfb}

To edit a comment previously [added to an issue](add-comment.md), use an HTTP `PATCH` request. Request parameters are passed in the request body in JSON format:

```json
PATCH /{{ ver }}/issues/<issue-id>/comments/<comment-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>

{
   "text": "<new comment text>",
   "attachmentIds": [<comma-separated IDs of attached files>]
}
```

#### Resource {#resource}

- **\<issue-id\>**
Issue ID or key.

- **\<comment-id\>**
[Unique ID of the comment](get-comments.md#section_xc3_53j_p1b) in numeric (id) or string format (longId).

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

#### Request body {#req-body-params}

| Parameter | Value | Data type |
| ----- | ----- | ----- |
| text | Edited issue comment. Required. | String |
| attachmentIds | List of [attachment IDs](temp-attachment.md). | Array of strings |

## Response format {#section_rcd_ysf_2fb}

If the request is successful, the API returns a response with code 200. The response body contains information about the added comment in JSON format.

```json
[ 
{
  "self" : "https://api.tracker.yandex.net/v2/issues/TREK-1/comments/684",
  "id" : "684",  
  "longId" : "5fc4bc634e121b12f44a0488",  
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
  "createdAt" : "2020-11-30T09:33:23.638+0000",  
  "updatedAt" : "2020-11-30T09:39:07.631+0000",  
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
  "version" : 2,  
  "type" : "standard",  
  "transport" : "internal"
}
]
```

#### Response parameters {#answer-params}

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

## Possible response codes {#section_otf_jrj_p1b}

200
:   Request executed successfully.

400
:   The server couldn't process the request due to invalid syntax.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

