В стоимость поддержки инфраструктуры для балансировщика с защитой от DDoS входят:

* плата за постоянно запущенные [ВМ](../../../compute/concepts/vm.md) ([тарифы {{ compute-full-name }}](../../../compute/pricing.md));
* плата за использование [публичного статического IP-адреса](../../../vpc/concepts/address.md#public-addresses) ([тарифы {{ vpc-full-name }}](../../../vpc/pricing.md));
* плата за фильтрацию входящего трафика на публичный IP-адрес с [защитой от DDoS-атак](../../../vpc/ddos-protection/index.md) ([тарифы {{ vpc-full-name }}](../../../vpc/pricing.md#prices-ddos-protection));
* плата за использование вычислительных ресурсов [L7-балансировщика](../../../application-load-balancer/concepts/index.md) ([тарифы {{ alb-name }}](../../../application-load-balancer/pricing.md)).