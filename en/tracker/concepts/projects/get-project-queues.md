---
sourcePath: en/tracker/api-ref/concepts/projects/get-project-queues.md
---
# Getting a list of project queues

Use this request to get a list of queues whose issues are included in a [project](../../manager/project-new.md).

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get a list of project queues, use an HTTP `GET` request:

```
GET /{{ ver }}/projects/<project-id>/queues
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<project-id> | Project ID | Number |

{% endcut %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| expand | Additional fields to include in the response. If there are multiple queues in the project, parameters are displayed for each queue:<ul><li>`all`: All queue parameters.</li><li>`projects`: All organization projects.</li><li>`components`: Queue components.</li><li>`versions`: Queue versions.</li><li>`types`: Queue issue types.</li><li>`team`: Queue team members.</li><li>`workflows`: Queue workflows and their issue types.</li><li>`fields`: Required queue fields.</li><li>`notification_fields`: Queue issue notification fields.</li><li>`issue_types_config`: Queue issue settings.</li><li>`enabled_features`: Queue integration settings.</li><li> `signature_settings`: Information about the queue mailbox: address, alias, and signature.</li></ul> | String |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains information about the project in JSON format.

    ```json
    [
        {
            "self": "{{ host }}/v2/queues/ORG",
            "id": 1,
            "key": "ORG",
            "version": 6,
            "name": "Default",
            "description": "Queue description "Default" (ORG)",
            "lead": {
                "self": "{{ host }}/v2/users/780889736",
                "id": "780889736",
                "display": "Tracker service robot "
            },
            "assignAuto": false,
            "defaultType": {
                "self": "{{ host }}/v2/issuetypes/2",
                "id": "2",
                "key": "task",
                "display": "Issue"
            },
            "defaultPriority": {
                "self": "{{ host }}/v2/priorities/3",
                "id": "3",
                "key": "normal",
                "display": "Medium"
            },
            "allowExternalMailing": true,
            "addIssueKeyInEmail": true,
            "denyVoting": false,
            "denyConductorAutolink": false,
            "denyTrackerAutolink": true,
            "useComponentPermissionsIntersection": false,
            "useLastSignature": false
        },
        {
            "self": "{{ host }}/v2/queues/TEST",
            "id": 3,
            "key": "TEST",
            "version": 8,
            "name": "Testing",
            "description": "Description of the "Testing" queue (TEST)",
            "lead": {
                "self": "{{ host }}/v2/users/1234567890",
                "id": "1234567890",
                "display": "First and Last name"
            },
            "assignAuto": true,
            "defaultType": {
                "self": "{{ host }}/v2/issuetypes/2",
                "id": "2",
                "key": "task",
                "display": "Issue"
            },
            "defaultPriority": {
                "self": "{{ host }}/v2/priorities/3",
                "id": "3",
                "key": "normal",
                "display": "Medium"
            },
            "allowExternalMailing": false,
            "addIssueKeyInEmail": false,
            "denyVoting": false,
            "denyConductorAutolink": false,
            "denyTrackerAutolink": false,
            "useComponentPermissionsIntersection": false,
            "useLastSignature": false
        }
    ]
    ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the queue. | String |
   | id | Queue ID | Number |
   | key | Queue key | String |
   | version | Queue version. Each change to the queue increases its version number. | String |
   | name | Queue name | String |
   | description | Text description of the queue | String |
   | lead | Block with information about the queue owner | Object |
   | assignAuto | Flag indicating that new issues in the queue are assigned automatically:<ul><li>`true`: Assign.</li><li>`false`: Do not assign.</li></ul> | Logical |
   | defaultType | Block with information about the default issue type | Object |
   | defaultPriority | Block with information about the default issue priority | Object |
   | allowExternalMailing | Flag that indicates if emails to external addresses are allowed:<ul><li>`true`: Enable.</li><li>`false`: Disable.</li></ul> | Logical |
   | addIssueKeyInEmail | Flag that indicates if the issue number is added to the email subject:<ul><li>`true`: Add.</li><li>`false`: Do not add.</li></ul> | Logical |
   | denyVoting | Flag that indicates if voting for issues is allowed:<ul><li>`true`: Voting disabled.</li><li>`false`: Voting enabled. </li></ul> | Logical |
   | denyConductorAutolink | Service parameter | Logical |
   | denyTrackerAutolink | Flag that indicates whether to add an automatic link to issues in other queues:<ul><li>`true` —add a link;</li><li>`false`: Do not add a link if the key of an issue from another queue is added to the comment or description.</li></ul> | Logical |
   | useComponentPermissionsIntersection | The method of getting access rights to issues with multiple components:<ul><li>`true`: As an overlap of component access rights.</li><li>`false`: As a combination of component access rights.</li></ul> | Logical |
   | useLastSignature | Service parameter | Logical |

   `lead` **object fields**

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the user | String |
   | id | User ID | Number |
   | display | Displayed user name | String |

   `defaultType` **object fields**

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the issue type. | String |
   | id | Issue type ID. | Number |
   | key | Issue type key. | String |
   | display | Issue type name displayed. | String |

   `defaultPriority`**object fields**

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the issue priority. | String |
   | id | Issue priority ID. | Number |
   | key | Issue priority key. | String |
   | display | Issue priority name displayed. | String |

   {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}