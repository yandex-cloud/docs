---
title: Monitoring DNS zones
description: In this tutorial, you will learn how to view DNS zone and query metrics.
---

# Monitoring DNS zones

{{ dns-name }} automatically sends zone and query metrics to [{{ monitoring-full-name }}](../../monitoring).

You can view the general operational statistics on the [zone page](#zone-ui) or the detailed statistics in the [{{ monium-full-name }} interface](#monitoring).

For a full list of metrics, see [this reference](../metrics.md).

## Viewing zone query statistics on the zone page {#zone-ui}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where your zone resides.
  1. [Navigate]({{ link-console-main }}/link/dns) to **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Click the zone whose statistics you want to view.
  1. Navigate to the **{{ ui-key.yacloud.common.monitoring }}** tab.
  1. Select the statistics time interval: 1 hour, 3 hours, 1 day, 1 week, or 1 month.

      You will see the **Zone requests** dashboard showing the number of incoming requests for the selected zone and time interval.

{% endlist %}

## View detailed statistics in {{ monium-full-name }} {#monitoring}

{% list tabs group=instructions %}

- Management console {#console}

  To navigate to [{{ monium-name }}]({{ link-monium }}), click **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}** ![image](../../_assets/console-icons/arrow-up-right-from-square.svg) on the zone page or proceed as follows:

  1. In the [management console]({{ link-console-main }}), select the folder containing your zone.
  1. [Navigate]({{ link-monium }}) to **{{ ui-key.yacloud.iam.folder.dashboard.label_monium }}**.
  1. In the left-hand panel, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
  1. Navigate to the **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** tab.
  1. In the list of services, click **DNS — Zone overview**.
  1. In the **DNS Zone** field, specify the zone ID.
  1. Select the statistics time interval.

{% endlist %}