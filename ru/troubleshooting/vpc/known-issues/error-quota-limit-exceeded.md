# Устранение ошибки `Quota limit vpc.externalStaticAddresses.count exceeded`


## Описание проблемы {#issue-description}

При создании нового ресурса в {{ yandex-cloud }} появляется сообщение об ошибке:

```
message: Quota limit vpc.externalStaticAddresses.count exceeded; 
status: 429; description: Quota limit vpc.externalStaticAddresses.count exceeded; 
code: GATEWAY_REQUEST_ERROR; Request ID: xxxxxx-xxxx-xxxx-xxxx-xxxxxxxx; 
Trace ID: dxxxxxxxxxxxx;
```

## Решение {#issue-resolution}

Ошибка означает, что [исчерпана квота](../../../vpc/concepts/limits.md#vpc-quotas) на количество статических публичных IP-адресов в одном облаке.

Для решения проблемы необходимо подать заявку на увеличение квоты через [форму](https://console.yandex.cloud/cloud?section=quotas) или [удалите неиспользуемые IP](../../../vpc/operations/address-delete.md), если они есть. 

Также возможно уменьшить количество используемых адресов, обеспечив выход в интернет для нескольких ВМ через [NAT-инстанс](../../../tutorials/routing/nat-instance.md) или [NAT-шлюз](../../../vpc/concepts/gateways.md).
