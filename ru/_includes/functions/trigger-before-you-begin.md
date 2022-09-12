Для создания триггера вам понадобятся:

* Функция, которую триггер будет запускать. Если у вас нет функции:

    * [Создайте функцию](../../functions/operations/function/function-create.md).
    * [Создайте версию функции](../../functions/operations/function/version-manage.md#func-version-create).

* (опционально) Очередь [Dead Letter Queue](../../functions/concepts/dlq.md), куда будут перенаправляться сообщения, которые не смогла обработать функция. Если у вас нет очереди, [создайте ее](../../message-queue/operations/message-queue-new-queue.md).

* [Сервисные аккаунты](../../iam/concepts/users/service-accounts.md) с правами на вызов функции и (опционально) запись в очередь [Dead Letter Queue](../../functions/concepts/dlq.md). Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).
