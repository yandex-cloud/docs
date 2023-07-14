For {{ yandex-cloud }} network resources, one can use two types of IP addresses:

* IP addresses of {{ yandex-cloud }} resources that are managed by users, such as {{ compute-name }} VMs and database hosts.

* IP addresses used by {{ yandex-cloud }} to run services, e.g., to write [audit logs](../../audit-trails/concepts/format.md) in {{ at-name }}.

## Service IP addresses for users

The following IP address ranges are assigned to resources that are available to users:


| IPv4 |
|--------------------|
| `31.44.8.0/21` |
| `51.250.0.0/17` |
| `62.84.112.0/20` |
| `84.201.128.0/18` |
| `84.252.128.0/20` |
| `89.169.128.0/18` |
| `130.193.32.0/19` |
| `158.160.0.0/16` |
| `178.154.192.0/18` |
| `178.170.222.0/24` |
| `185.206.164.0/22` |
| `193.32.216.0/22` |
| `217.28.224.0/20` |



For example, the resources assigned such IP address ranges are:

* {{ compute-name }} VMs
* DB hosts
* NAT instances
* {{ network-load-balancer-name }} and {{ alb-name }} load balancers

## IP addresses used by {{ yandex-cloud }}

The following IP address ranges are assigned to the resources that support {{ yandex-cloud }} operation:


| IPv6 |
|--------------------|
| `2a02:6b8::/32` |
| `2a0d:d6c0::/29` |



These IP address ranges are not available to users.
