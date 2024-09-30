В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}**:

* (Опционально) Выберите или создайте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md). Использование сервисного аккаунта позволяет гибко настраивать права доступа к ресурсам.
* (Опционально) Разрешите доступ к [серийной консоли](../../../compute/operations/serial-console/index.md).
* (Опционально) Включите [программно-ускоренную сеть](../../../compute/concepts/software-accelerated-network.md).
* (Опционально) В блоке **Резервное копирование** включите опцию **{{ ui-key.yacloud.compute.instances.create.action_activate-backup }}** и выберите или создайте [политику резервного копирования](../../../backup/concepts/policy.md), чтобы автоматически создавать резервные копии ВМ с помощью сервиса [{{ backup-name }}](../../../backup/index.yaml).

    Подробнее см. в разделе [{#T}](../../../backup/concepts/vm-connection.md).
* (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_monitoring }}** включите опцию **{{ ui-key.yacloud.compute.instances.create.unified-agent }}**, чтобы настроить поставку [метрик](../../../compute/metrics.md) в [{{ monitoring-full-name }}](../../../compute/monitoring/) или [{{ managed-prometheus-full-name }}](../../../monitoring/operations/prometheus/index.md).
* (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_placement }}** выберите [группу размещения](../../../compute/concepts/placement-groups.md) ВМ.