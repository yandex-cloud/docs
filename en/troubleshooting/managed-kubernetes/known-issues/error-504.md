# Fixing the `DEADLINE_EXCEEDED` error



## Issue description {#issue-description}

When attempting to run this curl request:
```
curl "https://{{ api-host-monitoring-1 }}/monitoring/v2/prometheusMetrics/?folderId=folder_id&service=managed-kubernetes" -H "Authorization: Bearer ${IAM_TOKEN}" -H "Content-Type: application/json" -i
```
You get this error message:
```
{"code":504,"message":"Metabase: [cloud-prod-sas] Status{code=DEADLINE_EXCEEDED, description=deadline exceeded after 0.807915461s, ... cause=null}"}
```

## Solution {#issue-resolution}

This error occurs because there are too many metrics for the request to process and complete before the timeout. We recommend exporting metrics using selectors to reduce the volume of data:

```
scrape_configs:
  - job_name: 'yc-monitoring-export'
    metrics_path: '/monitoring/v2/prometheusMetrics'
    params:
      folderId:
      - 'b1gXXXXXXXXXXXXXXXXX'
      service:
      - 'managed-kubernetes'
      selectors:
      - 'namespace=...'
    bearer_token: ...
```

{% note info %}

You can filter the `selectors` parameter for pod metrics by namespace or pod name mask, such as `pod=part-of-name*`. For more information, see [our query language guide](../../../monitoring/concepts/querying.md).

{% endnote %}