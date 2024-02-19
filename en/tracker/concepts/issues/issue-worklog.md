---
sourcePath: en/tracker/api-ref/concepts/issues/issue-worklog.md
---
# Getting all records for an issue

Use this request to get data about the time spent on an issue.

## Request format {#section_ssn_dyb_ffb}

To get records of time spent on issues, use an HTTP `GET` request:

```json
GET /{{ ver }}/issues/<issue_key_or_ID>/worklog
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
--- | --- | ---
| \<issue_ID_or_key\> | Issue ID or key. | String |

{% endcut %}

## Response format {#section_egr_qcc_ffb}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   The response body contains a JSON array with records of the time spent on the issue.

   ```json
   [
     {
     "self": "https://{{ host }}/v2/issues/TEST-324/worklog/1",
     "id": 1,
     "version": 1402121720882,
     "issue": {
       "self": "https://{{ host }}/v2/issues/TEST-324",
       "id": "515ec9eae4b09cfa********",
       "key": "TEST-324",
       "display": "important issue"
       },
     "comment": "important comment",
     "createdBy": {
       "self": "https://{{ host }}/v2/users/66********",
       "id": "veikus",
       "display": "Artem Veikus"
       },
     "updatedBy": {
       "self": "https://{{ host }}/v2/users/66********",
       "id": "veikus",
       "display": "Artem Veikus"
       },
     "createdAt": "2021-09-28T08:42:06.258+0000",
     "updatedAt": "2021-09-28T08:42:06.258+0000",
     "start": "2021-09-21T10:30:00.000+0000",
     "duration": "P3W"
     },
     ...
   ]
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
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
   | duration | Time spent, in ```PnYnMnDTnHnMnS, PnW``` format, according to the [ISO 8601]({{ link-iso-8601 }}).. | String |

   `issue` **object fields** {#issue}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the issue. | String |
   | id | Issue ID. | String |
   | key | Issue key. | String |
   | display | Issue name displayed. | String |

   `createdBy` **object fields** {#createdBy}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the user. | String |
   | id | User ID. | String |
   | display | Displayed user name. | String |

   `updatedBy` **object fields** {#updatedBy}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the user. | String |
   | id | User ID. | String |
   | display | Displayed user name. | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a message with error details:

   {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}
