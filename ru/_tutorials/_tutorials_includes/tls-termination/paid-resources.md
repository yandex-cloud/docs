В стоимость поддержки инфраструктуры для терминирования TLS-соединений входят:
* плата за постоянно запущенные [ВМ](../../../compute/concepts/vm.md) ([тарифы {{ compute-full-name }}](../../../compute/pricing.md));
* плата за использование [публичного статического IP-адреса](../../../vpc/concepts/address.md#public-addresses) ([тарифы {{ vpc-full-name }}](../../../vpc/pricing.md));
* плата за использование вычислительных ресурсов [L7-балансировщика](../../../application-load-balancer/concepts/index.md) ([тарифы {{ alb-name }}](../../../application-load-balancer/pricing.md));
* плата за публичные [DNS-запросы](../../../glossary/dns.md) и [зоны DNS](../../../dns/concepts/dns-zone.md), если вы используете [{{ dns-full-name }}](../../../dns/) ([тарифы {{ dns-name }}](../../../dns/pricing.md)).