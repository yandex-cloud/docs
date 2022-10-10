Для создания триггера вам понадобятся:

* Контейнер, который триггер будет запускать. Если у вас нет контейнера:

    * [Создайте контейнер](../../serverless-containers/operations/create.md).
    * [Создайте ревизию контейнера](../../serverless-containers/operations/manage-revision.md#create).

* (опционально) Очередь [Dead Letter Queue](../../serverless-containers/concepts/dlq.md), куда будут перенаправляться сообщения, которые не смог обработать контейнер. Если у вас нет очереди, [создайте ее](../../message-queue/operations/message-queue-new-queue.md).

* [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с правами на вызов контейнера и (опционально) запись в очередь Dead Letter Queue. Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).
