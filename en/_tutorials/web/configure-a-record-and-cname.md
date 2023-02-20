The tutorial below describes configuring DNS for the `example.com` domain name.

### Add a zone

To add a public zone:

1. Open the **{{ dns-name }}** section of the folder where you need to create a [DNS zone](../../dns/concepts/dns-zone.md).
1. Click **Create zone**.
1. Specify the zone settings:
    * **Zone name**: `example-zone-1`.
    * **Zone**: `example.com`. Specify your registered domain.
    * **Type**: **Public**.
1. Click **Create**.

### Add resource records

Create DNS records in the public zone:

1. Under **Network** on the VM page in [management console]({{ link-console-main }}), find the VM's public IP address.
1. Create an [A](../../dns/concepts/resource-record.md#a) record:
    * Open the **{{ dns-name }}** section of the folder where the `example.com` zone is located.
    * Select `example.com` from the list.
    * Click **Create record**.
    * Set the record parameters:
        * **Name**: Leave empty.
        * **Record type**: Keep `A` as the value.
        * **TTL** (record time to live): Leave the default.
        * **Value**: Enter your VM's public address.
    * Click **Create**.
1. Create a [CNAME](../../dns/concepts/resource-record.md#cname) record:
    * Select `example.com` from the list.
    * Click **Create record**.
    * Set the record parameters:
        * **Name**: `www`.
        * **Record type**: Select `CNAME` as the value.
        * **TTL** (record time to live): Leave the default.
        * **Value**: Enter `example.com`.
    * Click **Create**.

### Delegate the domain name

Delegation is the transfer of authority from the registrar's servers to yours. For a domain, [NS](../../dns/concepts/resource-record.md#ns) resource records are created (`ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}`).

To delegate a domain, specify its DNS servers in the registrar's account.

Delegation does not take effect immediately. It normally takes internet service providers up to 24 hours (86400 seconds) to update records. This depends on the TTL value which determines how long domain records are cached.

You can verify domain delegation using the dig utility or the [Whois service](https://www.reg.com/whois/check_site):

```
dig +short NS example.com
```

Result:



```
ns2.{{ dns-ns-host-sld }}.
ns1.{{ dns-ns-host-sld }}.
```

