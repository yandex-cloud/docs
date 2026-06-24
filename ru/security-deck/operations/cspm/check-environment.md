---
title: Запустить проверку окружения на соответствие правилам контроля безопасности модуля {{ cspm-name }}
description: В данном разделе вы узнаете, как вручную запустить проверку окружения на соответствие правилам контроля безопасности модуля {{ cspm-name }} в {{ sd-full-name }}, а также как скачать результаты проверки в формате CSV.
---

# Проверить окружение на соответствие правилам контроля

{% include [cspm-use-in-workspaces](../../../_includes/security-deck/cspm-use-in-workspaces.md) %}

Проверка на соответствие правилам контроля безопасности модуля {{ cspm-name }} выполняется автоматически каждые 8 часов, но пользователи с [ролью](../../security/cspm-roles.md#cspm-editor) `cspm.editor` и выше могут запустить ее вручную.

{% note info %}

Разрешено не более 4 запусков ручной проверки в течение 8 часов.

{% endnote %}

Чтобы запустить проверку окружения на соответствие правилам контроля:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна выберите окружение, для которого хотите запустить проверку.
  1. На вкладке **{{ ui-key.yacloud_org.security.controls.ControlsPageLayout.configuration_w7Kw7 }}** нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.TriggeredRunsControl.action_check-environment_k3mP9 }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud_org.security.workspaces.TriggeredRunsCheckEnvironmentDialog.action_start-check_w0jM2 }}**.
  1. По завершении проверки вы сможете посмотреть результаты в таблице или получить их в формате CSV-файла. Чтобы скачать CSV-файл с результатами проверки:

     1. Нажмите кнопку ![file-arrow-down](../../../_assets/console-icons/file-arrow-down.svg) **{{ ui-key.yacloud_org.security.workspaces.TriggeredRunsControl.action_download-check-report_q7nR2 }}**.
     1. В открывшемся окне нажмите **{{ ui-key.yacloud_org.security.workspaces.DownloadCspmScanResultsDialog.action_download-file_gJ3Vh }}**.

     {% note info %}
     
     Файл может содержать не более 10 000 записей о найденных нарушениях.
     
     {% endnote %}

     Информация об обнаруженных проблемах безопасности также отправляется в виде алертов и доступна по кнопке ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}** на панели слева.

{% endlist %}
