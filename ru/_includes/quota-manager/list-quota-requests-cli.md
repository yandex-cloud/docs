```bash
yc quota-manager quota-request list \
  --resource-type <тип_ресурса> \
  --resource-id <идентификатор_ресурса> \
  --limit <количество_запросов>
```

Где:
* `--resource-type` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
* `--resource-id` — идентификатор ресурса (облака, организации или платежного аккаунта).
* `--limit` — количество запросов на странице.