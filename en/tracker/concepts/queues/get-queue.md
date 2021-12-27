---
sourcePath: en/tracker/api-ref/concepts/queues/get-queue.md
---
# Get queue parameters

Use this request to get information about a queue.

## Request format {#section_rnm_x4j_p1b}

To get queue information, use an HTTP `GET` request:

```json
GET /v2/queues/<queue-id>?
expand=<additional response fields>
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Request parameters {#req-params}

- **\<queue-id\>**

    Queue ID or key. The queue key is case-sensitive.

- **expand (optional)**

    Additional fields to include in the response. Possible values:
    - `all`: All additional fields of the queue will be included in the response.
    - `projects`: Queue projects.
    - `components`: Queue components.
    - `versions`: Queue versions.
    - `types`: Issue types.
    - `team`: List of queue team members.
    - `workflows`: List of workflows.
    - `fields`: Required queue fields.
    - `issueTypesConfig`: Settings of queue issue types.

> Request for a queue:
>- Use the HTTP GET method.
>- All additional fields are displayed in the response.
>```
>GET /v2/queues/TEST?expand=all HTTP/1.1
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>X-Org-Id: <organization ID>
>Cache-Control: no-cache
>```

## Response format {#section_xc3_53j_p1b}

```json
{
    "self": "{{ host }}/v2/queues/TEST",
    "id": 3,
    "key": "TEST",
    "version": 5,
    "name": "Test",
    "description": "Queue created for testing purposes",
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
    "teamUsers": [
           {
               "self": "{{ host }}/v2/users/1120000000016876",
               "id": "<employee ID>",
               "display": "<employee name displayed>"
           },
           ...
    ],
    "issueTypes": [
           {
               "self": "{{ host }}/v2/issuetypes/1",
               "id": "1",
               "key": "bug",
               "display": "Bug"
           },
           ...
    ],
    "versions": [
           {
               "self": "{{ host }}/v2/versions/4",
               "id": "4",
               "display": "Cuckoo"
        }
    ],
    "workflows": {
           "dev": [
               {
                    "self": "{{ host }}/v2/issuetypes/1",
                    "id": "1",
                    "key": "bug",
                    "display": "Bug"
                },
                ...
           ]
    },
    "denyVoting": false,
    "issueTypesConfig": [
           {
               "issueType": {
                      "self": "{{ host }}/v2/issuetypes/1",
                      "id": "1",
                      "key": "bug",
                      "display": "Bug"
            },
            "workflow": {
                      "self": "{{ host }}/v2/workflows/dev",
                      "id": "dev",
                      "display": "dev"
            },
            "resolutions": [
                   {
                      "self": "{{ host }}/v2/resolutions/2",
                      "id": "2",
                      "key": "wontFix",
                      "display": "Won't fix"
                   },
                ...
            ]
        },
        ...
    ]
}
```

#### Response parameters {#answer-params}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Queue link. | String |
| id | Queue ID. | String |
| key | Queue key. | String |
| version | Queue version. Each change to the queue increases its version number. | Number |
| name | Queue name. | String |
| description | Text description of the queue. | String |
| [lead](#lead) | Block with information about the queue owner. | Object |
| assignAuto | Automatically assign new issues in the queue:<br/><br/>`true`: Assign.<br/><br/>`false`: Do not assign. | Boolean |
| [defaultType](#default-type) | Block with information about the default issue type. | Object |
| [defaultPriority](#default-priority) | Block with information about the default issue priority | Object |
| [teamUsers](#team-users) | Array with information about queue team members | Array of objects |
| [issueTypes](#issue-types) | Array with information about queue issue types. | Array of objects |
| [versions](#versions) | Array with information about queue versions | Array of objects |
| [workflows](#workflows) | List of queue workflows and their issue types. | Array |
| denyVoting | Flag that indicates if voting for issues is enabled. | Boolean |
| [issueTypesConfig](#issue-types-config) | Array with queue issue settings. | Array of objects |

**Object fields** `lead` {#lead}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the user. | String |
| id | User ID. | String |
| display | User's name displayed. | String |

**Object fields** `defaultType` {#default-type}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the issue type. | String |
| id | ID of the issue type. | String |
| key | Key of the issue type. | String |
| display | Issue type name displayed. | String |

**Object fields** `defaultPriority` {#default-priority}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the priority type. | String |
| id | Priority ID. | String |
| key | Priority key. | String |
| display | Priority name displayed. | String |

**Array object fields** `teamUsers` {#team-users}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the user. | String |
| id | User ID. | String |
| display | User's name displayed. | String |

**Array object fields** `issueTypes` {#issue-types}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the issue type. | String |
| id | ID of the issue type. | String |
| key | Key of the issue type. | String |
| display | Issue type name displayed. | String |

**Array object fields** `versions` {#versions}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the queue version. | String |
| id | Version ID. | String |
| display | Version name displayed. | String |

**Array object fields** `workflows` {#workflows}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the issue type. | String |
| id | ID of the issue type. | String |
| key | Key of the issue type. | String |
| display | Issue type name displayed. | String |

**Array object fields** `issueTypesConfig` {#issue-types-config}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| [issueType](#issue-type) | Block with information about the issue type. | Object |
| [workflow](#workflow) | Block with information about the issue type workflow. | Object |
| [resolutions](#resolutions) | Array with possible issue type resolutions. | Array of objects |

**Object fields** `issueType` {#issue-type}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the issue type. | String |
| id | ID of the issue type. | String |
| key | Key of the issue type. | String |
| display | Issue type name displayed. | String |

**Object fields** `workflow` {#workflow}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the workflow object. | String |
| id | Workflow ID. | String |
| display | Workflow name displayed. | String |

**Array object fields** `resolutions` {#resolutions}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the resolution object. | String |
| id | Resolution ID. | String |
| key | Resolution ID. | String |
| display | Resolution name displayed. | String |

## Possible response codes {#section_otf_jrj_p1b}

200
:   Request executed successfully.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

