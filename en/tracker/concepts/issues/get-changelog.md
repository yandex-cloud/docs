---
sourcePath: en/tracker/api-ref/concepts/issues/get-changelog.md
---
# Getting the history of issue changes

Use this request to get the history of changes to issues. If there are more than 50 records in the response, use the [`perPage` parameter](#params).

## Request format {#section_erc_zwm_z2b}

Before making the request, [get permission to access the API](../access.md).

To get a list of issue changes, use an HTTP `GET` request.
```json
GET /{{ ver }}/issues/<issue_id_or_key>/changelog
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %}

{% cut "Request parameters" %}

#### Additional parameters {#params}

| Parameter | Description | Data type |
-------- | -------- | ----------
| id | ID of the change followed by the requested changes. | String |
| perPage | Number of changes per page. If this parameter is omitted, each page will display 50 changes by default. | Number |
| field | ID of the [change parameter](#field). For example, `checklistItems` for viewing changes to the checklist or `status` for viewing all issue status updates. | String |
| type | Key of the [change type](#diff-type). | String |

{% endcut %}

## Response format {#section_kms_pbr_1fb}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   The response body contains a JSON array with the history of issue changes.

   {% cut "Response headers" %}

   The `Link` headers contain links to the first (`rel="first"`) and subsequent (`rel="next"`) pages of the response. By default, each page contains 50 changes.

   ```
   ...
   Link: <{{ host }}/v2/issues/SCR-8/changelog?perPage=50>; rel="first"
   Link: <{{ host }}/v2/issues/SCR-8/changelog?id=5b9a1a88f7c60500********&perPage=50>; rel="next"
   ...
   ```
   {% endcut %}

   ```json
   [
    {
        "id": "6033f986bd6c4a04********",
        "self": "https://{{ host }}/v2/issues/TEST-27/changelog/6033f986bd6c4a04********",
        "issue": {
            "self": "https://{{ host }}/v2/issues/TEST-27",
            "id": "6033f986bd6c4a04********",
            "key": "TEST-27",
            "display": "Issue name"
        },
        "updatedAt": "2021-02-22T18:35:50.157+0000",
        "updatedBy": {
            "self": "https://{{ host }}/v2/users/71********",
            "id": "71********",
            "display": "Full Name"
        },
        "type": "IssueCreated",
        "transport": "front",
        "fields": [
            {
                "field": {
                    "self": "https://{{ host }}/v2/fields/status",
                    "id": "status",
                    "display": "Status"
                },
                "from": null,
                "to": {
                    "self": "https://{{ host }}/v2/statuses/1",
                    "id": "1",
                    "key": "open",
                    "display": "Open"
                }
            }
        ]
    },
    {
        "id": "6033f98d4417c101********",
        "self": "https://{{ host }}/v2/issues/TEST-27/changelog/6033f98d4417c101********",
        "issue": {
            "self": "https://{{ host }}/v2/issues/TEST-27",
            "id": "6033f986bd6c4a04********",
            "key": "TEST-27",
            "display": "Issue name"
        },
        "updatedAt": "2021-02-22T18:35:57.359+0000",
        "updatedBy": {
            "self": "https://{{ host }}/v2/users/71********",
            "id": "71********",
            "display": "Full Name"
        },
        "type": "IssueUpdated",
        "transport": "front",
        "fields": [
            {
                "field": {
                    "self": "https://{{ host }}/v2/fields/followers",
                    "id": "followers",
                    "display": "Followers"
                },
                "from": null,
                "to": [
                    {
                        "self": "https://{{ host }}/v2/users/71********",
                        "id": "71********",
                        "display": "Full Name"
                    }
                ]
            }
        ]
    },
    {
        "id": "6033f9954417c101********",
        "self": "https://{{ host }}/v2/issues/TEST-27/changelog/6033f9954417c101********",
        "issue": {
            "self": "https://{{ host }}/v2/issues/TEST-27",
            "id": "6033f986bd6c4a04********",
            "key": "TEST-27",
            "display": "Issue name"
        },
        "updatedAt": "2021-02-22T18:36:05.553+0000",
        "updatedBy": {
            "self": "https://{{ host }}/v2/users/71********",
            "id": "71********",
            "display": "Full Name"
        },
        "type": "IssueUpdated",
        "transport": "front",
        "fields": [
            {
                "field": {
                    "self": "https://{{ host }}/v2/fields/tags",
                    "id": "tags",
                    "display": "Tags"
                },
                "from": null,
                "to": [
                    "New tag"
                ]
            }
        ],
    },
    {
       "id": "62bab52ca16f631e********",
       "self": "https://{{ host }}/v2/issues/TEST-27/changelog/62bab52ca16f631e********",
       "issue": {
           "self": "https://{{ host }}/v2/issues/TEST-27",
           "id": "5fbc929b5b28572f********",
           "key": "TEST-27",
           "display": "Issue name"
       },
       "updatedAt": "2022-06-28T08:00:44.155+0000",
       "updatedBy": {
           "self": "https://{{ host }}/v2/users/71********",
           "id": "71********",
           "display": "Full Name"
       },
       "type": "IssueWorkflow",
       "transport": "front",
       "fields": [
           {
               "field": {
                   "self": "https://{{ host }}/v2/fields/status",
                   "id": "status",
                   "display": "Status"
               },
               "from": {
                   "self": "https://{{ host }}/v2/statuses/3",
                   "id": "3",
                   "key": "inProgress",
                   "display": "In progress"
               },
               "to": {
                   "self": "https://{{ host }}/v2/statuses/2",
                   "id": "2",
                   "key": "needInfo",
                   "display": "Need info"
               }
           },
           {
               "field": {
                   "self": "https://{{ host }}/v2/fields/statusStartTime",
                   "id": "statusStartTime",
                   "display": "Status updated"
               },
               "from": "2022-06-28T07:29:45.753+0000",
               "to": "2022-06-28T08:00:44.156+0000"
           },
           {
               "field": {
                   "self": "https://{{ host }}/v2/fields/followers",
                   "id": "followers",
                   "display": "Followers"
               },
               "from": [
                   {
                       "self": "https://{{ host }}/v2/users/71********",
                       "id": "71********",
                       "display": "Full Name"
                   },
                   {
                       "self": "https://{{ host }}/v2/users/71********",
                       "id": "71********",
                       "display": "Full Name"
                   }
               ],
               "to": [
                   {
                       "self": "https://{{ host }}/v2/users/71********",
                       "id": "71********",
                       "display": "Full Name"
                   },
                   {
                       "self": "https://{{ host }}/v2/users/71********",
                       "id": "71********",
                       "display": "Full Name"
                   },
                   {
                       "self": "https://{{ host }}/v2/users/71********",
                       "id": "71********",
                       "display": "Full Name"
                   }
               ]
           }
       ],
       "comments": {
           "added": [
               {
                   "self": "https://{{ host }}/v2/issues/TEST-27/comments/10",
                   "id": "10",
                   "display": "Comment text"
               }
           ]
       },
       "executedTriggers": [
           {
               "trigger": {
                   "self": "https://{{ host }}/v2/queues/TEST/triggers/29",
                   "id": "29",
                   "display": "Trigger-42"
               },
               "success": true,
               "message": "Success"
           }
        ]
     }
   ]
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | id | Change ID. | String |
   | self | Address of the API resource with information about the change. | String |
   | [issue](#issue) | Block with information about the issue. | Object |
   | updatedAt | Issue update date and time in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | String |
   | [updatedBy](#updated-by) | Object with information about the user who edited the issue. | Object |
   | transport | Service parameter | String |
   | type | [Type of change](#diff-type). | String |
   | [fields](#fields) | Array of objects with information about updated issue parameters. | Array of objects |
   | [comments](#comments) | Section with information about the [comment](get-comments.md) to the issue. | Object |
   | [executedTriggers](#executedTriggers) | Section with information about the [trigger](../queues/get-trigger.md) that ran in the issue. | Object |

   `issue` **object fields** {#issue}

   {% include [issue](../../../_includes/tracker/api/issue.md) %}

   `updatedBy` **object fields** {#updated-by}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   **fields** `array object fields` {#fields}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | [field](#field) | Block with information about the updated issue parameter. | Object |
   | [from](#from-to) | Information about the parameter value before the change. <ul><li>If the field can accept multiple values, an array of objects is provided. For example, the `followers` field.</li><li>If the field can only accept one value, it is provided as a string. For example, the `statusStartTime` field.</li></ul> | String / object |
   | [to](#from-to) | Information about the parameter value after the change. <ul><li>If the field can accept multiple values, an array of objects is provided. For example, the `followers` field.</li><li>If the field can only accept one value, it is provided as a string. For example, the `statusStartTime` field.</li></ul> | String / object |

   `field` **object fields** {#field}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the updated issue parameter. | String |
   | id | Issue parameter ID. | String |
   | display | Issue parameter name displayed. | String |

   **Fields of the ** `from` **and** `to` objects {#from-to}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the issue parameter value. | String |
   | id | Issue parameter value ID. | String |
   | key | Parameter value key. | String |
   | display | Value parameter name displayed. | String |

   `comments` **object fields** {#comments}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | [added](#added) | Block with information about comment. | Object |

   `added` **object fields** {#added}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the comment object. | String |
   | id | Comment ID. | Number |
   | display | Text of the comment. | String |

   `executedTriggers` **object fields** {#executedTriggers}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | [trigger](#trigger) | Block with information about trigger. | Object |
   | success | Trigger action status. Acceptable values include:<ul><li>`true`— Success.</li><li>`false`: Failure.</li></ul> | Logical |
   | message | The action that was executed by the trigger. | String |

   `trigger` **object fields** {#trigger}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the trigger object. | String |
   | id | Trigger ID | Number |
   | display | Trigger name displayed | String |

   **type** `Type of change` {#diff-type}

   | Type of change. | Description |
   ----- | -----
   | IssueUpdated | The issue was edited. |
   | IssueCreated | The issue was created. |
   | IssueMoved | The issue was moved to another queue. |
   | IssueCloned | A clone of the issue was created. |
   | IssueCommentAdded | A comment was added to the issue. |
   | IssueCommentUpdated | An issue comment is edited. |
   | IssueCommentRemoved | An issue comment is deleted. |
   | IssueWorklogAdded | A record of time spent was added. |
   | IssueWorklogUpdated | A record of time spent was edited. |
   | IssueWorklogRemoved | A record of time spent was deleted. |
   | IssueCommentReactionAdded | The comment was voted for. |
   | IssueCommentReactionRemoved | A vote for the comment was removed. |
   | IssueVoteAdded | The issue was voted for. |
   | IssueVoteRemoved | A vote for the issue was removed. |
   | IssueLinked | A link to another issue was created. |
   | IssueLinkChanged | Type of link to another issue was changed. |
   | IssueUnlinked | A link to another issue was deleted. |
   | RelatedIssueResolutionChanged | Resolution of the linked issue was changed. |
   | IssueAttachmentAdded | A file is attached to the issue. |
   | IssueAttachmentRemoved | A file attached to the issue was removed. |
   | IssueWorkflow | The issue status changed. |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

   {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [answer-error-422](../../../_includes/tracker/api/answer-error-422.md) %}

   {% include [answer-error-500](../../../_includes/tracker/api/answer-error-500.md) %}

   {% include [answer-error-503](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}