
Роль `cloud-router.prefixEditor` позволяет управлять IP-префиксами облачных подсетей в виртуальных маршрутизаторах, а также просматривать информацию о ресурсах сервиса {{ cr-name }}.

"Пользователи с этой ролью могут:
* просматривать информацию о [виртуальных маршрутизаторах](../../cloud-router/concepts/routing-instance.md);
* добавлять, изменять и удалять [IP-префиксы](../../cloud-router/concepts/announces.md) облачных [подсетей](../../vpc/concepts/network.md#subnet) в виртуальных маршрутизаторах;
* просматривать информацию о квотах сервиса {{ cr-name }};
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `cloud-router.viewer`.