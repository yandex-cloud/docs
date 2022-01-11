---
sourcePath: en/tracker/api-ref/concepts/issues/get-priorities.md
---
# Get priorities

Use this request to get a list of priorities for an issue.

## Request format {#section_rnm_x4j_p1b}

To get a list of priorities, use an HTTP `GET` request:

```json
GET /v2/priorities?
localized=<true/false>
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Request parameters {#req-get-params}

- **localized**

    Shows if the response contains translations. Acceptable values:
    - `true`: The response only contains priority descriptions in the user's language. Default value.
    - `false`: The response contains priority descriptions in all supported languages.

> Request for priorities:
> 
> - Use the HTTP GET method.
> 
> ```
> GET /v2/priorities HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> X-Org-Id: <organization ID>
> Cache-Control: no-cache
> ```

## Response format {#section_xc3_53j_p1b}

```json
[
    {
        "self": "{{ host }}/v2/priorities/5",
        "id": 5,
        "key": "blocker",
        "version": 1341632717561,
        "name": "Blocker",
        "order": 5
    },
    ...
]
```

#### Response parameters {#answer-params}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the object. | String |
| id | Priority ID. | Number |
| key | Priority key. | String |
| version | Priority version. | Number |
| name | Priority name displayed. If `localized=false` is passed in the request, this parameter duplicates the name in other languages. | String |
| order | Priority weight. This parameter affects the order of priority display in the interface. | Number |

## Possible response codes {#section_otf_jrj_p1b}

200
:   Request executed successfully.

