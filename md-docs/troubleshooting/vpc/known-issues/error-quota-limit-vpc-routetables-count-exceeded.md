# Устранение ошибки `Quota limit vpc.routeTables.count exceeded`


## Описание проблемы {#issue-description}

При создании нового ресурса в {{ yandex-cloud }} появляется сообщение об ошибке:

```
message: Quota limit vpc.routeTables.count exceeded; 
status: 429; description: Quota limit vpc.routeTables.count exceeded; 
code: GATEWAY_REQUEST_ERROR;
```

## Решение {#issue-resolution}

Ошибка сообщает, что [исчерпана квота](../../../vpc/concepts/limits.md#vpc-quotas) **Количество таблиц маршрутизации**. В этой ситуации возможно перераспределить маршрутные таблицы или подать заявку на увеличение квоты через [форму в Консоли управления]({{ link-console-quotas }}).