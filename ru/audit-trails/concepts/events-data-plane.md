# Справочник событий уровня сервисов

Значение поля `event_type` (_тип события_) аудитного лога уровня сервисов (Data Plane) определяется сервисом-источником события.

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

Общий вид значения:

```text
{{ at-event-prefix }}.audit.<имя_сервиса>.<имя_события>
```

Ниже описаны события для сервисов:

* [{{ dns-name }}](#dns)
* [{{ lockbox-name }}](#lockbox)
* [{{ kms-name }}](#kms)
* [{{ objstorage-name }}](#objstorage)

## {{ dns-name }} {#dns}

Имя сервиса — `dns`.

{% include [dns-events-dp](../../_includes/audit-trails/events/dns-events-dp.md) %}

## {{ lockbox-name }} {#lockbox}

Имя сервиса — `lockbox`.

Имя события | Описание
--- | ---
`GetPayload` | Факт доступа к содержимому секрета

## {{ kms-name }} {#kms}

Имя сервиса — `kms`.

Имя события | Описание
--- | ---
`Decrypt` | Расшифрование шифртекста с помощью ключа
`Encrypt` | Шифрование тестовой строки с помощью ключа
`GenerateDataKey` | Формирование ключа с высокой энтропией для шифрования по схеме Envelope Encryption
`ReEncrypt` | Расшифрование шифртекста ключом с предыдущей версией и шифрование расшифрованного текста новой версией этого же ключа

## {{ objstorage-name }} {#objstorage}

Имя сервиса — `storage`.

{% include [storage-events-dp](../../_includes/audit-trails/events/storage-events-dp.md) %}
