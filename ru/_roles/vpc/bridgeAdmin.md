Роль `vpc.bridgeAdmin` позволяет использовать подсети и управлять связностью нескольких облачных сетей. Роль также позволяет просматривать информацию об облачных сетях, подсетях, таблицах маршрутизации, шлюзах, группах безопасности и IP-адресах, а также о квотах и операциях с ресурсами сервиса.

{% cut "Пользователи с этой ролью могут:" %}

* управлять связностью нескольких облачных сетей;
* просматривать список [подсетей](../../vpc/concepts/network.md#subnet) и информацию о них, а также использовать подсети;
* просматривать список [облачных сетей](../../vpc/concepts/network.md#network) и информацию о них;
* просматривать список [адресов облачных ресурсов](../../vpc/concepts/address.md) и информацию о них;
* просматривать список [таблиц маршрутизации](../../vpc/concepts/routing.md#rt-vpc) и информацию о них;
* просматривать список [групп безопасности](../../vpc/concepts/security-groups.md) и информацию о них;
* просматривать информацию о [NAT-шлюзах](../../vpc/concepts/gateways.md);
* просматривать информацию об использованных IP-адресах в подсетях;
* просматривать информацию о [квотах](../../vpc/concepts/limits.md#vpc-quotas) сервиса Virtual Private Cloud;
* просматривать информацию об операциях с ресурсами сервиса Virtual Private Cloud;
* просматривать информацию об операциях с ресурсами сервиса Compute Cloud;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `vpc.viewer`.