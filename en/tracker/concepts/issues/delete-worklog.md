---
sourcePath: en/tracker/api-ref/concepts/issues/delete-worklog.md
---
# Delete a record of time spent

Use this request to delete a record of the time spent on an issue.

## Request format {#section_fkp_5ng_jfb}

To delete records of time spent on issues, use an HTTP `DELETE` request:

```json
DELETE /{{ ver }}/issues/<issue-id>/worklog/<worklog-id>
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| --- | --- | --- |
| \<issues-id\> | Issue ID or key. | String |
| \<worklog-id\> | ID of the record of time spent. | String |

{% endcut %}

## Response format {#section_wlq_d5g_jfb}

{% list tabs %}

- Request executed successfully

    {% include [answer-204](../../../_includes/tracker/api/answer-204.md) %}

    The response body is missing.

- Request failed

    If a request fails, the response message contains details of the errors encountered:

    {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}

