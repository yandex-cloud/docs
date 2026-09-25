---
title: Managing regular scan results in {{ cspm-name }}
description: Follow this guide to learn about the operations you can perform with check results in {{ sd-full-name }}'s {{ cspm-name }} module.
---

# Managing check results in {{ cspm-name }}

Once a check is complete, you can perform the following operations with its results in the interface:

* [View history](#view)
* [Download results](#download)

Results for certain checks may be unavailable. For more information, see [{{ cspm-name }} limits](../../concepts/limits.md#sd-cspm-limits).

## Viewing check results {#view}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ ui-key.yacloud_org.ui.label_cspm_amGv8 }}**.
  1. The **{{ ui-key.yacloud_org.security.cspm.PageHeader.page_tab_title_history_4o4Hr }}** tab will display a list of all active and completed checks. For each check, the following data is available:

     * Date and time of the check.
     * Number of detected violated rules.
     * Severity of detected violations:
       * ![cspm-rule-notice-icon](../../../_assets/security-deck/cspm-rule-notice-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_info_biSRh }}.
       * ![cspm-low-severity-icon](../../../_assets/security-deck/cspm-low-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_low_tqf9A }}.
       * ![cspm-moderate-severity-icon](../../../_assets/security-deck/cspm-moderate-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_medium_8LZ4w }}.
       * ![cspm-high-severity-icon](../../../_assets/security-deck/cspm-high-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_high_cahHH }}.
       * ![alt](../../../_assets/common/no.svg): {{ ui-key.yacloud_org.shared.components.severity_critical_uT8Xg }}.
     * Number of resources inspected during paid and free checks.
     * Check status.
     * Check ID.

   1. To view check notifications, go to the **{{ ui-key.yacloud_org.security.cspm.PageHeader.page_tab_title_errors_g7fT6 }}** tab.

{% endlist %}

## Downloading check results {#download}

The CSV file with check results you download is saved locally on your computer.

{% note info %}

The file can contain a maximum of 10,000 violation records.

{% endnote %}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ ui-key.yacloud_org.ui.label_cspm_amGv8 }}**.
  1. On the **{{ ui-key.yacloud_org.security.cspm.PageHeader.page_tab_title_history_4o4Hr }}** tab, click ![image](../../../_assets/console-icons/ellipsis.svg) to the right of the check and select ![image](../../../_assets/console-icons/arrow-shape-down-to-line.svg) **{{ ui-key.yacloud_org.security.cspm.PageActions.action_title_download_report_pP1y8 }}**.

  You can also get the results of the most recent check by clicking ![image](../../../_assets/console-icons/chevron-down.svg) **{{ ui-key.yacloud_org.common.more }}** → ![image](../../../_assets/console-icons/file-arrow-down.svg) **{{ ui-key.yacloud_org.security.cspm.PageActions.action_title_download_report_pP1y8 }}**.

  Information about the detected security issues is also provided in the form of alerts and available by clicking ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}** in the left-hand panel.

{% endlist %}
