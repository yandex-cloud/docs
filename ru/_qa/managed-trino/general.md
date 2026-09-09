#### Почему при редактировании кластера возникает ошибка `changing private access is not supported yet`? {#changing-private-access}

При изменении кластера {{ mtr-name }} вы можете получить ошибку:

```text
changing private access is not supported yet
```

Ошибка означает, что вы попытались включить или отключить [приватный доступ](../../managed-trino/concepts/network.md#private-endpoint) у существующего кластера.

{% include [unchangeable-private-access](../../_includes/managed-trino/unchangeable-private-access.md) %}

Ограничение действует во всех интерфейсах: в консоли управления, {{ yandex-cloud }} CLI, {{ TF }} и API. В API параметр `privateAccess.enabled` доступен в методе изменения кластера, но попытка задать новое значение завершится ошибкой.

Решение: создайте новый кластер {{ mtr-name }} с нужным значением параметра приватного доступа. Подробнее в разделе [{#T}](../../managed-trino/operations/cluster-create.md).

{% include [logs](../logs.md) %}