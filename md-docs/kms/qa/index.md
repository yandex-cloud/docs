[Документация Yandex Cloud](../../index.md) > [Yandex Key Management Service](../index.md) > Вопросы и ответы

# Общие вопросы про Key Management Service

#### Почему статус ключа не меняется на `Inactive`?

Изменение статуса ключа с `Active` на `Inactive` относится к [eventually consistent](../concepts/consistency.md) операциям. Изменения, вызванные такими операциями, вступают в силу с задержкой до трех часов.

#### Я могу получить логи моей работы в сервисах? {#logs}

Да, вы можете запросить информацию о работе с вашими ресурсами из логов сервисов Yandex Cloud. Для этого обратитесь в [техническую поддержку](https://center.yandex.cloud/support).