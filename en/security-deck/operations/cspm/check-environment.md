---
title: Initiating the procedure to check a workspace for compliance with security control rules of the {{ cspm-name }} module
description: Follow this guide to learn how to manually initiate the procedure to check a workspace for compliance with security control rules of the {{ cspm-name }} module in {{ sd-full-name }} and to download the results in CSV format.
---

# Checking a workspace for compliance with control rules

{% include [cspm-use-in-workspaces](../../../_includes/security-deck/cspm-use-in-workspaces.md) %}

The check for compliance with {{ cspm-name }}'s cloud configuration control rules runs automatically every eight hours; however, users with the `cspm.editor` [role](../../security/cspm-roles.md#cspm-editor) or higher can run the check manually.

{% note info %}

You can run the check manually not more than four times every eight hours.

{% endnote %}

To run a workspace check:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ ui-key.yacloud_org.ui.label_cspm_amGv8 }}**.
  1. At the top of the window, select the workspace you want to check.
  1. Click **{{ ui-key.yacloud_org.security.cspm.PageActions.action_title_check_environment_jovUa }}**.
  1. In the window that opens, click **{{ ui-key.yacloud_org.security.workspaces.TriggeredRunsCheckEnvironmentDialog.action_start-check_w0jM2 }}**.
  1. Once the check is complete, you can view the results as a table or CSV file. To download a CSV file with the results of the check:

     1. On the **{{ ui-key.yacloud_org.security.cspm.PageHeader.page_tab_title_history_4o4Hr }}** tab, click ![image](../../../_assets/console-icons/ellipsis.svg) to the right of the check and select ![image](../../../_assets/console-icons/arrow-shape-down-to-line.svg) **{{ ui-key.yacloud_org.security.cspm.PageActions.action_title_download_report_pP1y8 }}**.
     1. In the window that opens, click **{{ ui-key.yacloud_org.security.workspaces.DownloadCspmScanResultsDialog.action_download-file_gJ3Vh }}**.

     {% note info %}
     
     The file can contain a maximum of 10,000 violation records.
     
     {% endnote %}

     You can also obtain the results of the last check by clicking ![image](../../../_assets/console-icons/chevron-down.svg) **{{ ui-key.yacloud_org.common.more }}** → ![image](../../../_assets/console-icons/file-arrow-down.svg) **{{ ui-key.yacloud_org.security.cspm.PageActions.action_title_download_report_pP1y8 }}**.

  Information about the detected security issues is also provided in the form of alerts and available by clicking ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}** in the left-hand panel.

{% endlist %}
