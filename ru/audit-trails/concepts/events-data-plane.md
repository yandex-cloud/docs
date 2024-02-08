# Справочник событий уровня сервисов

Значение поля `event_type` (_тип события_) аудитного лога уровня сервисов (Data Plane) определяется сервисом-источником события.

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

Общий вид значения:

```text
{{ at-event-prefix }}.audit.<имя_сервиса>.<имя_события>
```

Ниже описаны события для сервисов:

* [{{ dns-name }}](#dns)
* [{{ iam-name }}](#iam)
* [{{ kms-name }}](#kms)
* [{{ lockbox-name }}](#lockbox)
* [{{ mmg-name }}](#mmg)
* [{{ mmy-name }}](#mmy)
* [{{ mpg-name }}](#mpg)
* [{{ objstorage-name }}](#objstorage)

## {{ dns-name }} {#dns}

Имя сервиса — `dns`.

{% include [dns-events-dp](../../_includes/audit-trails/events/dns-events-dp.md) %}

## {{ iam-name }} {#iam}

Имя сервиса — `iam`.

{% include [iam-events-dp](../../_includes/audit-trails/events/iam-events-dp.md) %}

## {{ kms-name }} {#kms}

Имя сервиса — `kms`.

{% include [kms-events-dp](../../_includes/audit-trails/events/kms-events-dp.md) %}

## {{ lockbox-name }} {#lockbox}

Имя сервиса — `lockbox`.

{% include [lockbox-events-dp](../../_includes/audit-trails/events/lockbox-events-dp.md) %}

## {{ mmg-name }} {#mmg}

Имя сервиса — `mdb.mongodb`.

{% include [mmg-events-dp](../../_includes/audit-trails/events/mmg-events-dp.md) %}

## {{ mmy-name }} {#mmy}

Имя сервиса — `mdb.mysql`.

{% include [mmy-events-dp](../../_includes/audit-trails/events/mmy-events-dp.md) %}

## {{ mpg-name }} {#mpg}

Имя сервиса — `mdb.postgresql`.

{% include [mpg-events-dp](../../_includes/audit-trails/events/mpg-events-dp.md) %}

## {{ objstorage-name }} {#objstorage}

Имя сервиса — `storage`.

{% include [storage-events-dp](../../_includes/audit-trails/events/storage-events-dp.md) %}
