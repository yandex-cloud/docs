---
title: How to view service usage details in {{ billing-name }}
description: Follow this guide to view service usage details.
---
# Viewing service usage details

You can view usage details for {{ yandex-cloud }} services as charts and tables in {{ billing-name }}, or check 30-day consumption in the management console.

{% note info %}

{% include [view-required-roles](../_includes/view-required-roles.md) %}

{% include [console-access-note](../_includes/console-access-roles.md) %}

{% endnote %}

To view usage details:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Select the account you want the details for.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/square-chart-column.svg) **{{ ui-key.yacloud_billing.billing.account.switch_detail }}**.
  1. Select the detail depth.

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder you want to check consumption for.
    1. In the top-right corner, click ![credit-card](../../_assets/console-icons/credit-card.svg).
    1. The widget that opens will display consumption over the last 30 days for both the cloud and the selected folder.

        {% include [hide-private-data](../_includes/billing-widget-hide-private-data.md) %}
    1. To view usage details as charts and tables in {{ billing-name }}, click **{{ ui-key.yacloud_billing_account.billing-widget.details }}**.
    1. Select the detail depth.

{% endlist %}

Depending on the selected detail depth, you will be able to view different data:

{% note info %}

By default, usage details show the cost of consumed resources. Details in consumption units are available on the **{{ ui-key.yacloud_billing.billing.account.detail.tab_product }}** tab.

{% endnote %}

{% list tabs group=details %}

