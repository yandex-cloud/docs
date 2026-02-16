Пример команды с тремя приемниками:

```bash
yc serverless eventrouter rule update my-rule \
  --logging-target log-group-id=e23di6hvn5fm********,service-account-id=ajelprpohp7r******** \
  --workflow-target workflow-id=dfq28ndgtojl********,service-account-id=ajelprpohp7r******** \
  --function-target function-id=d4e27bc01uu7********,function-tag=$latest,service-account-id=ajelprpohp7r********
```

Результат:

```text
id: f66h4vmpsvoh********
bus_id: f66epjc9llqt********
folder_id: b1g681qpemb4********
cloud_id: b1gia87mbaom********
created_at: "2025-03-02T07:57:22.064950Z"
name: my-rule
targets:
  - function:
      function_id: d4e27bc01uu7********
      service_account_id: oielprnahp7r********
      batch_settings:
        max_count: "1"
        max_bytes: "10000"
        cutoff: 60s
    retry_settings:
      retry_attempts: "3"
      maximum_age: 600s
    status: ENABLED
  - logging:
      log_group_id: e23di6hvn5fm********
      service_account_id: aj91prpohp6q********
    retry_settings:
      retry_attempts: "3"
      maximum_age: 600s
    status: ENABLED
  - workflow:
      workflow_id: dfq28ndgtojl********
      service_account_id: ajel4bnehp5s********
      batch_settings:
        max_count: "1"
        max_bytes: "10000"
        cutoff: 60s
    retry_settings:
      retry_attempts: "3"
      maximum_age: 600s
    status: ENABLED
status: ENABLED
```