# Get the history of issue changes

Use this request to get the history of changes to issues. If there are more than 50 records in the response, use the [`perPage` parameter](#params).

## Request format {#section_erc_zwm_z2b}

Before making the request, [get permission to access the API](../access.md).

To get a list of issue changes, use an HTTP `GET` request.

```json
GET /{{ ver }}/issues/<issue-id>/changelog
Host: {{ host }}
Authorization: OAuth <token>
X-Org-ID: <organization ID>
```

### Request parameters

#### Headings

- **Host**

    API host address:

    ```
    {{ host }}
    ```

- **Authorization**

    OAuth token in `OAuth <token value>` format. For example:

    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```

- **X-Org-ID**

    Company ID.

#### Resource

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<issue-id> | Issue ID or key. | String |

#### Additional parameters {#params}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| id | ID of the change followed by the requested changes. | String |
| perPage | Number of changes per page. If this parameter is not specified, each page contains 50 changes by default. | Number |
| field | ID of the [change parameter](#field). Examples: `checklistItems` to view changes in the checklist or `status` to view all issue status updates. | String |
| type | Key of the [change type](#diff-type). | String |

## Response format {#section_kms_pbr_1fb}

{% list tabs %}

- Request executed successfully

  If the request is successful, the API returns a response with code 200. The response body contains a JSON array with the history of issue changes.

  ### Response headers {#answer-headers}

    The `Link` headers contain links to the first (`rel="first"`) and subsequent (`rel="next"`) pages of the response. By default, each page contains 50 changes.

    ```
    ...
    Link: <https://api.tracker.yandex.net/v2/issues/SCR-8/changelog?perPage=50>; rel="first"
    Link: <https://api.tracker.yandex.net/v2/issues/SCR-8/changelog?id=5b9a1a88f7c605001c0e14a5&perPage=50>; rel="next"
    ...
    ```

  ### Response body {#answer-body}

    ```json
    [
     {
            "id": "6033f986bd6c4a042c688392",
            "self": "https://api.tracker.yandex.net/v2/issues/TEST-27/changelog/6033f986bd6c4a042c688392",
            "issue": {
                "self": "https://api.tracker.yandex.net/v2/issues/TEST-27",
                "id": "6033f986bd6c4a042c688392",
                "key": "TEST-27",
                "display": "Issue name"
            },
         "updatedAt": "2021-02-22T18:35:50.157+0000",
         "updatedBy": {
             "self": "https://api.tracker.yandex.net/v2/users/1234567890",
             "id": "1234567890",
             "display": "First and Last name"
         },
         "type": "IssueCreated",
         "transport": "front",
         "fields": [
             {
                 "field": {
                     "self": "https://api.tracker.yandex.net/v2/fields/status",
                     "id": "status",
                     "display": "Status"
                 },
                 "from": null,
                 "to": {
                     "self": "https://api.tracker.yandex.net/v2/statuses/1",
                     "id": "1",
                     "key": "open",
                     "display": "Open"
                 }
             }
         ]
     },
     {
         "id": "6033f98d4417c101b655b93b",
         "self": "https://api.tracker.yandex.net/v2/issues/TEST-27/changelog/6033f98d4417c101b655b93b",
         "issue": {
             "self": "https://api.tracker.yandex.net/v2/issues/TEST-27",
             "id": "6033f986bd6c4a042c688391",
             "key": "TEST-27",
             "display": "Issue name"
         },
         "updatedAt": "2021-02-22T18:35:57.359+0000",
         "updatedBy": {
             "self": "https://api.tracker.yandex.net/v2/users/1234567890",
             "id": "1234567890",
             "display": "First and Last name"
         },
         "type": "IssueUpdated",
         "transport": "front",
         "fields": [
             {
                 "field": {
                     "self": "https://api.tracker.yandex.net/v2/fields/followers",
                     "id": "followers",
                     "display": "Followers"
                 },
                 "from": null,
                 "to": [
                     {
                         "self": "https://api.tracker.yandex.net/v2/users/1234567890",
                         "id": "1234567890",
                         "display": "First and Last name"
                     }
                 ]
             }
         ]
     },
     {
         "id": "6033f9954417c101b655b940",
         "self": "https://api.tracker.yandex.net/v2/issues/TEST-27/changelog/6033f9954417c101b655b940",
         "issue": {
             "self": "https://api.tracker.yandex.net/v2/issues/TEST-27",
             "id": "6033f986bd6c4a042c688391",
             "key": "TEST-27",
             "display": "Issue name"
         },
         "updatedAt": "2021-02-22T18:36:05.553+0000",
         "updatedBy": {
             "self": "https://api.tracker.yandex.net/v2/users/1234567890",
             "id": "1234567890",
             "display": "First and Last name"
         },
         "type": "IssueUpdated",
         "transport": "front",
         "fields": [
             {
                 "field": {
                     "self": "https://api.tracker.yandex.net/v2/fields/tags",
                     "id": "tags",
                     "display": "Tags"
                 },
                 "from": null,
                 "to": [
                     "New tag"
                 ]
             }
         ]
      }
    ]
    ```

  #### Response parameters {#answer-params}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | id | Change ID. | String |
   | self | Address of the API resource with information about the change. | String |
   | [issue](#issue) | Block with information about the issue. | Object |
   | updatedAt | Issue update date and time in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | String |
   | [updatedBy](#updated-by) | Object with information about the user who edited the issue. | Object |
   | transport | Service parameter. | String |
   | type | [Type of change](#diff-type). | String |
   | [fields](#fields) | Array of objects with information about updated issue parameters. | Array |

   **Object fields** `issue` {#issue}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | self | Issue link. | String |
   | id | Issue ID. | String |
   | key | Issue key. | String |
   | display | Issue name displayed. | String |

   **Object fields** `updatedBy` {#updated-by}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | self | Link to the user. | String |
   | id | User ID. | String |
   | display | User's name displayed. | String |

   **Array object fields** `fields` {#fields}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | [field](#field) | Block with information about the updated issue parameter. | Object |
   | [from](#from-to) | Block with information about the parameter value before the change. | Object |
   | [to](#from-to) | Block with information about the parameter value after the change. | Object |

   **Object fields** `field` {#field}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | self | Link to the updated issue parameter. | String |
   | id | Issue parameter ID. | String |
   | display | Issue parameter name displayed. | String |

   **Object fields** `from` **and** `to` {#from-to}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | self | Link to the issue parameter value. | String |
   | id | Issue parameter value ID. | String |
   | key | Parameter value key. | String |
   | display | Value parameter name displayed. | String |

   **Type of change** `type` {#diff-type}

   | Type of change. | Description |
   | ----- | ----- |
   | IssueUpdated | The issue was edited. |
   | IssueCreated | Issue created. |
   | IssueMoved | The issue was moved to another queue. |
   | IssueCloned | A clone of the issue was created. |
   | IssueCommentAdded | A comment was added to the issue. |
   | IssueCommentUpdated | An issue comment was edited. |
   | IssueCommentRemoved | An issue comment was deleted. |
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

- Request failed

  If the request is processed incorrectly, the API returns a response with an error code:

  | HTTP error code | Error description |
  | ----- | ----- |
  | 400 Bad Request | A request parameter contains an invalid value or data format. |
  | 403 Forbidden | The user or application doesn't have permission to access the resource and the request was rejected. |
  | 404 Not Found | The requested resource wasn't found. |
  | 422 Unprocessable Entity | JSON validation error, the request is rejected. |
  | 500 Internal Server Error | The service experienced an internal error. Try resending your request in a few minutes. |
  | 503 Service Unavailable | The API service is temporarily unavailable. |

{% endlist %}

