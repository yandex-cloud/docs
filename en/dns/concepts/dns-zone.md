# DNS zones

A DNS zone is a logical space with domain names of your resources. You can use DNS zones to manage the hierarchy of your cloud resources and route DNS requests. For example, you can place your test VMs in a zone named `testing.` and production VMs in a zone named `production.`. DNS zones contain [resource records](resource-record.md).

There are two types of DNS zones: public and internal.

## Public zones {#public-zones}

Domain names in public zones are available from the internet. If you have a registered domain, you can delegate it. To do this, specify the addresses of {{ yandex-cloud }} name servers from the `NS` record at your registrar:

* `ns1.yandexcloud.net.`
* `ns2.yandexcloud.net.`

You can't create public top-level domain (TLD) zones.

For security reasons, public subzones may only coexist in a single folder. Remember this when organizing the structure of your domain names. For more complex scenarios, contact support.

Currently, there is no verification of domain ownership. You can use a domain zone, but if it's not registered to you, you may lose access to it. If you notice that your domain name is taken, contact support to confirm your ownership of the domain.

## Internal zones {#private-zones}

Domain names from internal zones are only available for use in [{{ vpc-name }}](../../vpc) networks specified when creating a zone. Within internal zones, you can use the entire namespace in the subnets of the selected network, including `internal.` and `.`.

{% note warning %}

A created internal zone overlaps public zones. If you create an internal zone named `yandex.ru`, all `yandex.ru.` subdomains in this {{ vpc-short-name }} network, which are accessible from the internet, will be inaccessible.

{% endnote %}

Several internal zones are automatically created in {{ vpc-short-name }} networks:

* `.`
* `internal.`
* `10.in-addr.arpa.`

These zones contain records with internal FQDNs of VMs and MDB database names, VM user names, and reverse records. You can't edit zones that are created automatically.

To increase fault tolerance, some traffic can be routed to third-party recursive resolvers. To avoid this, contact support.

