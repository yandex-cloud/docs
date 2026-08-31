---
title: Работать с дашбордом модуля Контроль облачной конфигурации ({{ cspm-name }}) в {{ sd-full-name }}
description: Инструкция по работе с интерфейсом модуля Контроль облачной конфигурации ({{ cspm-name }}) в {{ sd-full-name }}.
---

# Работать с дашбордом модуля {{ cspm-name }}

Для работы с дашбордом необходима роль `security-deck.viewer` или выше на каталог, в котором находятся ресурсы модуля {{ cspm-name }}.

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ ui-key.yacloud_org.ui.label_cspm_amGv8 }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).
  1. Изучите вкладку **{{ ui-key.yacloud_org.security.cspm.PageHeader.page_tab_title_overview_hvqrW }}**. На ней размещены следующие блоки:
     * **{{ ui-key.yacloud_org.security.cspm.TopAlertsWidget.card_heading_alerts_8fZB8 }}** — содержит наиболее часто встречающиеся алерты.
     * **{{ ui-key.yacloud_org.security.workspaces.RuleErrorsList.table_controls_long_e35UN }}** — содержит наиболее часто встречающиеся правила с нарушениями.
     * Список алертов с указанием типа угрозы, статуса и времени последнего обновления. В верхней части списка доступны фильтры по критичности, типам угрозы, статусу, дате создания и изменения. Также можно воспользоваться выбором приемника и сортировкой.

     Для управления проверкой доступны следующие кнопки:

     * **{{ ui-key.yacloud_org.security.cspm.PageActions.action_title_check_environment_jovUa }}** — запуск [проверки](./check-environment.md) окружения на соответствие правилам контроля.
     * ![image](../../../_assets/console-icons/chevron-down.svg) **{{ ui-key.yacloud_org.common.more }}** → ![image](../../../_assets/console-icons/file-arrow-down.svg) **{{ ui-key.yacloud_org.security.cspm.PageActions.action_title_download_report_pP1y8 }}** — [получение](./work-with-results.md#download) CSV-файла с отчетом о последней проверке.
     * ![image](../../../_assets/console-icons/chevron-down.svg) **{{ ui-key.yacloud_org.common.more }}** → ![image](../../../_assets/console-icons/file-arrow-down.svg) **{{ ui-key.yacloud_org.security.cspm.PageActions.action_title_configure_control_oGGv5 }}** — переход в [настройки окружения](../workspaces/update.md), где можно выбрать модули контроля и наборы требований, которым должны соответствовать ресурсы в окружении.

  1. Вкладка **{{ ui-key.yacloud_org.security.cspm.PageHeader.page_tab_title_history_4o4Hr }}** содержит информацию о всех выполненных проверках. Отчет о каждой проверке можно [скачать](./work-with-results.md#download).
  1. На вкладке **{{ ui-key.yacloud_org.security.cspm.PageHeader.page_tab_title_errors_g7fT6 }}** убедитесь, что все ресурсы подключены к {{ cspm-name }} и находятся в активном статусе контроля.
  1. На вкладке **{{ ui-key.yacloud_org.security.cspm.PageHeader.page_tab_title_about_fEPiv }}** можно просмотреть общую информацию о модуле {{ cspm-name }}.

{% endlist %}
