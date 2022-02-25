---
sourcePath: en/tracker/api-ref/concepts/issues/search-issues.md
---
# Find issues

Use this request to get a list of issues that meet specific criteria. If there are more than 50 issues in the response, use [pagination](#section_mtj_ldk_p1b).

## Request format {#section_rnm_x4j_p1b}

Before making the request, [get permission to access the API](../access.md).

To search for issues, use an HTTP `POST` request. The request body contains the search criteria.

```json
POST /v2/issues/_search
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

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

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| order | The direction and field for sorting issues. The value is specified in `[+/-]<field name>` format. Use the + or - sign to indicate the sort direction. | String |
| expand | Additional fields to be included in the response: <ul><li>`transitions`: Workflow transitions between statuses.</li><li>`attachments`: Attachments.</li></ul> | String |
| perPage | Number of issues per response page. Default: 50. To set up additional response output parameters, use [pagination](#section_mtj_ldk_p1b). | Number |

{% endcut %}

{% cut "Request body parameters" %}

**Additional parameters**

| Parameter | Description | Format |
| ----- | ----- | ----- |
| filter | Parameters for filtering issues. The parameter can specify any field and value to filter by. | Object |
| query | A filter using the [query language](../../user/query-filter.md). | String |
| expand | Additional fields to include in the response:<ul><li>`transitions`: Workflow transitions between statuses.</li><li>`attachments`: Attached files.</li></ul> | String |
| keys | List of issue keys. This parameter is not used together with the `filter` or `quiery` parameter. If you pass these parameters together, a search will only be performed by `keys`. | String |
| queue | Queue. This parameter is not used together with the `filter` or `quiery` parameter. If you pass these parameters together, a search will only be performed by `queue`. | String |

The `queue` and `keys` parameters can't be used simultaneously with the `filter` or `quiery` parameters. If they are passed together, the response will contain code 400 with a message saying `You can only use keys, a queue or a search query.`

{% endcut %}

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
> {{ org-id }}
> 
> {
>   "filter": {
>     "queue": "JUNE",
>     "assignee": "Empty()"
>   }
> }
> ```

## Response format {#section_xc3_53j_p1b}

{% list tabs %}

- Successful execution of the request

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains the results in JSON format.

    {% include [answer-issue](../../../_includes/tracker/api/answer-issue.md) %}

- The request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

## Paginated result output {#section_mtj_ldk_p1b}

If more than 50 issues meet the request criteria, you should use the scrolling mechanism to view the results page by page.

This mechanism has two options, one using the sorting specified in the request and the other without sorting. In the second case, the search results are returned in random order. Scrolling with no sorting is more effective when a large number of issues are returned.

#### Scrolling with no sorting {#scroll-without-sorting}

To enable scrolling without sorting, use the following parameters in the request:

- **perPage (optional)**

    Number of issues per page. Default: 50.

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

