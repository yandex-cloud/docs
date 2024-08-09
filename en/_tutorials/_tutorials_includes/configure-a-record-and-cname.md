The tutorial below describes configuring DNS for the `example.com` domain name.

### Add a DNS zone {#create-dns-zone}

{% list tabs group=instructions %}

- Management console {#console}

   To add a [public DNS zone](../../dns/concepts/dns-zone.md#public-zones):
   1. Open the **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}** section of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you need to create a [DNS zone](../../dns/concepts/dns-zone.md).
   1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
   1. Specify the DNS zone settings:
      * **{{ ui-key.yacloud.dns.label_zone }}**: `example.com.`. You can provide you registered domain instead.
      * **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.dns.label_public }}`.
      * **{{ ui-key.yacloud.common.name }}**: `example-zone-1`.
   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Add resource records {#create-dns-records}

Create DNS records in the public zone:

{% list tabs group=instructions %}

- Management console {#console}

   1. Under **{{ ui-key.yacloud.compute.instance.overview.section_network }}** on the [VM](../../compute/concepts/vm.md) page in the [management console]({{ link-console-main }}), find the VM's [public IP address](../../vpc/concepts/address.md#public-addresses).
   1. Create an [A](../../dns/concepts/resource-record.md#a) record:
      * Open the **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}** section of the folder containing the `example.com` DNS zone.
      * Select the `example.com` DNS zone from the list.
      * Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
      * Set the record parameters:
         * **{{ ui-key.yacloud.common.name }}**: Leave empty.
         * **{{ ui-key.yacloud.common.type }}**: Keep `А` as the value.
         * **{{ ui-key.yacloud.dns.label_records }}**: Enter your VM's public address.
         * **{{ ui-key.yacloud.dns.label_form-ttl }}** (record time to live): Keep the default value.
      * Click **{{ ui-key.yacloud.common.create }}**.
   1. Create a [CNAME](../../dns/concepts/resource-record.md#cname) record:
      * Select the `example.com` DNS zone from the list.
      * Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
      * Set the record parameters:
         * **{{ ui-key.yacloud.common.name }}**: `www`.
         * **{{ ui-key.yacloud.common.type }}**: Keep `CNAME` as the value.
         * **{{ ui-key.yacloud.dns.label_records }}**: Enter `example.com`.
         * **{{ ui-key.yacloud.dns.label_form-ttl }}** (record time to live): Keep the default value.
      * Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Delegate the domain name {#delegate-domain}

Delegation is the transfer of authority from the registrar's servers to yours. For a domain, [NS](../../dns/concepts/resource-record.md#ns) resource records are created (`ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}`).

To delegate a domain, specify its DNS servers in the registrar's account.

Delegation does not take effect immediately. It usually takes up to 24 hours (86,400 seconds) for internet service providers to update records. This depends on the TTL value which specifies how long domain records are cached.

You can check domain delegation using [Whois](https://www.reg.com/whois/check_site) or the `dig` utility:

```bash
dig +short NS example.com
```

Result:

```text
ns2.{{ dns-ns-host-sld }}.
ns1.{{ dns-ns-host-sld }}.
```
