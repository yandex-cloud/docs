# Консистентность ключей

Методы REST API [encrypt](../../kms/api-ref/SymmetricCrypto/encrypt.md), [decrypt](../../kms/api-ref/SymmetricCrypto/decrypt.md), [reEncrypt](../../kms/api-ref/SymmetricCrypto/reEncrypt.md) для ресурса [SymmetricCrypto](../../kms/api-ref/SymmetricCrypto/index.md) и вызовы [gRPC](../../glossary/grpc) API [SymmetricCryptoService/Encrypt](../../kms/api-ref/grpc/SymmetricCrypto/encrypt.md), [SymmetricCryptoService/Decrypt](../../kms/api-ref/grpc/SymmetricCrypto/decrypt.md), [SymmetricCryptoService/ReEncrypt](../../kms/api-ref/grpc/SymmetricCrypto/reEncrypt.md) являются eventually consistent операциями. Изменения, которые они произвели, становятся видимыми с задержкой **до трех часов**.

[Eventually consistent](https://en.wikipedia.org/wiki/Eventual_consistency) операции, изменения проявляются с задержкой **до трех часов**:
* Ротация ключа (автоматическая и ручная).
* Изменение основной версии ключа.
* Изменение статуса ключа на `Inactive`.
* Запланирование уничтожения версии ключа.
* Удаление ключа.

[Strongly consistent](https://en.wikipedia.org/wiki/Strong_consistency) операции, изменения проявляются без задержки:
* Создание ключа.
* Изменение статуса ключа на `Active`.
* Отмена удаления версии ключа, запланированной на удаление (статус версии `Scheduled For Destruction`).

{% note info %}

Если вы хотите оперативно ограничить доступ к ключу, отзовите роли, необходимые для использования ключа при шифровании и расшифровании данных. Подробнее об этом читайте в разделе [{#T}](../security/index.md).

{% endnote %}

## Примеры использования {#examples}

* [{#T}](../tutorials/encrypt/cli-api.md)