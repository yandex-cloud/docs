[View the quota ID](../../overview/concepts/quotas-limits.md#quotas-limits-default) and create an update request:

```bash
yc quota-manager quota-request create \
  --resource-type <resource_type> \
  --resource-id <resource_ID> \
  --desired-limit quota-id=<quota_ID>,value=<new_quota_value>
```

Where:

* `--resource-type`: Resource type, `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.
* `--resource-id`: ID of the resource (organization, cloud, or billing account).
* `--desired-limit`: Data for the quota update:
  * `quota-id`: Quota ID.
  * `value`: New quota value.

You can specify multiple quotas in a single request. To do this, add several `--desired-limit` parameters.