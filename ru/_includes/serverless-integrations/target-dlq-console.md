(Опционально) Раскройте блок **{{ ui-key.yacloud.serverless-event-router.label_target-dead-letter-settings }}**:

1. Укажите тип обработчика `{{ message-queue-full-name }}`.
1. Выберите каталог и очередь DLQ, в которую будут перенаправляться сообщения, которые не смог обработать приемник.
1. Выберите сервисный аккаунт, которому назначена [роль](../../message-queue/security/index.md#ymq-writer) `ymq.writer` или выше на выбранную очередь DLQ, или [создайте](../../iam/operations/sa/create.md) новый.