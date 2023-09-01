# Шифрование в {{ objstorage-name }}

При использовании сервиса [{{ objstorage-full-name }}](../../storage/) критичные данные должны быть зашифрованы.

Шифрование бакета {{ objstorage-name }} с помощью ключей [{{ kms-full-name }}](../../kms/) (server-side encryption) — рекомендуемый подход. Такое шифрование защищает от случайной или намеренной публикации содержимого бакета в интернете.

{% note alert %}

Данные в {{ objstorage-short-name }} шифруются по схеме [envelope encryption](../../kms/concepts/envelope.md). Удаление ключа равносильно потере зашифрованных им данных.

{% endnote %}

Шифрование выполняется на стороне сервера (server-side encryption) с помощью ключей, хранящихся в {{ kms-name }}. Созданный {{ kms-short-name }}-ключ указывается в настройках бакета. Этот ключ будет использоваться для шифрования всех новых объектов или при [загрузке объекта через API](../../storage/s3/api-ref/object/upload.md).

Объекты шифруются перед сохранением в бакет и расшифровываются при скачивании из него. Шифрование по умолчанию применяется ко всем новым объектам, при этом загруженные ранее — остаются без изменений.


{% include [encryption-roles](../../_includes/storage/encryption-roles.md) %}

Кроме шифрования с помощью {{ kms-name }}-ключей, вы можете использовать следующие подходы:

{% include [encryption-client-side](../../_includes/storage/encryption-client-side.md) %}


#### См. также {#see-also}

* [{#T}](../operations/buckets/encrypt.md) 
* [{#T}](../../kms/operations/key.md) 
