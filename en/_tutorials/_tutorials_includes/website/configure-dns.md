{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
  1. Specify the DNS zone settings:
     * **{{ ui-key.yacloud.dns.label_zone }}**: Specify your registered domain with a trailing dot, e.g., `example.com.`.
     * **{{ ui-key.yacloud.common.type }}**: Select `{{ ui-key.yacloud.dns.label_public }}`.
     * **{{ ui-key.yacloud.common.name }}**: Enter a name for the zone, e.g., `example-zone`.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  1. Delegate your domain to {{ yandex-cloud }} servers. Do it by specifying the addresses of the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` DNS servers in your domain registrar's account.

     Delegation does not take effect immediately. It usually takes up to 24 hours for internet service providers to update records. You can check domain delegation using [Whois](https://www.reg.ru/whois/check_site) or the `dig` utility:

     ```bash
     dig +short NS example.com
     ```

     Result:

     ```text
     ns2.{{ dns-ns-host-sld }}.
     ns1.{{ dns-ns-host-sld }}.
     ```

- {{ yandex-cloud }} CLI {#cli}

  1. Create a public DNS zone:

     ```bash
     yc dns zone create \
       --name example-zone \
       --zone example.com. \
       --public-visibility
     ```

     Where `--zone` is your domain name, e.g., `example.com.`. The `--zone` parameter value must end with a trailing dot.

     Result:

     ```text
     id: dns39gihj0ef********
     folder_id: b1g681qpemb4********
     created_at: "2024-09-09T15:23:34.919887Z"
     name: example-zone
     zone: example.com.
     public_visibility: {}
     ```

     For more information about the `yc dns zone create` command, see the [CLI reference](../../../cli/cli-ref/dns/cli-ref/zone/create.md).

  1. Delegate your domain to {{ yandex-cloud }} servers. Do it by specifying the addresses of the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` DNS servers in your domain registrar's account.

     Delegation does not take effect immediately. Internet provider servers update records within 24 hours.

- API {#api}

  To create a public DNS zone, use the [create](../../../dns/api-ref/DnsZone/create.md) REST API method for the [DnsZone](../../../dns/api-ref/DnsZone/index.md) resource or the [DnsZoneService/Create](../../../dns/api-ref/grpc/DnsZone/create.md) gRPC API call.

  Delegate your domain to {{ yandex-cloud }} servers. Do it by specifying the addresses of the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` DNS servers in your domain registrar's account.

{% endlist %}