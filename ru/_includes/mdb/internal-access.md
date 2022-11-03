## Доступ к кластерам БД {#access}

Все кластеры создаются внутри нашей сети, куда уже [есть доступ](../../mdb/access.md#network-access) из [серверных сетей Яндекса](https://puncher.yandex-team.ru/?id=5ce6a766d89cb04f14acafb3) и [от штатных разработчиков](https://puncher.yandex-team.ru/?id=61f8da624928bbfd5d61d651).

Если этих правил не хватает, запросите доступ в [Панчере](https://puncher.yandex-team.ru/) к макросу `_PGAASINTERNALNETS_` и укажите в заявке нужные [порты](../../mdb/access.md#network-access).

## Доступ к API {#api-access}

Доступ к API уже есть у всех [штатных сотрудников](https://puncher.yandex-team.ru/?id=5c0e8b29d89cb045aacf1eb6).

Для доступа из серверных сетей нужно заказать два правила:
* [Доступ до балансера](https://puncher.yandex-team.ru/?create_destinations=gw.db.yandex-team.ru&create_locations=office,vpn&create_ports=443&create_protocol=tcp) `{{ api-host-mdb }}`.
* [Доступ до реалов балансера](https://puncher.yandex-team.ru/?create_destinations=_CLOUD_L7_PROD_NETS_&create_locations=office,vpn&create_ports=3443&create_protocol=tcp).

