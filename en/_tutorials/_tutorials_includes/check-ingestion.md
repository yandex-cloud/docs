## Test sending and receiving data {#check-ingestion}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), navigate to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with the new [data stream](../../data-streams/concepts/glossary.md#stream-concepts), [transfer](../../data-transfer/concepts/index.md##transfer), and [bucket](../../storage/concepts/bucket.md).
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
   1. Select the `logs-stream` data stream.
   1. Go to the **{{ ui-key.yacloud.common.monitoring }}** tab and check the stream activity charts.
   1. Select {{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}.
   1. Select `logs-transfer`.
   1. Go to the **{{ ui-key.yacloud.common.monitoring }}** tab and check the transfer activity charts.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Select the previously created bucket.
   1. Make sure that you have objects in the bucket. Download and review the log files you got.

{% endlist %}