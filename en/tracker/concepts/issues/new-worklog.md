---
sourcePath: en/tracker/api-ref/concepts/issues/new-worklog.md
---
# Add a record of time spent

Use this request to add a record of the time spent on an issue.

{% note info %}

In {{ tracker-full-name }}, time spent is measured in business weeks (5 days) and business days (8 hours).

For example, if you pass a time interval of 5 days (`P5D`), the request will return the value 1 week (`P1W`), which you'll see when viewing the issue.

{% endnote %}

## Request format {#section_sx2_rqr_ffb}

To create records of time spent on issues, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format:

```json
POST /{{ ver }}/issues/<issue-id>/worklog
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}

{
  "start": "2021-09-21T15:30:00.000+0500",
  "duration": "P5DT20M",
  "comment": "important comment"
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| --- | --- | --- |
| \<issues-id\> | Issue ID or key. | String |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| start | Date and time when work on the issue started, in ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` format | String |
| duration | Time spent, in ```PnYnMnDTnHnMnS, PnW``` format, according to the [ISO 8601]({{ link-iso-8601 }}).<br><br>Separate hours, minutes, and seconds from the rest using the letter T.<br><br>For example, the value `P6W` corresponds to an interval of 6 weeks (30 business days), the value `PT300M` to an interval of 300 minutes (5 hours), and the value `P0Y0M30DT2H10M25S` to an interval of 30 days, 2 hours, 10 minutes, and 25 seconds. | String |

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| comment | Text of the comment to the record. The comment is saved to the [Time Spent](../../manager/statistics.md) report. | String |

{% endcut %}

## Response format {#section_lpd_g3r_ffb}

{% list tabs %}

- Request executed successfully

    {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

    The response body contains a JSON object with a record of the time spent on the issue.

    ```json
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
      "createdAt": "2021-09-28T08:42:06.258+0000",
      "updatedAt": "2021-09-28T08:42:06.258+0000",
      "start": "2021-09-21T10:30:00.000+0000",
      "duration": "P1WT20M"
    }
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with a record of the time spent on the issue. | String |
    | id | ID of the record of time spent. | String |
    | version | Record version. Each change to the record increases its version number. | String |
    | [issue](#issue) | Block with information about the issue. | Object |
    | comment | Text of the comment to the record. The comment is saved to the Time Spent report. | String |
    | [createdBy](#createdBy) | Object with information about the user who added the record. | Object |
    | [updatedBy](#updatedBy) | Object with information about the user who edited the record. | Object |
    | createdAt | Record creation date and time in ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` format | String |
    | updatedAt | Record update date and time in ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` format | String |
    | start | Date and time when work on the issue started, in ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` format | String |
    | duration | Time spent, in ```PnYnMnDTnHnMnS, PnW``` format, according to the [ISO 8601]({{ link-iso-8601 }}). | String |

    **Object fields** `issue` {#issue}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the issue. | String |
    | id | Issue ID. | String |
    | key | Issue key. | String |
    | display | Issue name displayed. | String |

    **Object fields** `createdBy` {#createdBy}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the user. | String |
    | id | User ID. | String |
    | display | User's name displayed. | String |

    **Object fields** `updatedBy` {#updatedBy}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the user. | String |
    | id | User ID. | String |
    | display | User's name displayed. | String |

    {% endcut %}

- Request failed

    If a request fails, the response message contains details of the errors encountered:

    {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-422.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}

