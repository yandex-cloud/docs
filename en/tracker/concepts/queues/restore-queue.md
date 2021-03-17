# Restore a queue

Use this request to restore a deleted queue.

## Request format {#section_rnm_x4j_p1b}

To restore a deleted queue, use an HTTP `POST` request:

```json
POST /v2/queues/<queue-id>/_restore
Host: {{ host }}
Authorization: OAuth <token>
X-Org-ID: <organization ID> 
```

#### Resource {#req-resource}

- **\<queue-id\>**

    Queue ID or key. The queue key is case-sensitive.

#### Headers {#req-headers}

- **Host**

    Address of the node that provides the API:

    ```
    {{ host }}
    ```

- **Authorization**

    OAuth token in `OAuth <token value>` format. For example:

    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```

- **X-Org-ID**

    Organization ID.

## Response format {#section_xc3_53j_p1b}

```json
{
    "self": "{{ host }}/v2/queues/TEST",
    "id": 3,
    "key": "TEST",
    "version": 5,
    "name": "Test",
    "lead": {
           "self": "{{ host }}/v2/users/1120000000016876",
           "id": "<employee ID>",
           "display": "<employee name displayed>"
    },
    "assignAuto": false,
    "defaultType": {
           "self": "{{ host }}/v2/issuetypes/1",
           "id": "1",
           "key": "bug",
           "display": "Bug"
    },
    "defaultPriority": {
           "self": "{{ host }}/v2/priorities/3",
           "id": "3",
           "key": "normal",
           "display": "Medium"
    },
    "denyVoting": false
}
```

#### Response parameters {#answer-params}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Queue link. | String. |
| id | Queue ID. | String. |
| key | Queue key. | String. |
| version | Queue version. Each change to the queue increases its version number. | Number. |
| name | Queue name. | String. |
| [lead](#lead) | Block with information about the queue owner. | Object. |
| assignAuto` | Automatically |
| assign new issues in the queue:<br/><br/>`true`: Assign.<br/><br/>`false`: Do not assign. | Logical. |
| [defaultType](#default-type) | Block with information about the default issue type. | Object. |
| [defaultPriority](#default-priority) | Block with information about the default issue priority. | Object. |
| denyVoting | Flag that indicates if voting for issues is enabled. | Logical. |

**Object fields** `lead` {#lead}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| self | Link to the user. | String. |
| id | User ID. | String. |
| display | User's name displayed. | String. |

**Object fields** `defaultType` {#default-type}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| self | Link to the issue type. | String. |
| id | ID of the issue type. | String. |
| key | Key of the issue type. | String. |
| display | Issue type name displayed. | String. |

**Object fields** `defaultPriority` {#default-priority}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| self | Link to the priority type. | String. |
| id | Priority ID. | String. |
| key | Priority key. | String. |
| display | Priority name displayed. | String. |

## Possible response codes {#section_otf_jrj_p1b}

200
:   Successful execution of the request.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

