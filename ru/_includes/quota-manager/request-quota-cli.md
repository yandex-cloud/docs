[Посмотрите идентификатор квоты](../../overview/concepts/quotas-limits#quotas-limits-default) и создайте запрос на ее изменение:

```bash
yc quota-manager quota-request create \
  --resource-type <тип_ресурса> \
  --resource-id <идентификатор_ресурса> \
  --desired-limit quota-id=<идентификатор_квоты>,value=<новое_значение_квоты>
```

Где:

* `--resource-type` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
* `--resource-id` — идентификатор ресурса (облака, организации или платежного аккаунта).
* `--desired-limit` — данные для изменения квоты:
  * `quota-id` — идентификатор квоты.
  * `value` — новое значение, которое нужно присвоить квоте.

В одном запросе можно указать несколько квот. Для этого добавьте несколько параметров `--desired-limit`.