{% note warning %}

Группам узлов {{ k8s }} требуется доступ в интернет для скачивания образов и компонентов.

Предоставить доступ в интернет можно следующими способами:
* Назначить каждому узлу в группе [публичный IP адрес](../../vpc/concepts/address.md#public-addresses).
* [Настроить виртуальную машину в качестве NAT-инстанса](../../tutorials/routing/nat-instance/index.md).
* [Настроить NAT-шлюз](../../vpc/operations/create-nat-gateway.md).

{% endnote %}