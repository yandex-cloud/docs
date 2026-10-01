---
title: Запустить проверку окружения на соответствие правилам контроля безопасности модуля {{ cspm-name }}
description: В данном разделе вы узнаете, как вручную запустить проверку окружения на соответствие правилам контроля безопасности модуля {{ cspm-name }} в {{ sd-full-name }}, а также как скачать результаты проверки в формате CSV.
---

# Проверить окружение на соответствие правилам контроля

{% include [cspm-use-in-workspaces](../../../_includes/security-deck/cspm-use-in-workspaces.md) %}

Проверка на соответствие правилам контроля облачной конфигурации модуля {{ cspm-name }} выполняется автоматически каждые 8 часов, но пользователи с [ролью](../../security/cspm-roles.md#cspm-editor) `cspm.editor` и выше могут запустить ее вручную.

{% note info %}

Разрешено не более 4 запусков ручной проверки в течение 8 часов.

{% endnote %}

Чтобы запустить проверку окружения:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ ui-key.yacloud_org.ui.label_cspm_amGv8 }}**.
  1. В верхней части окна выберите окружение, для которого хотите запустить проверку.
  1. Нажмите кнопку **{{ ui-key.yacloud_org.security.cspm.PageActions.action_title_check_environment_jovUa }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud_org.security.workspaces.TriggeredRunsCheckEnvironmentDialog.action_start-check_w0jM2 }}**.
  1. По завершении проверки вы сможете посмотреть результаты в таблице или получить их в формате CSV-файла. Чтобы скачать CSV-файл с результатами проверки:

     1. На вкладке **{{ ui-key.yacloud_org.security.cspm.PageHeader.page_tab_title_history_4o4Hr }}** справа от проверки нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/arrow-shape-down-to-line.svg) **{{ ui-key.yacloud_org.security.cspm.PageActions.action_title_download_report_pP1y8 }}**.
     1. В открывшемся окне нажмите **{{ ui-key.yacloud_org.security.workspaces.DownloadCspmScanResultsDialog.action_download-file_gJ3Vh }}**.

     {% note info %}
     
     Файл может содержать не более 10 000 записей о найденных нарушениях.
     
     {% endnote %}

     Результаты последней проверки также можно получить, нажав на кнопку ![image](../../../_assets/console-icons/chevron-down.svg) **{{ ui-key.yacloud_org.common.more }}** → ![image](../../../_assets/console-icons/file-arrow-down.svg) **{{ ui-key.yacloud_org.security.cspm.PageActions.action_title_download_report_pP1y8 }}**.

  Информация об обнаруженных проблемах безопасности также отправляется в виде алертов и доступна по кнопке ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}** на панели слева.

{% endlist %}
