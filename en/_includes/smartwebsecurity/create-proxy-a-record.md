Add a resource [A record](../../dns/concepts/resource-record.md#a) to your domain's public DNS zone, with values specified as follows:

* **{{ ui-key.yacloud.common.name }}**: Your domain address, ending with a dot. For example: `example.com.` or `my.first.example.com.`.
* **{{ ui-key.yacloud.dns.label_records }}**: Proxy server IPv4 address you got in the previous step.

This record redirects requests coming to your domain to the proxy server IP address.

{% include [create-record-instruction-notice](../../_includes/dns/create-record-instruction-notice.md) %}