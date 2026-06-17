# Шифрование в Object Storage

При использовании сервиса [Yandex Object Storage](../index.md) критичные данные должны быть зашифрованы.

Шифрование бакета Object Storage с помощью ключей [Yandex Key Management Service](../../kms/index.md) (server-side encryption) — рекомендуемый подход. Такое шифрование защищает от случайной или намеренной публикации содержимого бакета в интернете.

{% note alert %}

Данные в Object Storage шифруются по схеме [envelope encryption](../../kms/concepts/envelope.md). Удаление ключа равносильно потере зашифрованных им данных.

{% endnote %}

Шифрование выполняется на стороне сервера (server-side encryption) с помощью ключей, хранящихся в Key Management Service. Созданный KMS-ключ указывается в настройках бакета. Этот ключ будет использоваться для шифрования всех новых объектов или при [загрузке объекта через API](../s3/api-ref/object/upload.md).

Объекты шифруются перед сохранением в бакет и расшифровываются при скачивании из него. Шифрование по умолчанию применяется ко всем новым объектам, при этом загруженные ранее — остаются без изменений.


Чтобы работать с объектами в [зашифрованном](encryption.md) бакете, у пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вместе с [ролью](../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../kms/operations/key-access.md):

* `kms.keys.encrypter` — для чтения ключа, [шифрования](../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
* `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
* `kms.keys.encrypterDecrypter` — включает [разрешения](../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.

Подробнее смотрите [Сервисные роли Key Management Service](../../kms/security/index.md#service-roles).

Кроме шифрования с помощью Key Management Service-ключей, вы можете использовать следующие подходы:

* Интеграция Object Storage с сервисом Key Management Service для шифрования данных на уровне приложения (client-side encryption). Подробнее смотрите в разделе [Требования к шифрованию данных и управлению ключами и секретами](../../security/standard/encryption.md).
* Шифрование данных на уровне приложения перед отправкой их в Object Storage с помощью сторонних библиотек. При использовании сторонних библиотек и собственных способов управления ключами следует убедиться, что схема работы, используемые алгоритмы и длины ключей соответствуют требованиям регуляторов.

## Примеры использования {#examples}

* [Шифрование на стороне сервера](../tutorials/server-side-encryption.md)
* [Использование секрета Yandex Lockbox для хранения статического ключа доступа](../tutorials/static-key-in-lockbox/index.md)
* [Загрузка аудитных логов в SIEM ArcSight](../tutorials/export-logs-to-arcsight.md)
* [Загрузка аудитных логов в SIEM Splunk](../tutorials/export-logs-to-splunk.md)


#### Полезные ссылки {#see-also}

* [Шифрование бакета](../operations/buckets/encrypt.md)
* [Управление ключами](../../kms/operations/key.md)