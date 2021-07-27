---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Find out the number of issues

Use this request to find out the number of issues that meet the conditions of your request.

## Request format {#section_rnm_x4j_p1b}

To get the number of issues that meet certain criteria, use an HTTP `POST` request. The search criteria are passed in the request body in JSON format:

```json
POST /v2/issues/_count
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>

{
"filter": {
    "<field name>": "<field value>"
  },
  "query": "filter in the query language"
}
```

#### Parameters passed in the request body {#req-body-params}

| Parameter | Description | Format |
| ----- | ----- | ----- |
| filter | Parameters for filtering issues. The parameter can specify any field and value to filter by. | Object |
| query | A filter using the [query language](../../user/query-filter.md). | String |

> Request for the number of issues with additional filtering options:
>
> - An HTTP POST method is used.
> - The response should only contain the number of issues from the <q> JUNE</q> queue that don't have an assignee.
> 
> ```
> POST /v2/issues/_count HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> X-Org-Id: <organization ID>
> Cache-Control: no-cache
>
> {
>  "filter": {
>    "queue": "JUNE",
>    "assignee": "empty()"
>  }
> }'
> ```

## Response format {#section_xc3_53j_p1b}

The response contains the number of issues that meet the conditions of your request.

```
5221186
```

## Possible response codes {#section_otf_jrj_p1b}

200
:   Request executed successfully.

