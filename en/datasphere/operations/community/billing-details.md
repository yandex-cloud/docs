---
title: How to view service usage details in {{ ml-platform-full-name }}
description: In this tutorial, you will learn how to view your spending details in {{ ml-platform-name }}.
---

# Viewing service usage details {{ ml-platform-name }}

You can get your {{ ml-platform-name }} usage details in the [{{ billing-name }}]({{ link-console-billing }}) interface:

1. Select the billing account linked to the {{ ml-platform-name }} community.
1. Navigate to the **{{ ui-key.yacloud_billing.billing.account.detail.tab_service}}** tab in **{{ ui-key.yacloud_billing.billing.account.switch_detail }}**.
1. In the **{{ ui-key.yacloud_billing.billing.account.detail.filter_label-services }}** field, select {{ ml-platform-name }}.
1. Go to the **{{ ui-key.yacloud_billing.billing.account.detail.tab_label}}** tab.
1. Select the preferred chart presentation parameters:
   * In the **{{ ui-key.yacloud_billing.billing.account.detail.label_title-usage-short }}** field, select a time range for the chart.
   * In the **{{ ui-key.yacloud_billing.billing.account.detail.filter_label_label-key }}** field, select the {{ ml-platform-name }} resources you want to view the details for.
   * In the **{{ ui-key.yacloud_billing.billing.account.detail.filter_label_aggregation }}** field, select the data aggregating range.
   * Configure additional filters in the **{{ ui-key.yacloud_billing.billing.account.detail.filter_label_all-filters }}** field as needed.

As soon as you change the parameters, the chart will be automatically refreshed.