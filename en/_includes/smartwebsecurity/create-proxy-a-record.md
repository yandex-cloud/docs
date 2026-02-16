Add a resource [A record](../../dns/concepts/resource-record.md#a) to your domain's public DNS zone, with values specified as follows:

* `Record name`: Your domain's address, ending with a dot. Example: `example.com.` or `my.first.example.com.`.
* `Value`: Proxy server's IPv4 address you obtained in the previous step.

This record redirects requests coming to your domain to the proxy server IP address.

{% include [create-record-instruction-notice](../../_includes/dns/create-record-instruction-notice.md) %}