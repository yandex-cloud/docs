---
title: Viewing alerts in {{ sd-full-name }}
description: In this section, you will learn how to view alerts in {{ sd-full-name }}.
---

# Viewing alerts

## Viewing general alert information {#general-info}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).

      The section that opens displays a list of [alerts](../../concepts/alerts.md).

      For each alert, the table displays the following information:

      {% note tip %}

      You can change the info columns displayed in the table. To do this, click ![gear](../../../_assets/console-icons/gear.svg) in the row with the column headers, select the columns, and click **{{ ui-key.yacloud_org.common.apply }}**.

      {% endnote %}

      * ![traffic-light](../../../_assets/console-icons/traffic-light.svg): Alert criticality level:
          * ![cspm-rule-notice-icon](../../../_assets/security-deck/cspm-rule-notice-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_info_biSRh }}
          * ![cspm-low-severity-icon](../../../_assets/security-deck/cspm-low-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_low_tqf9A }}
          * ![cspm-moderate-severity-icon](../../../_assets/security-deck/cspm-moderate-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_medium_8LZ4w }}
          * ![cspm-high-severity-icon](../../../_assets/security-deck/cspm-high-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_high_cahHH }}

      * **{{ ui-key.yacloud_org.security-center.alerts.caption_title }}**: Alert header.
      * **{{ ui-key.yacloud_org.security-center.alerts.caption_category }}**: Threat associated with the alert.
      * **{{ ui-key.yacloud_org.security-center.alerts.caption_sensor }}**: Module which sent the alert.
      * **{{ ui-key.yacloud_org.security-center.alerts.caption_status }}**: Alert status.
      * **{{ ui-key.yacloud_org.security-center.alerts.caption_classification }}**: Activity classification.
      * **{{ ui-key.yacloud_org.security-center.alerts.caption_assignee }}**: User responsible for the alert.
      * **{{ ui-key.yacloud_org.security-center.alerts.caption_created-by }}** and **{{ ui-key.yacloud_org.security-center.alerts.caption_modified-at }}**: Date and time the alert was created and last modified.
      * **{{ ui-key.yacloud_org.security-center.alerts.caption_incident }}**: Incident associated with the alert.

{% endlist %}


## Searching alerts {#search}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md) for which you want find the alerts.
  1. Click ![sliders](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud_org.security.alerts.filters-button }}** to expand the filter panel.

      For search and analysis, you can use:

      * Text search by alert headers and descriptions.
      * Visual grouping by alert type.
      * Sorting by date and criticality level.
      * Filters.

          {% note tip %}

          You can also update the displayed filters. To do this, click ![gear](../../../_assets/console-icons/plus.svg) in the filter row and select the filters.

          {% endnote %}

{% endlist %}


## Viewing detailed alert information {#detailed-info}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. To view alert details, click the table row with its name. The detailed info window that opens includes the following tabs:

      {% list tabs %}

      - {{ ui-key.yacloud_org.security-center.alerts.title_alert_overview }}

        The **{{ ui-key.yacloud_org.security-center.alerts.title_alert_overview }}** tab contains:
        * Basic information.
        * List of facts.
        * List of affected resources.

      - {{ ui-key.yacloud_org.security-center.alerts.title_alert_details }}

        The **{{ ui-key.yacloud_org.security-center.alerts.title_alert_details }}** tab displays information in JSON format, which may vary based on the threat type. For example, resource IDs and the number of detected events categorized by data type.

      - {{ ui-key.yacloud_org.security-center.alerts.title_alert_recommendations }}

        The **{{ ui-key.yacloud_org.security-center.alerts.title_alert_recommendations }}** tab contains recommendations for mitigating the threat.

      - {{ ui-key.yacloud_org.security-center.alerts.title_alert_comments }}

        The **{{ ui-key.yacloud_org.security-center.alerts.title_alert_comments }}** tab contains a discussion of the alert.

      - {{ ui-key.yacloud_org.security-center.alerts.title_alert_history }}

        The **{{ ui-key.yacloud_org.security-center.alerts.title_alert_history }}** tab contains information about changes made to the alert.

      {% endlist %}

{% endlist %}