## Access to DB clusters {#access}

All clusters are created inside our network that is [accessible](../../mdb/access.md#network-access) from [Yandex server networks](https://puncher.yandex-team.ru/?id=5ce6a766d89cb04f14acafb3) and by [staff developers](https://puncher.yandex-team.ru/?id=61f8da624928bbfd5d61d651).

If these rules aren't enough, request access to the `_PGAASINTERNALNETS_` macro in [Puncher](https://puncher.yandex-team.ru/) and specify the required [ports](../../mdb/access.md#network-access) in your request:

## API access {#api-access}

All [staff members](https://puncher.yandex-team.ru/?id=5c0e8b29d89cb045aacf1eb6) already have API access.

To get access from the server networks, request the following two rules:
* [Access to load balancer endpoints](https://puncher.yandex-team.ru/?create_destinations=gw.db.yandex-team.ru&create_locations=office,vpn&create_ports=443&create_protocol=tcp) in `{{ api-host-mdb }}`.
* [Load balancer network access](https://puncher.yandex-team.ru/?create_destinations=_CLOUD_L7_PROD_NETS_&create_locations=office,vpn&create_ports=3443&create_protocol=tcp).
