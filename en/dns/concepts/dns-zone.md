# DNS zones

A DNS zone is a logical space that combines the domain names of your resources and stores the necessary [resource records](resource-record.md). There are [public](#public-zones) and [private](#private-zones) zones. Regardless of the type, they have a hierarchy: a zone may have one or more subzones.

You can manage the hierarchy of cloud resources and route DNS requests. For example, you can create subzones for the production and test environments and, within them, subzones for applications, DB clusters, caching servers, and more.

![image](../../_assets/dns/zones-example-2.svg "Sample DNS hierarchy")

The {{ yandex-cloud }} resource model is used to control access to zones, subzones, and resource records.
If a public zone is registered in {{ yandex-cloud }}:

* To create a subzone, you need the rights to manage the parent zone.
* To manage a subzone and its records, no rights to the parent zone are required.

This prevents the creation of subzones for the zones registered in {{ yandex-cloud }} that users don't have access to.

You can create zones and subzones in different folders. To do this, assign a user or [service account](../../iam/concepts/users/service-accounts.md) the `editor` role for the folder where the parent zone is located. For more information, see [{#T}](../security/index.md).

For instance, the `example.com.` parent zone is located in a folder named `my-folder`. If you have the rights to manage this zone, you can create the subzones `test.example.com.` and `production.example.com.` in the `my-test-folder` and `my-production-folder` folders, respectively.

## Public zones {#public-zones}

Domain names in public zones are available from the internet. If you have a registered domain, you can delegate it. To do this, specify the addresses of {{ yandex-cloud }} name servers in the `NS` records of your registrar:

* `ns1.yandexcloud.net.`
* `ns2.yandexcloud.net.`

You can't create public top-level domain (TLD) zones.

For security reasons, nested public zones can only be created by users and service accounts with the `dns.editor`, `dns.admin`, `editor`, or `admin` role in the folder where the parent public zone is located. Remember this when organizing the structure of your domain names. For more complex scenarios, contact [support](../../support/overview.md).

The service does not require confirmation of domain ownership. You can use a domain zone even if it's not registered to you. However, if its owner confirms their rights to the domain zone, you'll lose access to it. If you are the owner of the domain and the zone is already used by someone, contact [support](../../support/overview.md).

To request external domain names, use caching resolvers like unbound, dnsmasq, or systemd-resolved. They can reduce the number of queries and service usage [costs](../pricing.md).

## Internal zones {#private-zones}

Domain names from internal zones can only be used in [{{ vpc-name }}](../../vpc/) (VPC) networks specified when creating a zone. Within internal zones, you can use the entire namespace in the subnets of the selected network, including `internal.` and `.`.

{% note warning %}

A created internal zone overlaps public zones. If you create an internal zone named `yandex.com`, all `yandex.com.` subdomains in this {{ vpc-short-name }} network, which are accessible from the internet, will be inaccessible.

{% endnote %}

### Service zones {#service-zones}

Service zones can be created in {{ vpc-short-name }} networks automatically. A list of these zones depends on the address range of the subnets used. For example:

{% cut "Service zones {{ yandex-cloud }}" %}

* `.`
* `internal.`
* `10.in-addr.arpa.`
* `168.192.in-addr.arpa.`
* `16.172.in-addr.arpa.`
* `17.172.in-addr.arpa.`
* `18.172.in-addr.arpa.`
* `19.172.in-addr.arpa.`
* `20.172.in-addr.arpa.`
* `21.172.in-addr.arpa.`
* `22.172.in-addr.arpa.`
* `23.172.in-addr.arpa.`
* `24.172.in-addr.arpa.`
* `25.172.in-addr.arpa.`
* `26.172.in-addr.arpa.`
* `27.172.in-addr.arpa.`
* `28.172.in-addr.arpa.`
* `29.172.in-addr.arpa.`
* `30.172.in-addr.arpa.`
* `31.172.in-addr.arpa.`

{% endcut %}

These zones contain records with internal FQDNs of VMs and MDB database names, VM user names, and reverse records. You can't edit records that are created automatically, but you can manage records that are added manually.

To increase fault tolerance, some traffic can be routed to third-party recursive resolvers. To avoid this, contact [support](../../support/overview.md).
