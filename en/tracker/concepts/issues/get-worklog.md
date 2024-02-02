---
sourcePath: en/tracker/api-ref/concepts/issues/get-worklog.md
---
# Selecting records by parameters

Use this request to fetch data about the time spent by a specific user or during a certain period. You can make a `GET` or `POST` request.

## GET request format {#section_nvm_kth_jfb}

To get records of time spent, use the HTTP `GET` request:

```json
GET /{{ ver }}/worklog?createdBy=<user ID or name>&createdAt=from:<start of the time range>&createdAt=to:<end of the time range>
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| createdBy | ID or username of the record author. This is an optional parameter. | String |
| createdAt=from | Start of the time range the records were created in. Format: ```YYYY-MM-DDThh:mm:ss.sss±hhmm```</br>Optional parameter. | String |
| createdAt=to | End of the time range the records are created in. Format: ```YYYY-MM-DDThh:mm:ss.sss±hhmm```</br>Optional parameter. | String |

{% endcut %}

## POST request format {#section_shz_tqb_kfb}

To get records of time spent, use an HTTP `POST` request:

```json
POST /{{ ver }}/worklog/_search
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}

{
  "createdBy": "veikus",
  "createdAt": {
    "from": "2018-06-06T08:42:15.258",
    "to": "2018-06-06T08:42:20.258"
  }
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Request body parameters" %}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| createdBy | ID or username of the record author. This is an optional parameter. | String |
| [createdAt](#createdAt) | Object with information about the record creation date and time. This is an optional parameter. | Object |

`createdAt` **object fields** {#createdAt}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| from | Start of the time range the records were created in. Format: ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` | String |
| to | End of the time range the records are created in. Format: ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` | String |

{% endcut %}

## Response format {#section_x4q_jcc_kfb}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains a JSON array with records about the time spent, which were selected according to the specified parameters.

    ```json
    [
    {
      "self": "{{ host }}/v2/issues/TEST-324/worklog/1",
      "id": 1,
      "version": 1402121720882,
      "issue": {
        "self": "{{ host }}/v2/issues/TEST-324",
        "id": "515ec9eae4b09cfa984e2047",
        "key": "TEST-324",
        "display": "important issue"
      },
      "comment": "important comment",
      "createdBy": {
        "self": "{{ host }}/v2/users/1120000000014909",
        "id": "veikus",
        "display": "Artem Veikus"
      },
      "updatedBy": {
        "self": "{{ host }}/v2/users/1120000000014909",
        "id": "veikus",
        "display": "Artem Veikus"
      },
      "createdAt": "2018-06-06T08:42:06.258+0000",
      "updatedAt": "2018-06-06T08:42:06.258+0000",
      "start": "2018-06-06T08:41:58.000+0000",
      "duration": "P3W"
    }, 
      ... 
    ]
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with a record of the time spent on the issue. | String |
    | id | ID of the record of time spent. | String |
    | version | Record version. Each change to the record increases its version number. | String |
    | [issue](#issue) | Block with information about the issue. | Object |
    | comment | Text of the comment to the record. The comment is saved to the Time Spent report. | String |
    | [createdBy](#createdBy) | Object with information about the record author. | Object |
    | [updatedBy](#updatedBy) | Object with information about the user who updated the record last. | Object |
    | createdAt | Record creation date and time in ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` format. | String |
    | updatedAt | Record update date and time in ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` format. | String |
    | start | Date and time when work on the issue started, in ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` format. | String |
    | duration | Time spent, in ```PnYnMnDTnHnMnS, PnW``` format, according to the [ISO 8601]({{ link-iso-8601 }}). | String |

    ##### `issue` object fields {#issue}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the issue. | String |
    | id | Issue ID. | String |
    | key | Issue key. | String |
    | display | Issue name displayed. | String |

    `createdBy` **object fields** {#createdBy}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the user | String |
    | id | User ID | String |
    | display | Displayed user name | String |

    `updatedBy` **object fields** {#updatedBy}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the user | String |
    | id | User ID | String |
    | display | Displayed user name | String |

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a message with error details:

    {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}
