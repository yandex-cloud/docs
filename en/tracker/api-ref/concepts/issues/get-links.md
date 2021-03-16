# Get issue links

Use this request to get information about issue links. The issue is selected when its ID or key is specified.

## Request format {#section_rnm_x4j_p1b}

To get a list of issue links, use an HTTP `GET` request:

```json
GET /{{ ver }}/issues/<issue-id>/links
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Resource {#req-resource}

- **\<issue-id\>**

    Issue ID or key.

> Request for issue links:
> 
> - An HTTP GET method is used.
> 
> ```
> GET /v2/issues/JUNE-2/links HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> X-Org-Id: <organization ID>
> Cache-Control: no-cache
> ```

## Response format {#section_xc3_53j_p1b}

```json
[
    {
        "self": "{{ host }}/v2/issues/JUNE-2/links/4709605",
        "id": 4709605,
        "type": {
            "self": "{{ host }}/v2/linktypes/subtask",
            "id": "subtask",
            "inward": "Sub-issue",
            "outward": "Parent issue"
        },
        "direction": "outward",
        "object": {
            "self": "{{ host }}/v2/issues/TREK-9844",
            "id": "593cd211ef7e8a332414f2a7",
            "key": "TREK-9844"
            "display": "subtask"
        },
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
        "createdAt": "2017-06-11T05:16:01.421+0000",
        "updatedAt": "2017-06-11T05:16:01.421+0000",
        "assignee": {
            "self": "{{ host }}/v2/users/1120000000049224",
            "id": "<employee ID>",
            "display": "<employee name displayed>"
        },
        "status": {
            "self": "{{ host }}/v2/statuses/1",
            "id": "1",
            "key": "open",
            "display": "Open"
        }
    },
    ...
]
```

#### Response parameters {#answer-params}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Address of the API resource with information about the link. | String. |
| id | Link ID. | Number. |
| [type](#type) | Block with information about the link type. | Object. |
| direction | Link type of the issue specified in the request in relation to the issue specified in the [object](#object-param) field. Possible values:<ul><li>`outward`: The issue specified in the request is the main one for the issue in the [object](#object-param) field.</li><li>`inward`: The issue specified in the [object](#object-param) field is the main one for the issue in the request.</li></ul> | String. |
| [object](#object-block) {#object-param} | Block with information about the linked issue. | Object. |
| [createdBy](#created-by) | Block with information about the user who created the link. | Object. |
| [updatedBy](#updated-by) | Block with information about the user who edited the linked issue last. | Object. |
| createdAt | Link creation date and time. | String. |
| updatedAt | Link update date and time. | String. |
| [assignee](#assignee) | Assignee of the linked issue. | Object. |
| [status](#status) | Status of the linked issue. | Object. |

**Object fields** `type` {#type}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the link type. | String. |
| id | ID of the link type. | String. |
| inward | Name of the link type of the issue specified in the [object](#object-param) field in relation to the issue specified in the request. | String. |
| outward | Name of the link type of the issue specified in the request in relation to the issue specified in the [object](#object-param) field. | String. |

**Object fields** `object` {#object-block}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Address of the API resource with information about the issue. | String. |
| id | Issue ID. | String. |
| key | Issue key. | String. |
| display | Issue name displayed. | String. |

**Object fields** `createdBy` {#created-by}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the user. | String. |
| id | User ID. | String. |
| display | User's name displayed. | String. |

**Object fields** `updatedBy` {#updated-by}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the user. | String. |
| id | User ID. | String. |
| display | User's name displayed. | String. |

**Object fields** `assignee` {#assignee}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the user. | String. |
| id | User ID. | String. |
| display | User's name displayed. | String. |

**Object fields** `status` {#status}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Status link. | String. |
| id | Status ID. | String. |
| key | Status key. | String. |
| display | Status name displayed. | String. |

## Possible response codes {#section_otf_jrj_p1b}

200
:   Successful execution of the request.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

