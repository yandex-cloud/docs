# Log export

{{ cdn-name }} provides CDN server request logs and, if [origin shielding](origins-shielding.md) is enabled, requests to the shielding servers.

Log export can be [enabled](../operations/resources/configure-logs.md#enabling) for a specific [CDN resource](resource.md). To export logs, you need a [bucket](../../storage/concepts/bucket.md) in {{ objstorage-full-name }}. 

{% note info %}

Do not configure an [access policy](../../storage/concepts/policy.md) that denies access to the bucket. If your access policy restricts access to the bucket, you will get the `403 Forbidden` error in response to your log export request. Even after you restore access to the bucket, logs that could not be written will not be exported.

{% endnote %}

Log export is a paid feature. See [{#T}](../pricing.md) for billing information.

{% include [logs-unload-delay](../../_includes/cdn/logs-unload-delay.md) %}

#### See also {#see-also}

* [Query log reference](../logs-ref.md)
* [Export setup guide](../operations/resources/configure-logs.md)
