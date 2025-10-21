# Консистентность ключей

Некоторые операции являются [eventually consistent](https://en.wikipedia.org/wiki/Eventual_consistency). Изменения, которые они производят, проявляются с задержкой **до трех часов**. К таким операциям относятся:

* Ротация ключа (автоматическая и ручная).
* Изменение основной версии ключа.
* Изменение статуса ключа на `Inactive`.
* Запланирование уничтожения версии ключа.
* Удаление ключа.

Методы REST API [encrypt](../../kms/api-ref/SymmetricCrypto/encrypt.md), [decrypt](../../kms/api-ref/SymmetricCrypto/decrypt.md), [reEncrypt](../../kms/api-ref/SymmetricCrypto/reEncrypt.md) для ресурса [SymmetricCrypto](../../kms/api-ref/SymmetricCrypto/index.md) и вызовы [gRPC](../../glossary/grpc) API [SymmetricCryptoService/Encrypt](../../kms/api-ref/grpc/SymmetricCrypto/encrypt.md), [SymmetricCryptoService/Decrypt](../../kms/api-ref/grpc/SymmetricCrypto/decrypt.md), [SymmetricCryptoService/ReEncrypt](../../kms/api-ref/grpc/SymmetricCrypto/reEncrypt.md) могут «не видеть» изменения, вызванные eventually consistent операциями, в течение трех часов — например, для шифрования будет использоваться старая версия ключа, если с момента ротации прошло меньше трех часов.

[Strongly consistent](https://en.wikipedia.org/wiki/Strong_consistency) операции, изменения проявляются без задержки:
* Создание ключа.
* Изменение статуса ключа на `Active`.
* Отмена удаления версии ключа, запланированной на удаление (статус версии `Scheduled For Destruction`).

{% note info %}

Если вы хотите оперативно ограничить доступ к ключу, отзовите роли, необходимые для использования ключа при шифровании и расшифровании данных. Подробнее об этом читайте в разделе [{#T}](../security/index.md).

{% endnote %}

## Примеры использования {#examples}

* [{#T}](../tutorials/encrypt/cli-api.md)