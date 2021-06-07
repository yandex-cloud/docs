# Get issue comments

Use this request to get a list of comments on an issue.

## Request format {#section_rnm_x4j_p1b}

To get a list of comments, use an HTTP `GET` request:

```json
GET /{{ ver }}/issues/<issue-id>/comments
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Resource {#resource}

- **\<issue-id\>**
Issue ID or key.

> Request for comments on a single issue with the required fields specified:
> 
> Use the HTTP GET method.
> 
> ```
> GET /v2/issues/JUNE-3/comments HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> X-Org-Id: <organization ID>
> Cache-Control: no-cache
> ```

## Response format {#section_xc3_53j_p1b}

If the request is successful, the API returns a response with code 200. The response body contains a JSON array with information about comments:

```
[
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
},
    ...
]
```

#### Response parameters {#answer-params}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the comment object | String |
| id | Comment ID | Number |
| longId | ID of the comment in string format. | String |
| text | Text of the comment. | String |
| [createdBy](#object-fields-createdBy) | Object with information about the user who added the comment. | Object |
| [updatedBy](#object-fields-updatedBy) | Object with information about the user who edited the comment last. | Object |
| createdAt | Comment creation date and time in <br/>``` YYYY-MM-DDThh:mm:ss.sss±hhmm ``` format | String |
| updatedAt | Comment update date and time.<br/>``` YYYY-MM-DDThh:mm:ss.sss±hhmm ``` | String |
| version | Comment version. Each change to the comment increases its version number. | Number |
| type | Comment type:<ul><li>**standard**: Comment sent via the {{ tracker-name }} interface.</li><li>**incoming**: Comment created from an incoming message.</li><li>**outcoming**: Comment created from an outgoing message.</li></ul> | String |
| transport | Method of adding a comment:<ul><li>**internal**: Via the {{ tracker-name }} interface.</li><li>**email**: Via email.</li></ul> | String |

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

## Possible response codes {#section_otf_jrj_p1b}

200
:   Request executed successfully.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

