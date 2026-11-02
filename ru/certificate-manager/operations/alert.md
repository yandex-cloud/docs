---
title: Как добавить алерт для сертификата в {{ certificate-manager-full-name }}
description: Следуя этой инструкции, вы сможете добавить алерт о скором истечении срока действия сертификата или о его неработоспособности.
---

# Добавить алерт для сертификата

Чтобы вовремя обновлять сертификаты и реагировать на проблемы с ними, создайте алерты:

* **О скором истечении срока действия** — переходит в статус `Warning`, когда до истечения срока действия сертификата остается 14 дней или меньше, и в `Alarm` — 4 дня или меньше.
* **О неработоспособности** — переходит в статус `Alarm`, если хотя бы один из отслеживаемых сертификатов не прошел проверку прав на домены (`Invalid`), отозван (`Revoked`) или срок его действия истек.

[Алерт](../../monium/concepts/alerting/alert.md) — периодическая проверка метрик по заданным условиям. `Warning` означает, что достигнут порог предупреждения, а `Alarm` — критический порог. При переходе в эти статусы {{ monium-name }} отправляет уведомления через настроенный канал, например, по электронной почте или в {{ messenger-full-name }}. 

Инструкция ниже описывает создание одного алерта. Вам потребуется создать два отдельных алерта, выбрав соответствующий вариант настройки.

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. [Перейдите]({{ link-monium }}) в **{{ ui-key.yacloud.iam.folder.dashboard.label_monium }}** и на панели сверху выберите [проект](../../monium/concepts/glossary.md#project), в котором будет создан алерт.

     Это может быть проект, автоматически созданный для [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) (`folder__<идентификатор_каталога>`), или другой доступный проект.
  1. [Создайте канал уведомлений](../../monium/operations/alert/create-channel.md), если его нет. Для обоих алертов можно использовать один канал.
  1. На панели слева выберите ![shield-exclamation](../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO** → ![megaphone](../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.create }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.main-info }}** задайте название алерта и при необходимости добавьте описание.
  1. В блоке **{{ ui-key.yacloud_monitoring.alert-template.section.type-settings }}** последовательно задайте параметры запроса:

     * `project = folder__<идентификатор_каталога>` — укажите идентификатор каталога, в котором находятся сертификаты.

       {% include [query-select-different-project](../../_includes/monium/query-select-different-project.md) %}

     * `cluster = default`.
     * `service = certificate-manager`.
     * `certificate = *`. Для отслеживания конкретного сертификата укажите его идентификатор.

  1. Для настройки алерта о скором истечении срока действия сертификата: {#expired}

       1. В запросе укажите `name = certificate.days_until_expiration`.
       1. Используйте функцию `series_min()`, чтобы получить наименьшее число оставшихся дней среди отслеживаемых сертификатов. Если отслеживаете один сертификат, пропустите этот шаг.
       1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}** задайте **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — **{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}** и пороги: **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}** = `14`, **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}** = `4`.

   1. Для настройки алерта о неработоспособности сертификата: {#inoperable}

       1. В запросе укажите `name = certificate.is_out_of_order`.
       1. Используйте функцию `series_sum()`, чтобы получить количество неработоспособных сертификатов. Если отслеживаете один сертификат, пропустите этот шаг.
       1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}** задайте **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — **{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}** и порог **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}** = `0`.

  1. Выберите функцию агрегации **{{ ui-key.yacloud_monitoring.alert.title_aggregation-last_non_nan }}**, чтобы проверять последнее доступное значение метрики в окне вычисления. При необходимости измените **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window-key-value }}** и **{{ ui-key.yacloud_monitoring.alert-template.field.delay-key-value }}**.

     
     Подробнее в разделе [{#T}](../../monium/concepts/alerting/alert.md#condition).


  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** выберите подготовленный канал уведомлений. В поле **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.sent-notify-statuses }}** укажите `Warning` и `Alarm` для алерта об истечении срока действия или `Alarm` для алерта о неработоспособности.
  1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

Создайте второй алерт, повторив шаги с другим вариантом настройки.
