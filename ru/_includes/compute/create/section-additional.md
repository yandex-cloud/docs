В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}**:

* (Опционально) Выберите или создайте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md). Использование сервисного аккаунта позволяет гибко настраивать права доступа к ресурсам.
* (Опционально) Разрешите доступ к [серийной консоли](../../../compute/operations/serial-console/index.md).
* (Опционально) В блоке **Резервное копирование** включите опцию **{{ ui-key.yacloud.compute.instances.create.action_activate-backup }}** и выберите или создайте [политику резервного копирования](../../../backup/concepts/policy.md), чтобы автоматически создавать резервные копии ВМ с помощью сервиса [{{ backup-name }}](../../../backup/index.yaml).

    Подробнее см. в разделе [{#T}](../../../backup/concepts/vm-connection.md).

* (Опционально) Чтобы настроить поставку [системных метрик Linux](../../../monitoring/operations/unified-agent/linux_metrics.md) и дополнительных метрик ваших приложений, в блоке **{{ ui-key.yacloud.compute.instances.create.section_monitoring }}** включите опцию **{{ ui-key.yacloud.compute.instances.create.unified-agent }}** и выберите:
  * **{{ monitoring-full-name }}** — [установить агент](../../../monitoring/concepts/data-collection/unified-agent/index.md) для сбора дополнительных метрик ВМ и приложений.
  * **{{ managed-prometheus-name }}** — [установить и настроить агент](../../../monitoring/operations/prometheus/ingestion/prometheus-agent.md) для сбора дополнительных метрик ВМ и приложений в формате {{ prometheus-name }}:
     * Выберите или создайте воркспейс, в котором будут храниться метрики.
     * (Опционально) Опишите в формате JSON [параметры поставки](../../../monitoring/operations/prometheus/ingestion/prometheus-agent.md) собственных метрик.
* (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_placement }}** выберите [группу размещения](../../../compute/concepts/placement-groups.md) ВМ.