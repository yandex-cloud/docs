```bash
yc quota-manager quota-request create --resource-id=b1gflhy******** --resource-type=resource-manager.cloud --desired-limit quota-id=compute.placementGroups.count,value=5 --desired-limit quota-id=storage.buckets.count,value=30
```

Будет создан запрос для облака `b1gflhy********` на увеличение квот:
* В сервисе {{ compute-name }} — количество групп размещения ВМ (`compute.placementGroups.count`), новое значение — `5`.
* В сервисе {{ objstorage-name }} — количество бакетов (`storage.buckets.count`), новое значение — `30`.