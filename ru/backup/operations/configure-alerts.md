---
title: Как настроить алерты {{ monium-full-name }} для ресурсов {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете настроить алерты {{ monium-name }} для ресурсов {{ backup-name }}.
---

# Настроить алерты {{ monium-full-name }} для ресурсов {{ backup-full-name }}

{% include [alert-definition](../../_includes/monium/alert-definition.md) %}

Вы можете [настроить](../../monium/operations/alert/create-alert.md) алерт на любую из метрик [{{ backup-full-name }}](../../backup/). Рекомендуется создать алерты на следующие события:

* Доступна новая версия [агента {{ backup-name }}](../concepts/agent.md).
* Агент {{ backup-name }} недоступен.
* Неудачная операция резервного копирования.

{% note info %}

Если метрика еще ни разу не поступала в {{ monium-name }}, система не сможет предложить выбрать эту метрику в выпадающем меню конструктора запросов. В этом случае введите запрос в режиме кода на [языке запросов](../../monium/concepts/querying.md).

{% endnote %}


### Доступные версии агентов {#version-available}

Чтобы создать алерт для уведомлений о доступных версиях агента:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
  1. Вверху справа нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}**.
  1. В поле **{{ ui-key.yacloud_monitoring.alert.title_name }}** укажите `agent_available_new_version`
  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-config }}**:
      1. Включите режим кода, нажав ![image](../../_assets/console-icons/code.svg).
      1. Введите запрос на языке запросов:

          ```text
          {project = "folder__<идентификатор_каталога>", service = "__backup__", cluster = "default", resource_type = "agent", name = "agent_version_available", resource_name = "<имя_ВМ>"}
          ```

          Где:

          * `project` — идентификатор каталога, в котором находится ВМ. Идентификатор каталога можно [скопировать](../../resource-manager/operations/folder/get-id.md) в [консоли управления]({{ link-console-main }}) на панели сверху.
          * `service` — имя сервиса.
          * `cluster` — окружение.
          * `resource_type` — тип ресурса.
          * `name` — имя метрики.
          * `resource_name` — имя виртуальной машины. Чтобы выбрать все ВМ, вместо имени ВМ укажите `"*"`.

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}** укажите:
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-ne }}`.
      * **{{ ui-key.yacloud_monitoring.alert.status_warn }}** — удалите значение.
      * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}** — `0`.

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** добавьте нужные каналы уведомлений.
  1. Нажмите **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}


### Агент недоступен {#agent-offline}

Чтобы создать алерт для уведомлений о недоступности агента:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
  1. Вверху справа нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}**.
  1. В поле **{{ ui-key.yacloud_monitoring.alert.title_name }}** укажите `agent_status_offline`
  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-config }}**:
      1. Включите режим кода, нажав ![image](../../_assets/console-icons/code.svg).
      1. Введите запрос на языке запросов:

          ```text
          {project = "folder__<идентификатор_каталога>", service = "__backup__", cluster = "default", resource_type = "agent", name = "agent_alive", resource_name = "<имя_ВМ>"}
          ```

          Где:

          * `project` — идентификатор каталога, в котором находится ВМ. Идентификатор каталога можно [скопировать](../../resource-manager/operations/folder/get-id.md) в [консоли управления]({{ link-console-main }}) на панели сверху.
          * `service` — имя сервиса.
          * `cluster` — окружение.
          * `resource_type` — тип ресурса.
          * `name` — имя метрики.
          * `resource_name` — имя виртуальной машины. Чтобы выбрать все ВМ, вместо имени ВМ укажите `"*"`.

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}** укажите:
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-eq }}`.
      * **{{ ui-key.yacloud_monitoring.alert.status_warn }}** — удалите значение.
      * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}** — `0`.

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** добавьте нужные каналы уведомлений.
  1. Нажмите **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}


### Неудачная операция бэкапа {#operation-failure}

Чтобы создать алерт для уведомлений о неудачных операциях бэкапа:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
  1. Вверху справа нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}**.
  1. В поле **{{ ui-key.yacloud_monitoring.alert.title_name }}** укажите `agent_operation_failure`
  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-config }}**:
      1. Включите режим кода, нажав ![image](../../_assets/console-icons/code.svg).
      1. Введите запрос на языке запросов:

          ```text
          {project = "folder__<идентификатор_каталога>", service = "__backup__", cluster = "default", resource_type = "agent", name = "BackupError", action = "CompleteFailed", resource_name = "<имя_ВМ>"}
          ```

          Где:

          * `project` — идентификатор каталога, в котором находится ВМ. Идентификатор каталога можно [скопировать](../../resource-manager/operations/folder/get-id.md) в [консоли управления]({{ link-console-main }}) на панели сверху.
          * `service` — имя сервиса.
          * `cluster` — окружение.
          * `resource_type` — тип ресурса.
          * `name` — имя метрики.
          * `action` — тип действия.
          * `resource_name` — имя виртуальной машины. Чтобы выбрать все ВМ, вместо имени ВМ укажите `"*"`.

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}** укажите:
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}`.
      * **{{ ui-key.yacloud_monitoring.alert.status_warn }}** — удалите значение.
      * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}** — `0`.

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** добавьте нужные каналы уведомлений.
  1. Нажмите **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}


#### См. также {#see-also}

* [{#T}](get-stats.md)
* [{#T}](../metrics.md)