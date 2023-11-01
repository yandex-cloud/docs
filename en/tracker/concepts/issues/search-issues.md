---
sourcePath: en/tracker/api-ref/concepts/issues/search-issues.md
---
# Search for issues

Use this request to get a list of issues that meet specific criteria.

If the number of rows in the response is between 50 and 10,000, use [paginated output](../../common-format.md#displaying-results).

If the number of rows in the response exceeds 10,000, use [scrollable results](#scroll).

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
    "<field name>": "<value in the field>"
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
----- | ----- | -----
| expand | Additional fields to include in the response: <ul><li>`transitions`: Workflow transitions between statuses.</li><li>`attachments`: Attached files.</li></ul> | String |
| perPage | Number of issues per response page. The default value is 50. To set up additional response output parameters, use [pagination](../../common-format.md#displaying-results). | Number |

{% endcut %}

{% cut "Request body parameters" %}

**Additional parameters**

| Parameter | Description | Format |
----- | ----- | -----
| filter | Parameters for filtering issues.  The parameter can specify any field and value to filter by. | Objects |
| query | A filter using the [query language](../../user/query-filter.md). | String |
| expand | Additional fields to include in the response:<ul><li>`transitions`: Workflow transitions between statuses.</li><li>`attachments`: Attached files.</li></ul> | String |
| keys | List of issue keys. This parameter is not used together with the `filter` or `query` parameter. If you pass these parameters together, a search will only be performed by `keys`. | String |
| queue | Queue. This parameter is not used together with the `filter` or `query` parameter. If you pass these parameters together, a search will only be performed by `queue`. | String |
| order | The direction and field for sorting issues. The value is specified in `[+/-]<field name>` format. The + or - sign indicates the sorting direction.<br/>If you use the `query` parameter, the `order` parameter won't work. In this case, set the sorting in the `query` parameter using the [query language](../../user/query-filter.md). | String |

The `queue` and `keys` parameters can't be used simultaneously with the `filter` or `query` parameters. If they are passed together, the response will contain code 400 with a message saying `You can only use keys, a queue or a search query`.

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

## Scrollable search results {#scroll}

If your issue search response includes more than 10,000 rows, we recommend scrollable results.

When you use scrollable results, then, in response to your request, you get a page with the search results and an ID to retrieve the next page.

Search results can be ordered or displayed at random. To save on resources when retrieving numerous issues, use unsorted scrollable results.

{% note info %}

Scrollable search results consume more resources than [paginated output](../../common-format.md#displaying-results).

{% endnote %}

### Parameters of requests with scrollable results {#scroll-params}

- **scrollType**

  Scrolling type. Acceptable values:

  - `sorted`: The sorting specified in the request is used.
  - `unsorted`: No sorting is used.

  This parameter is only used in the first request of the scrollable sequence.

  This parameter isn't used together with the `keys` or `queue` search parameters. If you try to run a scrollable request with these parameters, the response will include code 400 and the message: `Scroll is not supported`. To find issues in the queue, use the `filter` or `query` parameters.

- **perScroll**

  Maximum number of issues per response. The default value is 100. The maximum allowed value is 1000.

  This parameter is only used in the first request of the scrollable sequence.

- **scrollTTLMillis (optional parameter)**

  The time-to-live of the scroll context and `scrollToken`, in milliseconds. The default value is 5000. The maximum allowed value is 60,000.

- **scrollId**

  Page ID.

  This parameter is only specified in the second and following requests of the scrollable sequence. The parameter value must be obtained from the `X-inScroll-Id` header returned in response to the previous request of the sequence.

- **scrollToken**

  Token that certifies that the request belongs to the current user.

  This parameter is only specified in the second and following requests of the scrollable sequence. The parameter value must be obtained from the `X-Scroll-Token` header returned in response to the previous request of the sequence.

  The token's time-to-live equals the value specified in the **scrollTTLMillis** parameter. If the token's time-to-live has expired, the response will include code 403 and the message: `Expired signature`.

### Response to a scrollable request {#scroll-response}

A scrollable request creates a snapshot of search results. Response pages are switched within this snapshot. This way, if an issue is edited and no longer meets the search query criteria, it won't affect the issue's output in the search results snapshot.

The snapshot of search results is preserved until all the pages have been viewed. If you don't want to load all the search results, clean busy resources using the request [{#T}](search-release.md).

The response includes the headers:

- **Link**

  Link to go to the next page of the search results. You can only use the link to go to the next or first page.

- **X-Scroll-Id**

  Page ID.

- **X-Scroll-Token**

  Token that certifies that the request belongs to the current user.

- **X-Total-Count**

  Total number of entries in the response.

### Example {#scroll-example}

Let's take an example of using scrollable search results: finding all issues assigned to a given employee.

Request conditions:
- An HTTP `GET` method is used.
- Key of the queue: <q>TREK</q>.
- Assignee: <user_login>
- Search results must be sorted.

Sequence of request execution:

1. Create the first request of the sequence with the parameters:
  - `scrollType=sorted`
  - `perScroll=100`
  - `scrollTTLMillis=10000`

   Example:
   ```json
   POST /v2/issues/_search?scrollType=sorted&perScroll=100&scrollTTLMillis=10000
   Host: {{ host }}
   Authorization: OAuth <OAuth token>
   {{ org-id }}

   {
     "filter": {
       "queue": "TREK",
       "assignee": "<user_login>"
     }
   }
   ```

  The response will include a list of issues and the headers:
  - `Link`;
  - `X-Total-Count`.

  If scrolling isn't complete, the following headers are also returned:
  - `X-Scroll-Id`. The value is used in the `scrollId` parameter to retrieve the next result page.
  - `X-Scroll-Token`. The value is used in the `scrollToken` parameter to retrieve the next result page.

1. Create the second request of the sequence with the `scrollId` and `scrollToken` parameters obtained at the previous step.

   Example:
   ```json
   POST /v2/issues/_search?scrollId=cXVlcnlU<...>&scrollToken=08e06389<...>&scrollTTLMillis=10000
   Host: {{ host }}
   Authorization: OAuth <OAuth token>
   {{ org-id }}

   {
     "filter": {
       "queue": "TREK",
       "assignee": "<user_login>"
     }
   }
   ```

  The response will return the next page of the issue list and the next `X-Scroll-Id` and `X-Scroll-Token` values (if scrolling isn't complete).

1. Continue sending requests until you retrieve all the issues.
