```bash
yc quota-manager quota-request list \
  --resource-type <тип_ресурса> \
  --resource-id <идентификатор_ресурса> \
  --limit <количество_запросов>
```

Где:

* `--resource-type` ([тип ресурса](../../quota-manager/concepts/index.md#resources-types)) определяет уровень просмотра запросов на изменение квот. Для уровня облака укажите `resource-manager.cloud`, для уровня организации — `organization-manager.organization`.
* `--resource-id` — идентификатор ресурса (облака или организации).
* `--limit` — максимальное количество запросов в выводе.
