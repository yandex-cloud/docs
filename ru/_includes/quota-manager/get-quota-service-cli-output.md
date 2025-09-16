Будут выведены идентификаторы квот, которые есть в сервисе {{ iam-short-name }} в облаке, а также значения и потребление этих квот:

```text
resource:
  id: b1gia87mbaom********
  type: resource-manager.cloud
quota_limits:
  - quota_id: iam.accessKeys.count
    limit: 1001
    usage: 33
  - quota_id: iam.apiKeys.count
    limit: 1000
    usage: 14
  - quota_id: iam.authorizedKeys.count
    limit: 1000
    usage: 44
  ...
```