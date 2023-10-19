## Test sending and receiving data {#check-ingestion}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you created a data stream, transfer, and bucket.
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