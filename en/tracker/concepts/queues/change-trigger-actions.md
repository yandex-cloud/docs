---
sourcePath: en/tracker/api-ref/concepts/queues/change-trigger-actions.md
---
# Trigger action objects

To manage trigger actions, specify one or more objects.

## Changing issue status {#change-status}

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| type | Action type | `Transition` | String |
| status | Issue status | Status key, ID, or name | String |

> For example:
> ```
> { "type": "Transition", "status": "In progress" }
> ```


## Calculate value {#calculate}

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| type | Action type | `CalculateFormula` | String |
| formula | Formula | Math expression | String |
| resultField | Field the value is calculated in | Field key or name | String |

> For example:
> ```
> { "type": "CalculateFormula", "formula": "now()+3M", "resultField": "start" }
> ```


## Change field values {#change-fields}

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| type | Action type | `Update` | String |
| update | List of field actions | Objects with the `field` and `update` fields | Array of objects |

**Object fields** `update`:

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| field | Field to update | Field key or name | String |
| update | Field action object | <ul><li>Object with the `set` field whose value is a string or object with a new field value.</li><li>**null** to clear the field. </li></ul> | Object or NULL |

> For example:
> ```
> {
>    "type": "Update",
>    "update": [
>          { "field": "priority","update":{"set":{"key":"critical"}}
>          { "field": "Description" }, "update": { "set": "New issue" }},
>          { "field": "Resolution" }, "update": null },
>    ]
> }
> ```


## Move issue {#move-task}

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| type | Action type | `Move` | String |
| queue | Queue | Queue key | String |

> For example:
> ```
> { "type": "Move", "queue": "TESTQUEUE"}
> ```


## Add comment {#add-comment}

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| type | Action type | `CreateComment` | String |
| text | Text of the comment | Text | String |
| fromRobot | Send as robot | `true` or `false` | Logical |

> For example:
> ```
> { "type": "CreateComment", "text": "Created by not_var{{currentDateTime.date}}", "fromRobot": false }
> ```


## Create a checklist {#add-checklist}

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| type | Action type | `CreateChecklist` | String |
| checklistItems | List of checklist items | Array of objects with the following fields:<ul><li>`text`: Issue description (required field)</li><li>`assignee`: Issue assignee</li><li>`Deadline`: Issue deadline</li></ul> | Array of objects |

> For example:
> ```
> {
>    "type": "CreateChecklist",
>    "checklistItems": [
>          {
>             "text": "Do this",
>             "assignee": "ivanivanov",
>             "deadline": "2025-10-26",
>          },
>          {
>             "text": "Do that",
>             "assignee": "ivanivanov",
>             "deadline": "2025-10-26",
>          },
>          {   "text": "Report the results"}
>    ]
> }
> ```


## HTTP request {#webhook}

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| type | Action type | `Webhook` | String |
| endpoint | Address | Request URL | String |
| authContext | Authorization method | Object with authorization data | String |
| method | Request method | Possible values:<ul><li>`GET`</li><li>`POST`</li><li>`PUT`</li><li>`DELETE`</li></ul> | String |
| contentType | Type of content | `application/json` | String |
| headers | Headers | Object with fields in key-value format | Objects |
| body | Request body | Object with data or string | Object or String |

**Acceptable authorization objects**

| Authorization type | Objects |
----- | -----
| NoAuth | `{ "type": "noauth" }` |
| Basic | `{ "password": "********", "type": "basic", "login": "<username>" }` |
| OAuth 2 | `{ "headerName": "Authorization", "type": "oauth", "accessToken": "********", "tokenType": "Bearer"}` |

> For example:
> ```
> {
>    "type": "Webhook",
>    "endpoint": "https://api.example.com/messenger/sendMessage",
>    "method": "GET",
>    "contentType": "application/json; charset=UTF-8",
>    "headers": { "Content-Language": "de-DE" },
>    "authContext": { "password": "********", "type": "basic", "login": "user1" },
>    "body": {"message":"Hallo, Welt!"}
> }
> ```


## Create an issue {#create-task}

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| type | Action type | `CreateIssue` | String |
| queue | Queue | Queue key | String |
| summary | Name | Text | String |
| fieldTemplates | Issue fields | Object with issue fields | Objects |
| linkWithInitialIssue | Link it to the issue that activated the trigger | `true` or `false` | Logical |
| fromRobot | Create issues as a robot | Object with issue fields | `true` or `false` | Logical |

**Parameters of objects with issue fields**

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| followers | Followers | Array with user IDs | Array of strings |
| dueDate | Deadline | Date | String |
| description | Description | Text | String |
| assignee | Assignee | User ID | String |
| priority | Priority | Priority key or name | String |
| type | Issue type | Type key or name | String |
| tags | Tag list | Array of string elements | Array of strings |

> For example:
> ```
> {
>    "type": "CreateIssue",
>    "queue": "TESTQUEUE",
>    "summary": "New issue",
>    "fieldTemplates": {
>          "followers": ["user1", "user2"],
>          "dueDate": "2024-10-31",
>          "description": "Created by the trigger not_var{{currentDateTime.date}}",
>          "assignee": "user3",
>          "priority": "critical",
>          "type": "milestone",
>          "tags": ["new task", "by trigger"]
>    },
>    "linkWithInitialIssue": true,
>    "fromRobot": true,
> }
> ```

