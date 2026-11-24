---
title: Как настроить алерты {{ monium-full-name }} для ресурсов {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете настроить алерты {{ monium-name }} для ресурсов {{ backup-name }}.
---

# Настроить алерты {{ monium-full-name }} для ресурсов {{ backup-full-name }}

{% include [alert-definition](../../_includes/monium/alert-definition.md) %}

Вы можете [настроить](../../monium/operations/alert/create-alert.md) алерт на любую из метрик [{{ backup-full-name }}](../../backup/index.yaml). Рекомендуется создать алерты на следующие события:

* Доступна новая версия [агента {{ backup-name }}](../concepts/agent.md).
* Агент {{ backup-name }} недоступен.
* Неудачная операция резервного копирования.

{% note info %}

Если метрика еще ни разу не поступала в {{ monium-name }}, система не сможет предложить выбрать эту метрику в выпадающем меню конструктора запросов. В этом случае введите запрос в режиме кода на [языке запросов](../../monium/concepts/querying.md).

{% endnote %}


### Доступные версии агентов {#version-available}

Чтобы создать алерт для уведомлений о доступных версиях агента:

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. [Перейдите]({{ link-monium }}) в {{ monium-name }}.
  1. На панели сверху выберите [проект](../../monium/concepts/glossary.md#project), в котором будет создан алерт.

      Это может быть как проект, автоматически созданный для [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) (`folder__<идентификатор_каталога>`), так и другой доступный проект.
  1. На панели слева выберите ![shield-exclamation](../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO**, затем ![megaphone](../../_assets/console-icons/megaphone.svg) **Алерты**.
  1. Вверху справа нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}**.
  1. В поле **{{ ui-key.yacloud_monitoring.alert.title_name }}** укажите `agent_available_new_version`
  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-config }}**:
      1. Включите режим кода, нажав ![image](../../_assets/console-icons/code.svg).
      1. Введите запрос на языке запросов:

          ```text
          {project = "folder__<идентификатор_каталога>", cluster = "default", service = "__backup__", resource_type = "agent", name = "agent_version_available", resource_name = "<имя_ресурса>"}
          ```

          Где:

          * `project` — идентификатор [проекта](../../monium/concepts/glossary.md#project) {{ monium-name }}, в который поступают метрики защищаемого ресурса.

              Метрики ресурса передаются в проект {{ monium-name }} `folder__<идентификатор_каталога>`, автоматически созданный для [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) с этим ресурсом.
          * `cluster` — окружение.
          * `service` — имя сервиса.
          * `resource_type` — тип ресурса.
          * `name` — имя метрики.
          * `resource_name` — имя ВМ {{ compute-name }} или сервера {{ baremetal-name }}. Чтобы выбрать все ресурсы с этой меткой, укажите `"*"`.

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}** укажите:
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-ne }}`.
      * **{{ ui-key.yacloud_monitoring.alert.status_warn }}** — удалите значение.
      * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}** — `0`.

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** добавьте нужные каналы уведомлений.
  1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}


### Агент недоступен {#agent-offline}

Чтобы создать алерт для уведомлений о недоступности агента:

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. [Перейдите]({{ link-monium }}) в {{ monium-name }}.
  1. На панели сверху выберите [проект](../../monium/concepts/glossary.md#project), в котором будет создан алерт.

      Это может быть как проект, автоматически созданный для [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) (`folder__<идентификатор_каталога>`), так и другой доступный проект.
  1. На панели слева выберите ![shield-exclamation](../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO**, затем ![megaphone](../../_assets/console-icons/megaphone.svg) **Алерты**.
  1. Вверху справа нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}**.
  1. В поле **{{ ui-key.yacloud_monitoring.alert.title_name }}** укажите `agent_status_offline`
  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-config }}**:
      1. Включите режим кода, нажав ![image](../../_assets/console-icons/code.svg).
      1. Введите запрос на языке запросов:

          ```text
          {project = "folder__<идентификатор_каталога>", cluster = "default", service = "__backup__", resource_type = "agent", name = "agent_alive", resource_name = "<имя_ресурса>"}
          ```

          Где:

          * `project` — идентификатор [проекта](../../monium/concepts/glossary.md#project) {{ monium-name }}, в который поступают метрики защищаемого ресурса.

              Метрики ресурса передаются в проект {{ monium-name }} `folder__<идентификатор_каталога>`, автоматически созданный для [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) с этим ресурсом.
          * `cluster` — окружение.
          * `service` — имя сервиса.
          * `resource_type` — тип ресурса.
          * `name` — имя метрики.
          * `resource_name` — имя ВМ {{ compute-name }} или сервера {{ baremetal-name }}. Чтобы выбрать все ресурсы с этой меткой, укажите `"*"`.

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}** укажите:
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-eq }}`.
      * **{{ ui-key.yacloud_monitoring.alert.status_warn }}** — удалите значение.
      * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}** — `0`.

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** добавьте нужные каналы уведомлений.
  1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}


### Неудачная операция резервного копирования {#operation-failure}

Чтобы создать алерт для уведомлений о неудачных операциях резервного копирования:

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. [Перейдите]({{ link-monium }}) в {{ monium-name }}.
  1. На панели сверху выберите [проект](../../monium/concepts/glossary.md#project), в котором будет создан алерт.

      Это может быть как проект, автоматически созданный для [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) (`folder__<идентификатор_каталога>`), так и другой доступный проект.
  1. На панели слева выберите ![shield-exclamation](../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO**, затем ![megaphone](../../_assets/console-icons/megaphone.svg) **Алерты**.
  1. Вверху справа нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}**.
  1. В поле **{{ ui-key.yacloud_monitoring.alert.title_name }}** укажите `agent_operation_failure`
  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-config }}**:
      1. Включите режим кода, нажав ![image](../../_assets/console-icons/code.svg).
      1. Введите запрос на языке запросов:

          ```text
          {project = "folder__<идентификатор_каталога>", cluster = "default", service = "__backup__", resource_type = "backup", name = "BackupError", action = "CompleteFailed", resource_name = "<имя_ресурса>"}
          ```

          Где:

          * `project` — идентификатор [проекта](../../monium/concepts/glossary.md#project) {{ monium-name }}, в который поступают метрики защищаемого ресурса.

              Метрики ресурса передаются в проект {{ monium-name }} `folder__<идентификатор_каталога>`, автоматически созданный для [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) с этим ресурсом.
          * `cluster` — окружение.
          * `service` — имя сервиса.
          * `resource_type` — тип ресурса.
          * `name` — имя метрики.
          * `action` — тип действия.
          * `resource_name` — имя ВМ {{ compute-name }} или сервера {{ baremetal-name }}. Чтобы выбрать все ресурсы с этой меткой, укажите `"*"`.

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}** укажите:
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}`.
      * **{{ ui-key.yacloud_monitoring.alert.status_warn }}** — удалите значение.
      * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}** — `0`.

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** добавьте нужные каналы уведомлений.
  1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}


#### Полезные ссылки {#see-also}

* [{#T}](get-stats.md)
* [{#T}](../metrics.md)
