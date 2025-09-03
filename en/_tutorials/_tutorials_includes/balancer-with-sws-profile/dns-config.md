1. Add a resource [A record](../../../dns/concepts/resource-record.md#a) to your domain's public DNS zone, with values specified as follows:

    * `Record name`: Your domain's address, ending with a dot. Example: `example.com.` or `my.first.example.com.`.
    * `Value`: L7 load balancer IP address. To learn the IP address, follow [{#T}](../../../application-load-balancer/operations/application-load-balancer-get.md).

    This record will redirect the requests you get at your domain to the L7 load balancer's IP address.

    {% include [create-record-instruction-notice](../../../_includes/dns/create-record-instruction-notice.md) %}

1. {% include [limit-traffic-to-yc](../../../_includes/smartwebsecurity/limit-traffic-to-yc.md) %}