# Processing {{ at-full-name }} audit logs

{{ at-full-name }} is a service for collecting and exporting {{ yandex-cloud }} resource audit logs to a variety of target systems, including {{ objstorage-full-name }} and {{ yds-full-name }}. {{ at-name }} and {{ yq-full-name }} are integrated with each other to enable search operations in audit logs.

![](../../_assets/query/audit-trails-query.png)

After audit logs are processed using {{ yq-name }}, you can get such information as:

* Who deleted a cloud folder.
* Who added permissions to access the {{ compute-full-name }} VM serial console.
* Who edited permissions to access an {{ objstorage-name }} bucket.
* Who was granted administrator privileges.

You can find the preset queries for these use cases in [this GitHub repository](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/_use_cases_and_searches). You can also write custom [YQL queries](../yql-tutorials/index.md).

In this use case, you will create [trails](../../audit-trails/concepts/trail.md) that will upload audit logs of all [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) resources to an {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md) and send them to a {{ yds-name }} [stream](../../data-streams/concepts/glossary.md#stream-concepts). Next, you will run analytical and streaming queries to the log data using {{ yq-name }}.

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Configure {{ at-name }} {#at-setup}

Create trails:

* [To upload folder audit logs to an {{ objstorage-name }} bucket](../../audit-trails/operations/export-folder-bucket.md).
* [To send folder audit logs to a {{ yds-name }} stream](../../audit-trails/operations/export-folder-data-streams.md).

## Set up integration between {{ at-name }} and {{ yq-name }} {#integration}

To set up integration:

1. Open the list of trails in the {{ yandex-cloud }} console.
1. Select the trail that you previously created for uploading cloud audit logs to a bucket and click **Process in YQ**.
1. When switching from {{ at-name }} to {{ yq-name }} for the first time, set up integration:
   1. In the {{ yq-name }} interface, select the service account to be used to read data from {{ objstorage-name }} in the connection creation dialog box and click **Create**.
   1. In the {{ yq-name }} interface, check the preset parameters by clicking **Preview** in the binding creation dialog box. Next, click **Create** to complete the integration process.

You will be redirected to the **Audit Trails** panel of the {{ yq-name }} interface automatically.

Perform similar actions for the previously created trail that sends data to a {{ yds-name }} stream.

## Analytical queries to data in {{ objstorage-name }}

To query {{ at-name }} analytical data stored in {{ objstorage-name }}:

1. Open the **Audit Trails** panel in the {{ yq-name }} interface, select **Analytical** as the data analysis type, and then select `audit-trails-test-object_storage` from the list of [data bindings](../../query/concepts/glossary.md#binding).
1. Select the desired query to data from {{ objstorage-name }} in the list and click **Run**.

You can do the following with analytical query results:

* Download them through the {{ yq-name }} UI by clicking **Export**.
* [Save them to an {{ objstorage-name }} bucket](../../query/sources-and-sinks/object-storage-write.md).
<!-- * [visualize](../../query/tutorials/datalens.md) в {{ datalens-full-name }}; -->
* Get and process them via the [{{ yq-name }} HTTP API](../api/index.md).

## Streaming queries to data from {{ yds-name }}

To query {{ at-name }} streaming data transferred through {{ yds-name }}:

1. Under **Audit Trails** in the **{{ yq-full-name }}** interface, select **Streaming** as the data analysis type and then select the [data binding](../../query/concepts/glossary.md#binding) you need from the list.
1. Select the desired query to data from {{ objstorage-name }} in the list and click **Run**.

You can do the following with streaming query results:

* [Send them to {{ monitoring-full-name }}](../../query/sources-and-sinks/monitoring.md) as metrics.
* [Send them to an output {{ yds-name }} stream](../../query/sources-and-sinks/data-streams-write.md) as data and then process the data using [{{ sf-full-name }} triggers](../../functions/operations/trigger/data-streams-trigger-create.md).

## See also

* [{{ objstorage-full-name }}](../../storage/).
* [{{ yds-full-name }}](../../data-streams/).
* [{{ datalens-full-name }}](../../datalens/).
