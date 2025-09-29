In the output, you will get the IDs of the quotas in place in {{ iam-short-name }} within the cloud, their values ​and usage figures:

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