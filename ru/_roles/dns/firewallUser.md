Роль `dns.firewallUser` позволяет использовать облака, каталоги и облачные сети в качестве ресурсов для DNS-фильтров, а также просматривать информацию о ресурсах и квотах сервиса Cloud DNS.

Пользователи с этой ролью могут:
* просматривать информацию о DNS-фильтрах и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* использовать [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталоги](../../resource-manager/concepts/resources-hierarchy.md#folder) и [облачные сети](../../vpc/concepts/network.md#network) в качестве ресурсов для DNS-фильтров;
* просматривать информацию о [DNS-зонах](../../dns/concepts/dns-zone.md) и назначенных правах доступа к ним;
* просматривать информацию о [квотах](../../dns/concepts/limits.md#cloud-dns-quotas) сервиса Cloud DNS;
* просматривать информацию о каталоге.

Включает разрешения, предоставляемые ролью `dns.auditor`.