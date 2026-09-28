# Log export

{{ cdn-name }} provides CDN server request logs and, if [origin shielding](origins-shielding.md) is enabled, requests to the shielding servers.

Log export can be [enabled](../operations/resources/configure-logs.md#enabling) for a specific [CDN resource](resource.md). To export logs, you need a [bucket](../../storage/concepts/bucket.md) in {{ objstorage-full-name }}.

{% include [logs-bucket-policy](../../_includes/cdn/logs-bucket-policy.md) %}

Log export is a paid feature. See [{#T}](../pricing.md) for billing details.

{% include [logs-unload-delay](../../_includes/cdn/logs-unload-delay.md) %}

#### Useful links {#see-also}

* [Query log reference](../logs-ref.md)
* [Export setup guide](../operations/resources/configure-logs.md)
