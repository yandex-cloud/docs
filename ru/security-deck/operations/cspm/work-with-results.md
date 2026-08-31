---
title: Управлять результатами регулярного сканирования в {{ cspm-name }}
description: Следуя данной инструкции, вы узнаете об операциях, которые можно выполнить с результатами проверок в модуле {{ cspm-name }} сервиса {{ sd-full-name }}.
---

# Управлять результатами проверок в {{ cspm-name }}

После завершения проверки в интерфейсе доступны следующие операции с ее результатами:

* [просмотр истории](#view);
* [скачивание результатов](#download).

Результаты некоторых проверок могут быть недоступны. Подробнее читайте в разделе [Лимиты модуля {{ cspm-name }}](../../concepts/limits.md#sd-cspm-limits).

## Посмотреть результаты проверки {#view}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ ui-key.yacloud_org.ui.label_cspm_amGv8 }}**.
  1. На вкладке **{{ ui-key.yacloud_org.security.cspm.PageHeader.page_tab_title_history_4o4Hr }}** отобразится список со всеми запущенными и выполненными проверками. По каждой проверке доступны следующие данные:

     * Дата и время проверки.
     * Выявленное количество нарушенных правил.
     * Критичность обнаруженных нарушений:
       * ![cspm-rule-notice-icon](../../../_assets/security-deck/cspm-rule-notice-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_info_biSRh }};
       * ![cspm-low-severity-icon](../../../_assets/security-deck/cspm-low-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_low_tqf9A }}.
       * ![cspm-moderate-severity-icon](../../../_assets/security-deck/cspm-moderate-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_medium_8LZ4w }}.
       * ![cspm-high-severity-icon](../../../_assets/security-deck/cspm-high-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_high_cahHH }}.
       * ![alt](../../../_assets/common/no.svg) — {{ ui-key.yacloud_org.shared.components.severity_critical_uT8Xg }}.
     * Количество ресурсов, проверенных в результате платных и бесплатных проверок.
     * Статус проверки.
     * Идентификатор проверки.

   1. Чтобы посмотреть уведомления по проверкам, перейдите на вкладку **{{ ui-key.yacloud_org.security.cspm.PageHeader.page_tab_title_errors_g7fT6 }}**.

{% endlist %}

## Скачать результаты проверки {#download}

При скачивании CSV-файл с результатами проверки сохраняется локально на вашем компьютере.

{% note info %}

Файл может содержать не более 10 000 записей о найденных нарушениях.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ ui-key.yacloud_org.ui.label_cspm_amGv8 }}**.
  1. На вкладке **{{ ui-key.yacloud_org.security.cspm.PageHeader.page_tab_title_history_4o4Hr }}** справа от проверки нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/arrow-shape-down-to-line.svg) **{{ ui-key.yacloud_org.security.cspm.PageActions.action_title_download_report_pP1y8 }}**.

  Результаты последней проверки также можно получить, нажав на кнопку ![image](../../../_assets/console-icons/chevron-down.svg) **{{ ui-key.yacloud_org.common.more }}** → ![image](../../../_assets/console-icons/file-arrow-down.svg) **{{ ui-key.yacloud_org.security.cspm.PageActions.action_title_download_report_pP1y8 }}**.

  Информация об обнаруженных проблемах безопасности также отправляется в виде алертов и доступна по кнопке ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}** на панели слева.

{% endlist %}
