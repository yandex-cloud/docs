---
sourcePath: en/tracker/api-ref/concepts/issues/get-transitions.md
---
# Get transitions

Use this request to get a list of possible issue transitions. The issue is selected when its ID or key is specified.

## Request format {#section_rnm_x4j_p1b}

To get a list of possible transitions, use an HTTP `GET` request:

```json
GET /v2/issues/<issue-id>/transitions
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Request parameters {#req-get-params}

- **\<issue-id\>**

    Issue ID or key.

> Getting a list of transitions:
> 
> - Use the HTTP GET method.
> 
> ```
> GET /v2/issues/JUNE-3/transitions HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> X-Org-Id: <organization ID>
> Cache-Control: no-cache
> ```

## Response format {#section_xc3_53j_p1b}

```json
[
    {
        "id": "resolve",
        "self": "{{ host }}/v2/issues/JUNE-2/transitions/resolve",
        "display": "Resolve",
        "to": {
            "self": "{{ host }}/v2/statuses/1",
            "id": "1",
            "key": "open",
            "display": "Open"
        }
    },
    ...
]
```

#### Response parameters {#answer-params}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Transition ID. | String |
| self | Transition link. | String |
| display | Transition name displayed. Matches the corresponding button name in the {{ tracker-name }} interface. | String |
| [to](#to) | Object with information about a new issue status. | Object |

**Object fields** `to` {#to}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Status link. | String |
| id | Status ID. | String |
| key | Status key. | String |
| display | Status name displayed. | String |

## Possible response codes {#section_otf_jrj_p1b}

200
:   Request executed successfully.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

