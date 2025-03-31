# Tools for working with audit logs

You can upload audit logs to a [{{ objstorage-full-name }}](../../../storage/) bucket, [{{ cloud-logging-full-name }}](../../../logging/) log group, or [{{ yds-full-name }}](../../../data-streams/) data stream.

Depending on the log location, you need to use different tools to view them and search for events:

* [{{ yq-full-name }}](#tool-query)
* [{{ cloud-logging-name }}](#tool-logging)
* [jq](#tool-jq)

## {{ yq-full-name }} {#tool-query}

Use [{{ yq-name }}](../../../query/) to work with logs uploaded to a bucket or a data stream:

* If logs reside in a bucket, you can use [analytical](../../../query/concepts/batch-processing.md) {{ yql-short-name }} queries to analyze {{ yandex-cloud }} resource events.
* If logs reside in a data stream, use [streaming](../../../query/concepts/stream-processing.md) {{ yql-short-name }} queries to analyze {{ yandex-cloud }} resource events.

To use {{ yq-full-name }}, set up a data binding based on the target object:

{% list tabs group=instructions %}

* {{ objstorage-name }} bucket {#obj-storage}

    1. Create a [service account](../../../iam/operations/sa/create.md) named `bucket-yq-sa`.
    1. [Assign](../../../iam/operations/sa/assign-role-for-sa.md) the `bucket-yq-sa` service account the `storage.viewer` role for the folder containing the bucket with logs.
    1. Create a connection.

        1. In the [management console]({{ link-console-main }}), select the folder housing the trail that delivers logs to the bucket.
        1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
        1. Select the trail that delivers logs to the bucket.
        1. Click **{{ ui-key.yacloud.audit-trails.button_process-in-yq }}**.
        1. Select **{{ ui-key.yacloud.common.resource-acl.label_service-account }}** `bucket-yq-sa`.
        1. Leave other attributes as default.
        1. Click **{{ ui-key.yacloud.common.create }}**.

    1. In the window with data binding options, click **{{ ui-key.yacloud.common.create }}**.

    1. Send the appropriate [query](../../../audit-trails/tutorials/search-events-audit-logs/examples.md).

* {{ yds-name }} data stream {#data-streams}

    1. Create a [service account](../../../iam/operations/sa/create.md) named `bucket-yq-sa`.
    1. [Assign](../../../iam/operations/sa/assign-role-for-sa.md) the `yds.editor` role to the `bucket-yq-sa` service account.
    1. [Create a connection](../../../query/operations/connection.md#create). When creating it, specify the settings for the **{{ yds-name }}** connection type.
    1. [Create federated credentials](../../../query/operations/binding.md).
    1. Send the appropriate [query](../../../audit-trails/tutorials/search-events-audit-logs/examples.md).

{% endlist %}

## {{ cloud-logging-name }} {#tool-logging}

Use [{{ cloud-logging-name }}](../../../logging/) to work with logs uploaded to a log group.

You can filter records using the [filer expression language](../../../logging/concepts/filter.md) to analyze {{ yandex-cloud }} resource events.

To use {{ cloud-logging-name }}:

1. [Read logs in the log group](../../../logging/operations/read-logs.md).
1. [Filter](../../../audit-trails/tutorials/search-events-audit-logs/examples.md) the logs as you need.

## jq {#tool-jq}

Use [jq](https://jqlang.github.io/jq/) to work with logs uploaded to a bucket.

Buckets store logs as JSON files. This means you can analyze {{ yandex-cloud }} resource events by getting the required events from the files using `jq` [filters](https://jqlang.github.io/jq/manual/).

To use `jq`:

1. Install and set up [s3fs](../../../storage/tools/s3fs.md) or [goofys](../../../storage/tools/goofys.md) to mount {{ objstorage-name }} buckets using [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace).

1. Mount a bucket with audit logs to your file system using [s3fs](../../../storage/tools/s3fs.md#mounting-bucket) or [goofys](../../../storage/tools/goofys.md#bucket-mounting).

1. Install the [jq](https://stedolan.github.io/jq) utility.

1. Run the [command](../../../audit-trails/tutorials/search-events-audit-logs/examples.md) with the relevant `jq` filter.

{% note info %}

Example commands for log operations use `jq` together with `find`, where `find` provides all log files from the bucket for processing.

{% endnote %}
