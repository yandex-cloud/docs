## Test sending and receiving data {#check-ingestion}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing your new [data stream](../../data-streams/concepts/glossary.md#stream-concepts), [transfer](../../data-transfer/concepts/index.md##transfer), and [bucket](../../storage/concepts/bucket.md).
  1. [Navigate]({{ link-console-main }}/link/data-streams) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
  1. Select the data stream named `logs-stream`.
  1. Open the **{{ ui-key.yacloud.common.monitoring }}** tab and check the stream activity charts.
  1. [Navigate]({{ link-console-main }}/link/data-transfer) to {{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}.
  1. Select the `logs-transfer` transfer.
  1. Open the **{{ ui-key.yacloud.common.monitoring }}** tab and check the transfer activity charts.
  1. [Navigate]({{ link-console-main }}/link/storage) to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Select the previously created bucket.
  1. Make sure that you have objects in the bucket. Download and review the log files you got.

{% endlist %}