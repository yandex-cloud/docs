---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Find issues

Use this request to get a list of issues that meet specific criteria. If there are more than 50 issues in the response, use [paging](#section_mtj_ldk_p1b).

## Request format {#section_rnm_x4j_p1b}

To search for issues, use an HTTP `POST` request. The request body contains the search criteria.

```json
POST /v2/issues/_search?
order=<sort direction>
&expand=<additional response fields>
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>

{
  "filter": {
    "<field name>": "<field value>"
  },
  "query": "filter in the query language",
  "expand": "additional fields",
  "keys": "list of issue keys",
  "queue": "queue key"
}
```

#### Request parameters {#req-get-params}

- **order (optional)**

     The direction and field for sorting issues. The value is specified in `[+/-]<field name>` format. Use the + or - sign to indicate the sort direction.

- **expand (optional)**

    Additional fields to include in the response:
    - `transitions`: Workflow transitions between statuses.
    - `attachments`: Attached files.

- **perPage (optional)**

    Number of issues on the response page. The default value is 50. Additional parameters for displaying the response can be configured using [paging](#section_mtj_ldk_p1b).

#### Request body {#req-body-params}

| Parameter | Description | Format |
| ----- | ----- | ----- |
| filter | Parameters for filtering issues. The parameter can specify any field and value to filter by. | Object |
| query | A filter using the [query language](../../user/query-filter.md). | String |
| expand | Additional fields to include in the response:<ul><li>`transitions`: Workflow transitions between statuses.</li><li>`attachments`: Attached files.</li></ul> | String |
| keys | List of issue keys. This parameter is not used together with the `filter` or `quiery` parameter. If you pass these parameters together, a search will only be performed by `keys`. | String |
| queue | Queue. This parameter is not used together with the `filter` or `quiery` parameter. If you pass these parameters together, a search will only be performed by `queue`. | String |

The `queue` and `keys` parameters can't be used simultaneously with the `filter` or `quiery` parameters. If they are passed together, the response will contain code 400 with a message saying `You can only use keys, a queue or a search query.`

> Request for a list of issues with additional filtering options:
> 
> - An HTTP POST method is used.
> - Paginated results are enabled, and each page contains two entries.
> - The response will display attachments.
> - The response should only contain issues from the <q>JUNE</q> queue that don't have an assignee.
> 
> ```
> POST /v2/issues/_search?scrollType=sorted&amp;perScroll=2&expand=attachments HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> X-Org-Id: <organization ID>
> Cache-Control: no-cache
> 
> {
>   "filter": {
>     "queue": "JUNE",
>     "assignee": "Empty()"
>   }
> }
> ```

## Response format {#section_xc3_53j_p1b}

```json
[
    {
    "self": "{{ host }}/v2/issues/TREK-9844",
    "id": "593cd211ef7e8a332414f2a7",
    "key": "TREK-9844",
    "version": 7,
    "lastCommentUpdatedAt": "2017-07-18T13:33:44.291+0000",
    "summary": "subtask",
    "parent": {
        "self": "{{ host }}/v2/issues/JUNE-2",
        "id": "593cd0acef7e8a332414f28e",
        "key": "JUNE-2",
        "display": "Task"
        },
    "aliases": [
            "JUNE-3"
        ],

    "updatedBy": {
        "self": "{{ host }}/v2/users/1120000000016876",
        "id": "<employee ID>",
        "display": "<employee name displayed>"
        },
    "description": "<#<html><head></head><body><div>test</div><div>&nbsp;</div><div>&nbsp;</div> </body></html>#>",
    "sprint": [
            {
        "self": "{{ host }}/v2/sprints/5317",
        "id": "5317",
        "display": "sprint1"
            }
        ],
    "type": {
        "self": "{{ host }}/v2/issuetypes/2",
        "id": "2",
        "key": "task",
        "display": "Issue"
        },
    "priority": {
        "self": "{{ host }}/v2/priorities/2",
        "id": "2",
        "key": "normal",
        "display": "Medium"
        },

    "createdAt": "2017-06-11T05:16:01.339+0000",
    "followers": [
        {
        "self": "{{ host }}/v2/users/1120000000016876",
        "id": "<employee ID>",
        "display": "<employee name displayed>"
        }
        ],
    "createdBy": {
        "self": "{{ host }}/v2/users/1120000000049224",
        "id": "<employee ID>",
        "display": "<employee name displayed>"
        },
    "votes": 0,
    "assignee": {
        "self": "{{ host }}/v2/users/1120000000049224",
        "id": "<employee ID>",
        "display": "<employee name displayed>"
        },
    "queue": {
        "self": "{{ host }}/v2/queues/TREK",
        "id": "111",
        "key": "TREK",
        "display": "Startrack"
        },
    "updatedAt": "2017-07-18T13:33:44.291+0000",
    "status": {
        "self": "{{ host }}/v2/statuses/1",
        "id": "1",
        "key": "open",
        "display": "Open"
        },
    "previousStatus": {
        "self": "{{ host }}/v2/statuses/2",
        "id": "2",
        "key": "resolved",
        "display": "Resolved"
        },
    "favorite": false
    },
    {...}
]
```

#### Response parameters {#answer-params}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Address of the API resource with information about the issue. | String |
| id | Issue ID. | String |
| key | Issue key. | String |
| version | Issue version. Each change to the issue parameters increases its version number. | Number |
| lastCommentUpdatedAt | Date and time when the last comment was added. | String |
| summary | Issue name. | String |
| [parent](#parent) | Object with information about the parent issue. | Object |
| aliases | Array with information about alternative issue keys. | Array of strings |
| [updatedBy](#updated-by) | Object with information about the employee who edited the issue last. | Object |
| description | Issue description. | String |
| [sprint](#sprint) | Array of objects with information about the sprint. | Array of objects |
| [type](#type) | Object with information about the issue type. | Object |
| [priority](#priority) | Object with information about the priority. | Object |
| createdAt | Issue creation date and time. | String |
| [followers](#followers) | Array of objects with information about issue followers. | Array of objects |
| [createdBy](#created-by) | Object with information about the user who created the issue. | Object |
| votes | Number of votes for the issue. | Number |
| [assignee](#assignee) | Object with information about the issue's assignee. | Object |
| [queue](#queue) | Object with information about the issue queue. | Object |
| updatedAt | Date and time when the issue was last updated. | String |
| [status](#status) | Object with information about the issue status. | Object |
| [previousStatus](#previous-status) | Object with information about the previous status of the issue. | Object |
| favorite | Flag indicating a favorite issue:<ul><li>`true`: The user added the issue to favorites.</li><li>`false`: The issue is not added to favorites.</li></ul> | Boolean |

**Object fields** `parent` {#parent}

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

**Array object fields** `sprint` {#sprint}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Sprint link. | String |
| id | Sprint ID. | String |
| display | Sprint name displayed. | String |

**Object fields** `type` {#type}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the issue type. | String |
| id | ID of the issue type. | String |
| key | Key of the issue type. | String |
| display | Issue type name displayed. | String |

**Object fields** `priority` {#priority}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the priority type. | String |
| id | Priority ID. | String |
| key | Priority key. | String |
| display | Priority name displayed. | String |

**Array object fields** `followers` {#followers}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the user. | String |
| id | User ID. | String |
| display | User's name displayed. | String |

**Object fields** `createdBy` {#created-by}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the user. | String |
| id | User ID. | String |
| display | User's name displayed. | String |

**Object fields** `assignee` {#assignee}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the user. | String |
| id | User ID. | String |
| display | User's name displayed. | String |

**Object fields** `queue` {#queue}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Queue link. | String |
| id | Queue ID. | String |
| key | Queue key. | String |
| display | Queue name displayed. | String |

**Object fields** `status` {#status}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Status link. | String |
| id | Status ID. | String |
| key | Status key. | String |
| display | Status name displayed. | String |

**Object fields** `previousStatus` {#previous-status}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Status link. | String |
| id | Status ID. | String |
| key | Status key. | String |
| display | Status name displayed. | String |

## Paginated result output {#section_mtj_ldk_p1b}

If more than 50 issues meet the request criteria, you should use the scrolling mechanism to view the results page by page.

This mechanism has two options, one using the sorting specified in the request and the other without sorting. In the second case, the search results are returned in random order. Scrolling without sorting is more efficient when you get significant amounts of issues.

#### Scrolling with no sorting {#scroll-without-sorting}

To enable scrolling without sorting, use the following parameters in the request:

- **perPage (optional)**

    Number of issues per page. The default value is 50.

- **page (optional)**

    Response page number. The default value is 1.

The response will contain the following headers:

- **X-Total-Pages**

    Total number of pages with entries.

- **X-Total-Count**

    Total number of entries in the response.

With this method, the request results are counted each time a new page is displayed. So if changes occur in the request results when viewing a certain page, this may affect the output of the following pages. For example, the request found 11 issues, 10 of which are displayed. While viewing the results of the first page, one of the issues was changed and no longer meets the requirements of the search query. In this case, when requesting the second page with the results, an empty array is returned, since the remaining 10 issues are on the first page.

#### Scrolling with sorting {#scroll-with-sorting}

To enable scrolling with sorting, use the following parameters in the request:

- **scrollType**

    Scrolling type. Acceptable values:
    - `sorted`: The sorting specified in the request is used.
    - `unsorted`: No sorting is used.

    This parameter isn't used together with the `keys` or `queue` parameter. If you use them together, the response will contain code 400 and a message saying `Scroll is not supported`.

- **perScroll**

    Maximum number of issues per response. The default value is 5000. The maximum allowed value is 10,000.

- **scrollTTLMillis (optional parameter)**

    Scroll context lifetime in milliseconds. The default and maximum allowed value is 5000.

- **scrollId**

    Page ID. The parameter is specified starting from the second in a series of requests. The ID value is taken from the `X-Scroll-Id` header of the response to the previous search query.

- **scrollToken**

    Token that certifies that the request belongs to the current user. The ID value is taken from the `X-Scroll-Token` header of the response to the previous search query.

The response will contain the following headers:

- **Link**

    Link to go to the next page of the search results.

- **X-Scroll-Id**

    Page ID.

- **X-Scroll-Token**

    Token that certifies that the request belongs to the current user.

- **X-Total-Count**

    Total number of entries in the response.

This method creates a snapshot of search results and switching between the pages is performed within this snapshot. This way, if an issue is edited and no longer meets the search query criteria, it won't affect the issue's output in the search results snapshot. This method is more resource-intensive. The search results snapshot is saved until all pages with the results have been viewed. If you plan to stop viewing the search results without going to the last page, you must explicitly release the resources in use by making the request [{#T}](search-release.md).

## Possible response codes {#section_otf_jrj_p1b}

200
:   Request executed successfully.

