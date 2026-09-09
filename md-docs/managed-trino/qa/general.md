[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Trino](../index.md) > Вопросы и ответы

# Общие вопросы про Managed Service for Trino

* [Почему при редактировании кластера возникает ошибка `changing private access is not supported yet`?](#changing-private-access)

* [Я могу получить логи моей работы в сервисах?](#logs)

#### Почему при редактировании кластера возникает ошибка `changing private access is not supported yet`? {#changing-private-access}

При изменении кластера Managed Service for Trino вы можете получить ошибку:

```text
changing private access is not supported yet
```

Ошибка означает, что вы попытались включить или отключить [приватный доступ](../concepts/network.md#private-endpoint) у существующего кластера.

{% note warning %}

Включить или отключить приватный доступ можно только при создании кластера. После создания кластера изменить эту настройку нельзя.

{% endnote %}

Ограничение действует во всех интерфейсах: в консоли управления, Yandex Cloud CLI, Terraform и API. В API параметр `privateAccess.enabled` доступен в методе изменения кластера, но попытка задать новое значение завершится ошибкой.

Решение: создайте новый кластер Managed Service for Trino с нужным значением параметра приватного доступа. Подробнее в разделе [Создание кластера Trino](../operations/cluster-create.md).

#### Я могу получить логи моей работы в сервисах? {#logs}

Да, вы можете запросить информацию о работе с вашими ресурсами из логов сервисов Yandex Cloud. Для этого обратитесь в [техническую поддержку](https://center.yandex.cloud/support).