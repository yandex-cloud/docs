---
sourcePath: en/tracker/api-ref/concepts/issues/search-issues.md
---
# Finding issues

Use this request to get a list of issues that meet specific criteria.

If the number of rows in the response is less than 10,000, use [paginated output](../../common-format.md#displaying-results).

If the number of rows in the response exceeds 10,000, use [scrollable results](#scroll).

## Request format {#section_rnm_x4j_p1b}

Before making the request, [get permission to access the API](../access.md).

To search for issues, use an HTTP `POST` request. The request body contains the search criteria.

```json
POST /v2/issues/_search?expand=transitions
Host: {{ host }}
Authorization: OAuth <OAuth token
{{ org-id }}

{
   "filter": {
      "<field_name>": "<field_value>"
   },
   "order":"+<field_key>"
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| expand | Additional fields to include in the response: <ul><li>`transitions`: Workflow transitions between statuses</li><li>`attachments`: Attached files</li></ul> | String |
| perPage | Number of issues per response page. The default value is 50. To set up additional response output parameters, use [pagination](../../common-format.md#displaying-results). | Number |

{% endcut %}

{% cut "Request body parameters" %}

To get the issue list, specify one of the following parameters:

| Parameter | Description | Format |
----- | ----- | -----
| queue | Queue | String |
| keys | List of issue keys | String or Array of strings |
| filter | Issue filtering parameters. The parameter can specify any field and value to filter by. | Object |
| query | Filter using the [query language](../../user/query-filter.md) | String |

{% note info %}

Do not combine parameters in your request.

If a combination of two parameters is used, the result will be returned for the higher priority parameter.
Parameter priorities (in descending order):
1. `queue`
1. `keys`
1. `filter`
1. `query`

If a combination of two or three parameters is used, the response will contain code 400 with a message saying `You can only use keys, a queue, or a search query`.

{% endnote %}


**Additional parameters**

| Parameter | Description | Format |
----- | ----- | -----
| order | Issue sorting direction and field (only if combined with the `filter` parameter). <br/>The value is specified in `[+/-]<field_key>` format. Use the `+` or `-` sign to indicate the sorting direction. | String |

{% note info %}

If the `query` parameter is used, specify the sorting method based on the [query language](../../user/query-filter.md).
Responses to requests with the `queue` parameter are sorted by issue key, and those to requests with the `keys` parameter by issue name in alphabetical order.

{% endnote %}

{% endcut %}

> Example 1: Requesting an issue list using a filter:
>
> - An HTTP POST method is used.
> - The response will display attachments.
> - The response should only contain issues from the TREK queue with no assignee.
> - The results are sorted by status in ascending order.
>
> ```
> POST /v2/issues/_search?expand=attachments HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> {{ org-id }}
>
> {
>   "filter": {
>     "queue": "TREK",
>     "assignee": "Empty()"
>   },
>   "order":"+staus"
> }
> ```

> Example 1: Requesting an issue list using the query language:
>
> - An HTTP POST method is used.
> - The response should only contain issues from the TREK queue that are not epics.
> - The results are sorted by update date in descending order.
>
> ```
> POST /v2/issues/_search?expand=attachments HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> {{ org-id }}
>
> {
>   "query": "epic: notEmpty() Queue: TREK \"Sort by\": Updated DESC",
> }
> ```

## Response format {#section_xc3_53j_p1b}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   The response body contains the results in JSON format.

   {% include [answer-issue](../../../_includes/tracker/api/answer-issue.md) %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

   {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

## Scrollable search results {#scroll}

If your issue search response includes more than 10,000 rows, we recommend scrollable results.

If using scrollable results, in response to your request you will get a page with search results and an ID to get the next page.

Search results can be ordered or displayed at random. To save on resources when retrieving numerous issues, use unsorted scrollable results.

{% note info %}

Scrollable search results consume more resources than [paginated output](../../common-format.md#displaying-results).

{% endnote %}

### Parameters of requests with scrollable results {#scroll-params}

- **scrollType**

   Scrolling type. Acceptable values include:

   - `sorted`: Use sorting specified in the request.
   - `unsorted`: No sorting.

   This parameter is only used in the first request of the scrollable sequence.

   This parameter isn't used together with the `keys` or `queue` search parameters. If you try to run a scrollable request with these parameters, the response will include code 400 and the message: `Scroll is not supported`. To find issues in the queue, use the `filter` or `query` parameters.

- **perScroll**

   Maximum number of issues per response. The default value is 100. The maximum allowed value is 1000.

   This parameter is only used in the first request of the scrollable sequence.

- **scrollTTLMillis (optional parameter)**

   Scroll context lifetime in milliseconds. The default value is 60000.

- **scrollId**

   Page ID.

   This parameter is only specified in the second and following requests of the scrollable sequence. The parameter value must be obtained from the `X-inScroll-Id` header returned in response to the previous request of the sequence.


### Response to a scrollable request {#scroll-response}

A scrollable request creates a snapshot of search results. You can switch between the results pages within the snapshot. Thus if an issue was edited and no longer meets the search query criteria, it will not affect its output in the search results snapshot.

The snapshot of search results is preserved until all the pages have been viewed. If you do not want to load all the search results, clean busy resources using the [{#T}](search-release.md) request.

The response includes the headers:

- **Link**

   Link to the next search results page. You can only use the link to go to the next or first page.

- **X-Scroll-Id**

   Page ID.

- **X-Scroll-Token**

   Token that certifies that the request belongs to the current user.

- **X-Total-Count**

   Total number of entries in the response.

### Example {#scroll-example}

Let's consider an example of using scrollable search results: finding all issues assigned to an employee.

Request conditions:
- HTTP `GET` method is used.
- Queue key: TREK.
- Assignee: <user_login>.
- Search results must be sorted.

Sequence of request execution:

1. Create the first request of the sequence with the parameters:
   - `scrollType=sorted`
   - `perScroll=100`
   - `scrollTTLMillis=10000`

   For example:
   ```json
   POST /v2/issues/_search?scrollType=sorted&perScroll=100&scrollTTLMillis=10000
   Host: {{ host }}
   Authorization: OAuth <OAuth_token>
   {{ org-id }}

   {
     "filter": {
       "queue": "TREK",
       "assignee": "<user_login>"
     }
   }
   ```

   The response will include a list of issues and the headers:
   - `Link`: URLs of the first and next result pages:

      ```
      Link: <https://{{ host }}/v2/issues/_search?expand=&embed=&fields=&staleOk=false&scrollType=sorted&scrollTTLMillis=10000&perScroll=2000>; rel="first"
      Link: <https://{{ host }}/v2/issues/_search?expand=&embed=&fields=&staleOk=false&scrollTTLMillis=10000&scrollId=6554d4cbbda0de18********&scrollToken=dummy-token-you-dont-have-to-specify-it>; rel="next"
      ```

      Use the URL from the header with the `rel="next"` parameter to get the next results page.

   - `X-Total-Count`: Total number of issues in the output.

   If the requested page is not the last one, the following headers will also be returned:
   - `X-Scroll-Id`. The value is used in the `scrollId` parameter to get the next results page.
   - `X-Scroll-Token`. This value is not used in the current {{ ver }} API version.

1. Create the second request of the sequence with the `scrollId` and `scrollToken` parameters obtained in the previous step.

   For example:
   ```json
   POST /{{ ver }}/issues/_search?scrollId=cXVlcnlU<...>&scrollTTLMillis=10000
   Host: {{ host }}
   Authorization: OAuth <OAuth_token>
   {{ org-id }}

   {
     "filter": {
       "queue": "TREK",
       "assignee": "<user_login>"
     }
   }
   ```

   In response you will get the next page of the issue list and the next `X-Scroll-Id` and `X-Scroll-Token` values (if the page is not the last one).

1. Continue requesting the next results page until you get all the issues from the output.
