[Посмотрите идентификатор квоты](../../quota-manager/all-quotas.md) и создайте запрос на ее изменение:

```bash
yc quota-manager quota-request create \
  --resource-type <тип_ресурса> \
  --resource-id <идентификатор_ресурса> \
  --desired-limit quota-id=<идентификатор_квоты>,value=<новое_значение_квоты>
```

Где:

* `--resource-type` ([тип ресурса](../../quota-manager/concepts/index.md#resources-types)) определяет уровень изменения квот. Для уровня облака укажите `resource-manager.cloud`, для уровня организации — `organization-manager.organization`.
* `--resource-id` — идентификатор ресурса (облака или организации).
* `--desired-limit` — данные для изменения квоты:
  * `quota-id` — идентификатор квоты.
  * `value` — желаемое итоговое значение квоты.

В одном запросе можно указать несколько квот. Для этого добавьте несколько параметров `--desired-limit`.
