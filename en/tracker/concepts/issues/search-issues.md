---
sourcePath: en/tracker/api-ref/concepts/issues/search-issues.md
---
# Searching for issues

Use this request to get a list of issues that meet specific criteria.

If the result contains between 50 and 10,000 lines, use [result pagination](../../common-format.md#displaying-results).

If the number of lines in the results exceeds 10,000, use [results scrolling](#scroll).

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
| perPage | Number of issues per response page. Default: 50. To set up additional response output parameters, use [pagination](../../common-format.md#displaying-results). | Number |

{% endcut %}

{% cut "Request body parameters" %}

**Additional parameters**

| Parameter | Description | Format |
| ----- | ----- | ----- |
| filter | Parameters for filtering issues. The parameter can specify any field and value to filter by. | Object |
| query | A filter using the [query language](../../user/query-filter.md). | String |
| expand | Additional fields to include in the response:<ul><li>`transitions`: Workflow transitions between statuses.</li><li>`attachments`: Attached files.</li></ul> | String |
| keys | List of issue keys. This parameter is not used in conjunction with the `filter` or `query` parameters. If you pass these parameters together, a search will only be performed by `keys`. | String |
| queue | Queue. This parameter is not used in conjunction with the `filter` or `query` parameters. If you pass these parameters together, a search will only be performed by `queue`. | String |

The `queue` and `keys` parameters can't be used in conjunction with the `filter` or `query` parameters. If they are passed together, the response will contain code 400 with a message saying `You can only use keys, a queue or a search query.`

{% endcut %}

> Request for a list of issues with additional filtering options:
>
>- An HTTP POST method is used.
>- Paginated results are enabled, and each page contains two entries.
>- The response will display attachments.
>- The response should only contain issues from the <q>JUNE</q> queue that don't have an assignee.
>
>```
>POST /v2/issues/_search?scrollType=sorted&amp;perScroll=2&expand=attachments HTTP/1.1
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>{{ org-id }}
>
>{
>  "filter": {
>    "queue": "JUNE",
>    "assignee": "Empty()"
>  }
>}
>```

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

## Scrolling through search results {#scroll}

If search results contain more than 10,000 lines, we recommend using results scrolling.

When you use scrolling, your request returns a page with search results and an ID for getting the next page.

Search results can be sorted or displayed as a random list. To reduce the amount of resources required to process a large volume of issues, use scrolling without sorting.

{% note info %}

Scrolling takes up more resources than [pagination](../../common-format.md#displaying-results).

{% endnote %}

### Scrolling request parameters {#scroll-params}

- **scrollType**

    Scrolling type. Acceptable values:
    - `sorted`: The sorting specified in the request is used.
    - `unsorted`: No sorting is used.

    This parameter is only used for the first request when using scrolling.

    This parameter isn't used in combination with the `keys` or `queue` search parameter. If you use these parameters when scrolling, the response will contain code 400 with a message saying `Results scrolling not supported`. To find issues within a queue, use the `filter` or `query` parameters.

- **perScroll**

    Maximum number of issues per response. The default value is 100. The maximum allowed value is 1000.

    This parameter is only used for the first request when using scrolling.

- **scrollTTLMillis (optional parameter)**

    Scroll context and `scrollToken` lifetime in milliseconds. The default value is 5000. The maximum allowed value is 60,000.

- **scrollId**

    Page ID.

    This parameter is specified in the second and all subsequent requests in a scrolling sequence. The parameter value is taken from the `X-Scroll-Id` header included in the response to the previous request in a sequence.

- **scrollToken**

    Token that certifies that the request belongs to the current user.

    This parameter is specified in the second and all subsequent requests in a scrolling sequence. The parameter value is taken from the `X-Scroll-Token` header included in the response to the previous request in a sequence.

    The token lifetime is equal to the value set in the **scrollTTLMillis** parameter. If token lifetime has expired, the response will contain code 403 with a message saying `Expired signature`.

### Responses to queries with scrolling {#scroll-response}

Using scrolling creates a snapshot of search results. You can only switch between search results pages within this snapshot. This way, if an issue is edited and no longer meets the search query criteria, it won't affect the issue's output in the search results snapshot.

The search results snapshot is saved until all pages have been viewed. If you don't want to load all search results, free up resources currently in use with the [{#T}](search-release.md) request.

The response contains the following headers:

- **Link**

    Link to go to the next page of the search results. You can only use this link to go to the next or the first page.

- **X-Scroll-Id**

    Page ID.

- **X-Scroll-Token**

    Token that certifies that the request belongs to the current user.

- **X-Total-Count**

    Total number of entries in the response.

### Example {#scroll-example}

Let's look at an example of search results with the scrolling option enabled: we need to find all issues assigned to a specific employee.

Request conditions:

- An HTTP `GET` method is used.
- Queue key: <q>TREK</q>.
- Issue assignee: <user_login>.
- Search results must be sorted.

Here is the request sequence:

1. Create the first request using the following parameters:
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

    The response will only contain the issue list and the following headers:
    - `Link`.
    - `X-Total-Count`.

    If scrolling is not finished, you will also get the following headers:
    - `X-Scroll-Id`. This value is used in the `scrollId` parameter for getting the next results page.
    - `X-Scroll-Token`. This value is used in the `scrollToken` parameter for getting the next results page.

1. Create the second request in the sequence by using the `scrollId` and `scrollToken` parameters you received during the previous step.

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

    Your request will result in a response containing the next issue list page and subsequent values for `X-Scroll-Id` and `X-Scroll-Token` if scrolling isn't finished by this point.

1. Continue sending requests until you receive all issues.