- Workspaces {#instances}

  You can view the usage details for one or more clouds, [workspaces](../../organization/concepts/organization.md#service-management), and additional agreements, e.g., adjustments and [CVoS](../concepts/cvos.md).
  
  By default, the displayed information covers all clouds, workspaces, and additional agreements associated with your billing account. To filter this view, select the specific clouds, services, and additional agreements in the **{{ ui-key.yacloud_billing_account.billing-account-detail.value_empty_service_instances }}** list.
  
  Linked workspaces are displayed in [**{{ billing-name }}**]({{ link-console-billing }}) on the ![image](../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud_org.billing.account.switch_overview }}** page under **{{ ui-key.yacloud_billing.billing.account.dashboard-resources.title_section-billable }}**.

  To get usage details for selected clouds, workspaces, and additional agreements, filtered by specific products or labels, click **{{ ui-key.yacloud_billing_account.billing-account-detail.filter_label-products-all }}** or **{{ ui-key.yacloud_billing_account.billing-account-detail.filter_label-labels-all }}**, enter the values, and click **{{ ui-key.yacloud_billing.billing.account.overview.button_bind-card-apply }}**.

  {% include [usage-details-change-period](../../billing/_includes/usage-details-change-period.md) %}

  {% note info %}

  If a cloud was previously linked to another billing account, consider the period when viewing usage details: details are available to the current billing account for the time starting when the new account was linked. For usage prior to the link, details are available to the previous account.

  {% endnote %}

- Cloud folders {#folders}

  You can view usage details for one or more folders, including those in different clouds. To do this, select the relevant folders from the **{{ ui-key.yacloud_billing_account.billing-account-detail.value_empty_clouds_folders }}** list.

  To get usage details for selected folders filtered by specific products or labels, click **{{ ui-key.yacloud_billing_account.billing-account-detail.filter_label-products-all }}** or **{{ ui-key.yacloud_billing_account.billing-account-detail.filter_label-labels-all }}**, select the values.

  {% include [usage-details-change-period](../../billing/_includes/usage-details-change-period.md) %}

- Services {#services}

  You can view usage details for one or more services in different clouds and folders. To do this, select the relevant services from the **{{ ui-key.yacloud_billing_account.billing-account-detail.filter_label-services-all }}** list.

  To get usage details for specified services filtered by specific clouds and folders, select the spaces from the **{{ ui-key.yacloud_billing_account.billing-account-detail.value_empty_clouds_folders }}** list. To filter the data by products or labels, click **{{ ui-key.yacloud_billing_account.billing-account-detail.filter_label-products-all }}** or **{{ ui-key.yacloud_billing_account.billing-account-detail.filter_label-labels-all }}**, enter the values, and click **{{ ui-key.yacloud_billing.billing.account.overview.button_bind-card-apply }}**.

  {% include [usage-details-change-period](../../billing/_includes/usage-details-change-period.md) %}

- Products {#products}

  You can view usage details for one or more products in different clouds and folders. To do this, click **{{ ui-key.yacloud_billing_account.billing-account-detail.filter_label-products-all }}** and select the products and services you want to display data for. Click **{{ ui-key.yacloud_billing.billing.account.overview.button_bind-card-apply }}**.
  
  To get usage details for specified products filtered by clouds and folders, select the spaces from the **{{ ui-key.yacloud_billing_account.billing-account-detail.value_empty_clouds_folders }}** list. To filter the data by labels, click **{{ ui-key.yacloud_billing_account.billing-account-detail.filter_label-labels-all }}**, enter the values, and click **{{ ui-key.yacloud_billing.billing.account.overview.button_bind-card-apply }}**.

  {% include [usage-details-change-period](../../billing/_includes/usage-details-change-period.md) %}

- Labels {#labels}

  You can view usage details by [service resource labels](../../resource-manager/concepts/labels.md). For a label to appear in the list of label keys, [add the label](../../resource-manager/operations/manage-labels.md) to a resource. By default, the information is displayed for one label at a time. To change the label, select a new value from the **Label key** list. If there are usage details available for the selected label, the chart will display information starting from the date the label was created. Below the chart, the table will show all values corresponding to the selected label.
  
  To get usage details for the specified label, filtered by certain clouds and folders, specify the relevant spaces in the **{{ ui-key.yacloud_billing_account.billing-account-detail.value_empty_clouds_folders }}** list. To filter by products, click **{{ ui-key.yacloud_billing_account.billing-account-detail.filter_label-products-all }}**, select the values, and click **{{ ui-key.yacloud_billing.billing.account.overview.button_bind-card-apply }}**. To display results for multiple labels, click **{{ ui-key.yacloud_billing_account.billing-account-detail.filter_label-labels-all }}**, enter the values, and click **{{ ui-key.yacloud_billing.billing.account.overview.button_bind-card-apply }}**. The system will display information for the specified **Label key**.

  {% include [usage-details-change-period](../../billing/_includes/usage-details-change-period.md) %}

- Periods {#periods}
  
  {% include [usage-details-change-period](../../billing/_includes/usage-details-change-period.md) %}

  To get usage details over a specific period for certain clouds and folders, select the required spaces from the **{{ ui-key.yacloud_billing_account.billing-account-detail.value_empty_clouds_folders }}** list. To filter the data by products or labels, click **{{ ui-key.yacloud_billing_account.billing-account-detail.filter_label-products-all }}** or **{{ ui-key.yacloud_billing_account.billing-account-detail.filter_label-labels-all }}**, enter the values, and click **{{ ui-key.yacloud_billing.billing.account.overview.button_bind-card-apply }}**.

{% endlist %}

{% include [currency](../_includes/currency.md) %}


## Viewing discount details {#discount}

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}
  
  1. Next to the total discount amount, click ![image](../../_assets/console-icons/circle-question.svg).
  1. A pop-up window will display the details.
  
     * `{{ ui-key.yacloud_billing_account.billing-account-detail.label_credit-monetaryGrantCredit }}`: [Grant](../concepts/bonus-account.md) discount, including the platform introduction grant.
     * `{{ ui-key.yacloud_billing_account.billing-account-detail.label_credit-volumeIncentiveCredit }}`: Direct discount on current resource consumption, excluding long-term commitments.
     * `{{ ui-key.yacloud_billing_account.billing-account-detail.label_credit-cudCredit }}`: [Discount](../concepts/cvos.md) on service resource usage with a 6-month, 12-month, or longer commitment.
     * `Other discounts`: Other types of discounts, including discounts for consumption after the platform introduction grant expires but before switching to the paid version.

{% endlist %}


## Interpreting the chart {#graph}

The chart shows how data changed over time.
The number of details and their values depend on the selected detail depth, chart type, and filters.

You can choose how to display costs:

* **{{ ui-key.yacloud_billing.billing.account.detail.value_cost }}**: Shows the cost of consumed services before discounts. For resources within a committed volume, this value reflects the base cost.
* **{{ ui-key.yacloud_billing.billing.account.detail.label_top-total }}**: Shows the cost of consumed services after discounts. The discount for committed volume of services is applied as soon as you start consuming the resources.

There are two types of charts:

* ![image](../../_assets/billing/graph-icon.svg): Line chart
* ![image](../../_assets/billing/gistogram-icon.svg): Column chart

Hover over a line or column on the chart to bring up a tooltip with the following information:

* Date for which the current point's value is valid.
* Cost of services consumed within the space, service, or product.
* Names of the spaces, services, products, or labels.
* Total cost of consumed services.

Each space, service, product, or label is mapped to a unique color.

## Interpreting the table {#tab}

In the table, all data is presented as the total amount for the specified period (without splitting by date or cloud).

The number of columns in the table depends on the selected detail depth. See a description of columns below.

Name | Description
----- | -----
{{ ui-key.yacloud_billing.billing.account.detail.column_cloud-name }} | Name of the cloud the resources were consumed in. <br/>Shown only if you select details by cloud.
{{ ui-key.yacloud_billing.billing.account.detail.column_service }} | Name of the service the resources were consumed in. <br/>Shown only if you select details by service/product.
{{ ui-key.yacloud_billing.billing.account.detail.column_product }} | Product name. <br/>Shown only if you select details by product.
{{ ui-key.yacloud_billing.billing.account.detail.column_unit }} | Units and amount of resources consumed. <br/>Shown only if you select details by product.
{{ ui-key.yacloud_billing.billing.account.detail.column_cost }} | Cost of consumed resources before discount.
{{ ui-key.yacloud_billing.billing.account.detail.column_credit }} | Discount amount in the contract currency (excluding VAT or other taxes and fees). The discount for a committed volume of services is applied and displayed as soon as you start consuming the resources.
{{ ui-key.yacloud_billing.billing.account.detail.column_expense }} | Total cost of consumed resources after discount.


## Displaying the committed volume of services {#cvos}

When using the [committed volume of services](../concepts/cvos.md) (CVoS):

* The CVoS discount is applied and displayed as soon as you start consuming the resources.
* The CVoS cost is distributed among individual resources. The details show the base resource cost and the applied discount.
* The remaining unused CVoS is displayed separately.
* Final CVoS balances are calculated at the end of the month to make sure the reports indicate the correct amounts.
