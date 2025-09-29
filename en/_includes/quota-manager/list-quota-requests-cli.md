```bash
yc quota-manager quota-request list \
  --resource-type <resource_type> \
  --resource-id <resource_ID> \
  --limit <number_of_requests>
```

Where:
* `--resource-type`: Resource type, `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.
* `--resource-id`: ID of the resource (organization, cloud, or billing account).
* `--limit`: Number of requests per page.