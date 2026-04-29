
The `dns.admin` role enables managing {{ dns-name }} resources and access to them.

Users with this role can:
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for [DNS zones](../../dns/concepts/dns-zone.md) and DNS firewalls, as well as modify such permissions.
* View info on DNS zones, as well as create, use, modify, and delete them.
* Create nested public DNS zones.
* View info on DNS firewalls, as well as create, modify, and delete them.
* Use [clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folders](../../resource-manager/concepts/resources-hierarchy.md#folder), and [cloud networks](../../vpc/concepts/network.md#network) as resources for DNS firewalls.
* View info on [resource records](../../dns/concepts/resource-record.md), as well as create, modify, and delete them.
* View info on {{ dns-name }} [quotas](../../dns/concepts/limits.md#cloud-dns-quotas).
* View info on the relevant folder.

This role includes the `dns.editor` and `dns.firewallEditor` permissions.