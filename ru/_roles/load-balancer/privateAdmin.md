Роль `load-balancer.privateAdmin` позволяет управлять внутренними сетевыми балансировщиками нагрузки и целевыми группами, а также просматривать информацию о них и об облачных сетях, подсетях, таблицах маршрутизации, шлюзах, группах безопасности и IP-адресах.

Пользователи с этой ролью могут:
* просматривать список [сетевых балансировщиков](../../network-load-balancer/concepts/index.md) и информацию о них, а также создавать внутренние сетевые балансировщики (в т.ч. с UDP-обработчиком), изменять, удалять, запускать и останавливать их;
* просматривать список [целевых групп](../../network-load-balancer/concepts/target-resources.md) и информацию о них, а также создавать, изменять, удалять и использовать целевые группы;
* просматривать список [облачных сетей](../../vpc/concepts/network.md#network) и информацию о них;
* просматривать список [подсетей](../../vpc/concepts/network.md#subnet) и информацию о них, а также использовать подсети;
* просматривать список [адресов облачных ресурсов](../../vpc/concepts/address.md) и информацию о них;
* просматривать список [таблиц маршрутизации](../../vpc/concepts/routing.md#rt-vpc) и информацию о них;
* просматривать список [групп безопасности](../../vpc/concepts/security-groups.md) и информацию о них;
* просматривать информацию о [NAT-шлюзах](../../vpc/concepts/gateways.md);
* просматривать информацию об использованных IP-адресах в подсетях, а также создавать [внутренние адреса](../../vpc/concepts/address.md#internal-addresses);
* просматривать информацию об операциях с ресурсами сервисов Virtual Private Cloud и Compute Cloud;
* просматривать список операций с ресурсами сервиса Network Load Balancer;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о квотах сервисов [Network Load Balancer](../../network-load-balancer/concepts/limits.md#load-balancer-quotas) и [Virtual Private Cloud](../../vpc/concepts/limits.md#vpc-quotas).

Включает разрешения, предоставляемые ролями `load-balancer.viewer` и `vpc.viewer`.