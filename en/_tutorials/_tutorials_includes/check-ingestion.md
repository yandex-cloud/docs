## Test sending and receiving data {#check-ingestion}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you created a data stream, transfer, and bucket.
   1. Select **{{ yds-name }}**.
   1. Select the `logs-stream` data stream.
   1. Go to the **Monitoring** tab and look at the stream activity charts.
   1. Select **{{ data-transfer-name }}**.
   1. Select `logs-transfer`.
   1. Go to the **Monitoring** tab and look at the transfer activity charts.
   1. Select **{{ objstorage-name }}**.
   1. Select `logs-bucket`.
   1. Make sure that you have objects in the bucket. Download and review the resulting log files.

{% endlist %}