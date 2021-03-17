# Get the history of issue changes

Use this request to get the history of changes to issues. The response may be several pages long.

## Request format {#section_erc_zwm_z2b}

```json
GET /{{ ver }}/issues/<issue-id>/changelog?id=<ID of the previous change>&perPage=<changes on the page>&field=<updated parameter>&type=<change type>
Host: {{ host }}
Authorization: OAuth <token>
X-Org-ID: <organization ID>
```

#### Resource {#req-resource}

- **\<issue-id\>**

    Issue ID or key.

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

#### Request parameters {#req-get-params}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | ID of the change followed by the requested changes. | String. |
| perPage | Number of changes per page. | Number. |
| field | Updated parameter of the issue. | String. |
| type | Type of change. | String. |

## Response format {#section_kms_pbr_1fb}

{% list tabs %}

- Successful execution of the request

  If the request is successful, the API returns a response with code 200. The response body contains a JSON array with the history of queue changes.

  #### Response headers {#answer-headers}

    The `Link` headers contain links to the first and subsequent pages of the response. By default, each page contains 50 changes.

    ```
    ...
    Link: <https://api.tracker.yandex.net/v2/issues/SCR-8/changelog?perPage=50>; rel="first"
    Link: <https://api.tracker.yandex.net/v2/issues/SCR-8/changelog?id=5b9a1a88f7c605001c0e14a5&perPage=50>; rel="next"
    ...
    ```

  #### Response body {#answer-body}

    ```json
    [
     {
      "id" : "50616d66e4b07c95fbd35684",
      "self" : "https://api.tracker.yandex.net/v2/issues/DESIGN-1/changelog/50616d66e4b07c95fbd35684",
      "issue" : {
      "self" : "https://api.tracker.yandex.net/v2/issues/DESIGN-1",
        "id" : "4ff3e8dae4b0e2ac27f6eb43",
        "key" : "DESIGN-1",
        "display": "Make a page prototype"
      },
      "updatedAt" : "2012-09-25T08:37:58.243+0000",
      "updatedBy" : {
        "self" : "https://api.tracker.yandex.net/v2/users/1120000000007837",
        "id": "rodique",
        "display" : "Rodion Volchkov"
      },
      "type" : "IssueUpdated",
      "fields" : [ {
        "field" : {
          "self" : "https://api.tracker.yandex.net/v2/fields/priority",
          "id" : "priority",
          "display" : "Priority"
        },
        "from" :  {
           "self" : "https://api.tracker.yandex.net/v2/priorities/2",
           "id" : "2",
           "key" : "normal",
           "display" : "Normal"
         },
        "to" : {
        "self" : "https://api.tracker.yandex.net/v2/priorities/3",
           "id" : "3",
           "key" : "minor",
           "display" : "Minor"
         }
        },
        ...
      ]
     },
     ...
    ]
    ```

  #### Response parameters {#answer-params}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | id | Change ID. | String. |
  | self | Address of the API resource with information about the change. | String. |
  | [issue](#issue) | Block with information about the issue. | Object. |
  | updatedAt | Issue update date and time in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | String. |
  | [updatedBy](#updated-by) | Object with information about the user who edited the issue. | Object. |
  | type | [Type of change](#diff-type). | String. |
  | [fields](#fields) | Array of objects with information about updated issue parameters. | Array. |

  **Object fields** `issue` {#issue}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Issue link. | String. |
  | id | Issue ID. | String. |
  | key | Issue key. | String. |
  | display | Issue name displayed. | String. |

  **Object fields** `updatedBy` {#updated-by}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Link to the user. | String. |
  | id | User ID. | String. |
  | display | User's name displayed. | String. |

  **Array object fields** `fields` {#fields}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | [field](#field) | Block with information about the updated issue parameter. | Object. |
  | [from](#from-to) | Block with information about the parameter value before the change. | Object. |
  | [to](#from-to) | Block with information about the parameter value after the change. | Object. |

  **Object fields** `field` {#field}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Link to the updated issue parameter. | String. |
  | id | Issue parameter ID. | String. |
  | display | Issue parameter name displayed. | String. |

  **Object fields** `from` **and** `to` {#from-to}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Link to the issue parameter value. | String. |
  | id | Issue parameter value ID. | String. |
  | key | Parameter value key. | String. |
  | display | Value parameter name displayed. | String. |

  **Type of change** `type` {#diff-type}

  | Type of change. | Description |
  | ----- | ----- |
  | IssueUpdated | The issue was edited. |
  | IssueCreated | The issue was created. |
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

- The request failed

  If the request is processed incorrectly, the API returns a response with an error code:

  | HTTP code of the error | Error description |
  | ----- | ----- |
  | 400 Bad Request | One of the request parameters has an invalid value or data format. |
  | 403 Forbidden | The user or application has no access rights to the resource, the request is rejected. |
  | 404 Not Found | The requested resource not found. |
  | 422 Unprocessable Entity | JSON validation error, the request is rejected. |
  | 500 Internal Server Error | Internal service error. Try again later. |
  | 503 Service Unavailable | The API service is temporarily unavailable. |

{% endlist %}

