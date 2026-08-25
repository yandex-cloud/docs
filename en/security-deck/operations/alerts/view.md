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

  1. Optionally, [configure](#configure) alert display.


{% endlist %}

## Searching alerts {#search}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md) for which you want find the alerts.
  1. In the search bar, enter a part of the header or description of the alert you want to find.
  1. Optionally, [configure](#configure) how to display search results.

{% endlist %}

## Customizing alert display {#configure}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md) you want to view alerts for.
  1. Group alerts by issue or alert type. To the right of the search bar, click ![alt text](../../../_assets/console-icons/layout-split-rows.svg) and select a grouping type.
  1. Sort alerts by date or severity level. Above the filter panel, click ![alt text](../../../_assets/console-icons/bars-ascending-align-left-arrow-up.svg) and select a sorting type.
  1. To filter alerts, use the panel above the table. In drop-down lists, select the required values.

     To configure filter visibility, click ![plus](../../../_assets/console-icons/plus.svg) to the right of the filter and select the values to show or hide.
  1. Configure column visibility. Click ![gear](../../../_assets/console-icons/gear.svg) on the right side of the table header. Select the values you need and click **{{ ui-key.yacloud_org.common.apply }}**.

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

      {% note tip %}

      You can [create an exception](./work.md#create-exception) on the {{ kspm-name }} and {{ cspm-name }} alerts page.

      {% endnote %}

{% endlist %}