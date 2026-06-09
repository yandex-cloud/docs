# Шифрование в {{ objstorage-name }}

При использовании сервиса [{{ objstorage-full-name }}](../index.md) критичные данные должны быть зашифрованы.

Шифрование бакета {{ objstorage-name }} с помощью ключей [{{ kms-full-name }}](../../kms/index.md) (server-side encryption) — рекомендуемый подход. Такое шифрование защищает от случайной или намеренной публикации содержимого бакета в интернете.

{% note alert %}

Данные в {{ objstorage-short-name }} шифруются по схеме [envelope encryption](../../kms/concepts/envelope.md). Удаление ключа равносильно потере зашифрованных им данных.

{% endnote %}

Шифрование выполняется на стороне сервера (server-side encryption) с помощью ключей, хранящихся в {{ kms-name }}. Созданный {{ kms-short-name }}-ключ указывается в настройках бакета. Этот ключ будет использоваться для шифрования всех новых объектов или при [загрузке объекта через API](../s3/api-ref/object/upload.md).

Объекты шифруются перед сохранением в бакет и расшифровываются при скачивании из него. Шифрование по умолчанию применяется ко всем новым объектам, при этом загруженные ранее — остаются без изменений.


Чтобы работать с объектами в [зашифрованном](encryption.md) бакете, у пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вместе с [ролью](../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../kms/operations/key-access.md):

* `kms.keys.encrypter` — для чтения ключа, [шифрования](../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
* `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
* `kms.keys.encrypterDecrypter` — включает [разрешения](../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.

Подробнее см. [Сервисные роли {{ kms-name }}](../../kms/security/index.md#service-roles).

Кроме шифрования с помощью {{ kms-name }}-ключей, вы можете использовать следующие подходы:

* Интеграция {{ objstorage-name }} с сервисом {{ kms-name }} для шифрования данных на уровне приложения (client-side encryption). Подробнее смотрите в разделе [{#T}](../../security/standard/encryption.md).
* Шифрование данных на уровне приложения перед отправкой их в {{ objstorage-name }} с помощью сторонних библиотек. При использовании сторонних библиотек и собственных способов управления ключами следует убедиться, что схема работы, используемые алгоритмы и длины ключей соответствуют требованиям регуляторов.

## Примеры использования {#examples}

* [{#T}](../tutorials/server-side-encryption.md)
* [{#T}](../tutorials/static-key-in-lockbox/index.md)
* [{#T}](../tutorials/export-logs-to-arcsight.md)
* [{#T}](../tutorials/export-logs-to-splunk.md)


#### См. также {#see-also}

* [{#T}](../operations/buckets/encrypt.md)
* [{#T}](../../kms/operations/key.md)