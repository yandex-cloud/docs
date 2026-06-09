# Устранение ошибки `DEADLINE_EXCEEDED`


## Описание проблемы {#issue-description}

При попытке выполнить curl-запрос следующего вида:
```
curl "https://{{ api-host-monitoring-1 }}/monitoring/v2/prometheusMetrics/?folderId=folder_id&service=managed-kubernetes" -H "Authorization: Bearer ${IAM_TOKEN}" -H "Content-Type: application/json" -i
```
возникает сообщение об ошибке:
```
{"code":504,"message":"Metabase: [cloud-prod-sas] Status{code=DEADLINE_EXCEEDED, description=deadline exceeded after 0.807915461s, ... cause=null}"}
```

## Решение {#issue-resolution}

Причина такой ошибки заключается в большом количестве метрик, из-за чего запрос не успевает отработать. Рекомендуем выгружать метрики, используя селекторы, чтобы снизить объем данных:

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

Сам параметр `selectors` для метрик подов можно фильтровать по пространству имен или маске имени пода, например `pod=part-of-name*`. Подробнее пишем в [документации языка запросов](../../../monitoring/concepts/querying.md).

{% endnote %}