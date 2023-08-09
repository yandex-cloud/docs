{{ billing-name }} and {{ yq-name }} are integrated with each other. You can use preset queries to enable standard tasks for analyzing details of payments for resources or write custom [YQL queries](../yql-tutorials/index.md).

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
1. Select the required details and click **{{ ui-key.yacloud.billing.account.exports.button_open-yandex-query }}**.
1. When switching from {{ billing-name }} to {{ yq-full-name }} for the first time, set up integration:
   1. In the {{ yq-name }} interface, select the service account to be used to read data from {{ objstorage-name }} in the connection creation dialog box and click **{{ ui-key.yacloud.common.create }}**.
   1. In the {{ yq-name }} interface, check the preset parameters by clicking **Preview** in the binding creation dialog box. Next, click **{{ ui-key.yacloud.common.create }}** to complete the integration process.
   1. Once the integration settings are configured, you will be redirected to the **Billing** section automatically.

## Run a data query {#query}

To query {{ billing-name }} analytical data stored in {{ objstorage-name }}:

1. Under **Billing** in the {{ yq-name }} interface, select the [data binding](../../query/concepts/glossary.md#binding) you need from the list.
1. Select the desired query to data from {{ objstorage-name }} in the list and click **Run**.

You can do the following with data processing results:

* Download them through the {{ yq-full-name }} UI by clicking **Export**.
* [Save them to an {{ objstorage-name }} bucket](../../query/sources-and-sinks/object-storage-write.md).
<!-- * [визуализировать](../../query/tutorials/datalens.md) в {{ datalens-full-name }}; -->
* Get and process them via the [{{ yq-name }} HTTP API](../api/index.md).

## See also {#see-also}

* [{{objstorage-full-name}}](../../storage/).
* [{{datalens-full-name}}](../../datalens/).
