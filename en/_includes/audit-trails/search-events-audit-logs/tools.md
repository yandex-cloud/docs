You can upload audit logs to a [{{ objstorage-full-name }}](../../../storage/) bucket, [{{ cloud-logging-full-name }}](../../../logging/) log group, or data stream in [{{ yds-full-name }}](../../../data-streams/).

Use [{{ cloud-logging-name }}](#tool-logging) to view logs stored in a log group, and [jq](#tool-jq) to search for events in logs stored in a bucket.

## {{ cloud-logging-name }} {#tool-logging}

Use [{{ cloud-logging-name }}](../../../logging/) to work with logs uploaded to a log group.

You can filter logs using the [filter expression language](../../../logging/concepts/filter.md) to analyze {{ yandex-cloud }} resource events.

To use {{ cloud-logging-name }}:

1. [Read logs in the log group](../../../logging/operations/read-logs.md).
1. [Filter](../../../audit-trails/tutorials/search-events-audit-logs/examples.md) the logs as needed.

## jq {#tool-jq}

Use [jq](https://jqlang.github.io/jq/) to work with logs uploaded to a bucket.

Buckets store logs as JSON files. This means you can analyze {{ yandex-cloud }} resource events by retrieving the events you need from the files using `jq` [filters](https://jqlang.github.io/jq/manual/).

To use `jq`:

1. Install and set up [s3fs](../../../storage/tools/s3fs.md) or [goofys](../../../storage/tools/goofys.md) to mount {{ objstorage-name }} buckets using [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace).

1. Mount a bucket with audit logs to your file system using [s3fs](../../../storage/tools/s3fs.md#mounting-bucket) or [goofys](../../../storage/tools/goofys.md#bucket-mounting).

1. Install [jq](https://stedolan.github.io/jq).

1. Run the [command](../../../audit-trails/tutorials/search-events-audit-logs/examples.md) with the relevant `jq` filter.

{% note info %}

Example commands for log operations use `jq` together with `find`, where `find` provides all log files from the bucket for processing.

{% endnote %}
