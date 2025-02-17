{{ billing-name }} and {{ yq-name }} are integrated with each other. You can use preset queries to enable standard tasks for analyzing details of payments for resources or write custom [YQL queries](../../query/yql-tutorials/index.md).

![](../../_assets/query/billing-query.png)

{{ yq-name }} provides ready-made queries to obtain the following information:

* Consumption by month.
* Consumption in the current month broken down by service and product.
* Consumption in the current month broken down by cloud and folder.
* Top 10 most expensive resources.
* Payment for fixed consumption.
* Utilization of fixed consumption.
* Details by {{ managed-k8s-name }} cluster.

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Set up integration between {{ billing-name }} and {{ yq-name }} {#integration}

To set up integration:

1. Open the list of expense detail exports in the {{ yandex-cloud }} console.
1. Select the required details and click **{{ ui-key.yacloud_billing.billing.account.exports.button_open-yandex-query }}**.
1. When switching from {{ billing-name }} to {{ yq-full-name }} for the first time, set up integration:
   1. In the {{ yq-name }} interface, select the service account to read data from {{ objstorage-name }} in the connection creation dialog box and click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.
   1. In the {{ yq-name }} interface, check the preset parameters by clicking **{{ ui-key.yql.yq-binding-form.binding-preview.button-text }}** in the binding creation dialog. Next, click **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}** to complete the integration.
   1. After the integration is set up, you will be redirected to **{{ ui-key.yql.yq-billing.billing.title }}**.

## Query the data {#query}

To query {{ billing-name }} analytical data stored in {{ objstorage-name }}:

1. Under **{{ ui-key.yql.yq-billing.billing.title }}** in the {{ yq-name }} interface, select the required [data binding](../../query/concepts/glossary.md#binding) from the list.
1. Select a query to {{ objstorage-name }} data from the list and click **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.

You can do the following with data processing results:

* Download them through the {{ yq-full-name }} UI by clicking **Export**.
* [Save them to an {{ objstorage-name }} bucket](../../query/sources-and-sinks/object-storage-write.md).
<!-- * [Visualize them](../../query/tutorials/datalens.md) in {{ datalens-full-name }}. -->
* Get and process them via the [{{ yq-name }} HTTP API](../../query/api/index.md).

## See also {#see-also}

* [{{ objstorage-full-name }}](../../storage/)
* [{{ datalens-full-name }}](../../datalens/)
