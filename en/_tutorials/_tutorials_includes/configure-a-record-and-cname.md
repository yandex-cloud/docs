The tutorial below describes configuring DNS for the `example.com` domain name.

### Add a DNS zone {#create-dns-zone}

To add a [public DNS zone](../../dns/concepts/dns-zone.md#public-zones):
1. Open the **{{ dns-name }}** section of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you need to create a [DNS zone](../../dns/concepts/dns-zone.md).
1. Click **Create zone**.
1. Specify the DNS zone settings:
   * DNS zone **name**: `example-zone-1`.
   * **Zone**: `example.com.`. Specify your registered domain.
   * **Type**: **Public**.
1. Click **Create**.

### Add resource records {#create-dns-records}

Create DNS records in the public zone:
1. Under **Network** on the [VM](../../compute/concepts/vm.md) page in the [management console]({{ link-console-main }}), find the VM's [public IP address](../../vpc/concepts/address.md#public-addresses).
1. Create an [A](../../dns/concepts/resource-record.md#a) record:
   * Open the **{{ dns-name }}** section of the folder containing the `example.com` DNS zone.
   * Select the `example.com` DNS zone from the list.
   * Click **Create record**.
   * Set the record parameters:
      * **Name**: Leave empty.
      * **Record type**: Keep `A` as the value.
      * **TTL** (record time to live): Keep the default value.
      * **Value**: Enter your VM's public address.
   * Click **Create**.
1. Create a [CNAME](../../dns/concepts/resource-record.md#cname) record:
   * Select the `example.com` DNS zone from the list.
   * Click **Create record**.
   * Set the record parameters:
      * **Name**: `www`.
      * **Record type**: Select `CNAME` as the value.
      * **TTL** (record time to live): Keep the default value.
      * **Value**: Enter `example.com`.
   * Click **Create**.

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
