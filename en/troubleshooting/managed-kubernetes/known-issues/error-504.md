# Resolving the "DEADLINE_EXCEEDED" error



## Issue description {#issue-description}

When attempting to execute this curl request:
```
curl "https://monitoring.api.cloud.yandex.net/monitoring/v2/prometheusMetrics/?folderId=folder_id&service=managed-kubernetes" -H "Authorization: Bearer ${IAM_TOKEN}" -H "Content-Type: application/json" -i
```
you see this error message:
```
{"code":504,"message":"Metabase: [cloud-prod-sas] Status{code=DEADLINE_EXCEEDED, description=deadline exceeded after 0.807915461s, ... cause=null}"}
```

## Solution {#issue-resolution}

This error arises because of numerous metrics, due to which the request does not have time to complete. We recommend exporting metrics using selectors to reduce the volume of data:
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

The `selectors` parameter for pod metrics can be filtered by namespace or pod name mask, for example, pod=`part-of-name*`. We write more details in the [query language documentation](https://cloud.yandex.ru/docs/monitoring/concepts/querying).

{% endnote %}