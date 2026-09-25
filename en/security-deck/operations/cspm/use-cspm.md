---
title: Working with the Cloud Security Posture Management ({{ cspm-name }}) dashboard in {{ sd-full-name }}
description: Guide on working with the Cloud Security Posture Management ({{ cspm-name }}) interface in {{ sd-name }}.
---

# Working with the {{ cspm-name }} dashboard

To work with the dashboard, you need the `security-deck.viewer` role or higher for the folder containing the {{ cspm-name }} resources.

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ ui-key.yacloud_org.ui.label_cspm_amGv8 }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. Review the **{{ ui-key.yacloud_org.security.cspm.PageHeader.page_tab_title_overview_hvqrW }}** tab. It has the following sections:
     * **{{ ui-key.yacloud_org.security.cspm.TopAlertsWidget.card_heading_alerts_8fZB8 }}**: Contains the most frequent alerts.
     * **{{ ui-key.yacloud_org.security.cspm.TopAlertsWidget.card_heading_alerts_8fZB8 }}**: Contains the most frequently violated rules.
     * List of alerts stating threat type, status, and last update time. Use filters at the top to filter alerts by severity, threat type, status, creation date, and modification date. You can also select a specific target and use sorting.

     You can use the following buttons to manage the check:

     * **{{ ui-key.yacloud_org.security.cspm.PageActions.action_title_check_environment_jovUa }}**: Initiates the procedure to [check](./check-environment.md) a workspace for compliance with security control rules
     * ![image](../../../_assets/console-icons/chevron-down.svg) **{{ ui-key.yacloud_org.common.more }}** → ![image](../../../_assets/console-icons/file-arrow-down.svg) **{{ ui-key.yacloud_org.security.cspm.PageActions.action_title_download_report_pP1y8 }}**: [Generates](./work-with-results.md#download) a CSV report file for the most recent check.
     * ![image](../../../_assets/console-icons/chevron-down.svg) **{{ ui-key.yacloud_org.common.more }}** → ![image](../../../_assets/console-icons/file-arrow-down.svg) **{{ ui-key.yacloud_org.security.cspm.PageActions.action_title_configure_control_oGGv5 }}**: Navigates to the [workspace settings](../workspaces/update.md) where you can select control modules and requirements your workspace resources should meet.

  1. The **{{ ui-key.yacloud_org.security.cspm.PageHeader.page_tab_title_history_4o4Hr }}** tab contains information about all completed checks. You can [download](./work-with-results.md#download) a report for any check.
  1. On the **{{ ui-key.yacloud_org.security-center.kspm.title_clusters }}** tab, make sure all the resources are connected to {{ cspm-name }} and have an active control status.
  1. The **{{ ui-key.yacloud_org.security.cspm.PageHeader.page_tab_title_about_fEPiv }}** tab provides general information about {{ cspm-name }}.

{% endlist %}
