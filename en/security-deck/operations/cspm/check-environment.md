---
title: Initiating the procedure to check a workspace for compliance with security control rules of the {{ cspm-name }} module
description: Follow this guide to learn how to manually initiate the procedure to check a workspace for compliance with security control rules of the {{ cspm-name }} module in {{ sd-full-name }} and to download the results in CSV format.
---

# Checking a workspace for compliance with control rules

{% include [note-preview](../../../_includes/note-preview.md) %}

{% include [cspm-use-in-workspaces](../../../_includes/security-deck/cspm-use-in-workspaces.md) %}

The check for compliance with security control rules of the {{ cspm-name }} module is performed automatically every eight hours; however, users with the `cspm.editor` [role](../../security/cspm-roles.md#cspm-editor) or higher can run the check manually.

{% note info %}

You can run the check manually not more than four times every eight hours.

{% endnote %}

To initiate the procedure to check a workspace for compliance with security control rules:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the workspace you want to check.
  1. In the **{{ ui-key.yacloud_org.security.controls.ControlsPageLayout.configuration_w7Kw7 }}** tab, click **{{ ui-key.yacloud_org.security.workspaces.TriggeredRunsControl.action_check-environment_k3mP9 }}**.
  1. In the window that opens, click **{{ ui-key.yacloud_org.security.workspaces.TriggeredRunsCheckEnvironmentDialog.action_start-check_w0jM2 }}**.
  1. Once the check is complete, you can view the results as a table or CSV file. To download a CSV file with the results of the check:

     1. Click ![file-arrow-down](../../../_assets/console-icons/file-arrow-down.svg) **{{ ui-key.yacloud_org.security.workspaces.TriggeredRunsControl.action_download-check-report_q7nR2 }}**.
     1. In the window that opens, click **{{ ui-key.yacloud_org.security.workspaces.DownloadCspmScanResultsDialog.action_download-file_gJ3Vh }}**.

     {% note info %}
     
     The file can contain a maximum of 10,000 violation records.
     
     {% endnote %}

     Information about the detected security issues is also provided in the form of alerts and available by clicking ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}** in the left-hand panel.

{% endlist %}
