# Справочник событий уровня сервисов

Значение поля `event_type` (_тип события_) аудитного лога уровня сервисов определяется сервисом-источником события.

Общий вид значения:

```text
{{ at-event-prefix }}.audit.<имя_сервиса>.<имя_события>
```

Ниже описаны события для сервисов:

* [{{ dns-full-name }}](#dns)
* [{{ compute-full-name }}](#compute)
* [{{ iam-full-name }}](#iam)
* [{{ kms-full-name }}](#kms)
* [{{ lockbox-full-name }}](#lockbox)
* [{{ mmg-full-name }}](#mmg)
* [{{ mmy-full-name }}](#mmy)
* [{{ mpg-full-name }}](#mpg)
* [{{ objstorage-full-name }}](#objstorage)
* [{{ speechsense-full-name }}](#speechsense)
* [{{ wiki-full-name }}](#wiki)

## {{ dns-full-name }} {#dns}

Имя сервиса — `dns`.

{% include [dns-events-dp](../../_includes/audit-trails/events/dns-events-dp.md) %}

## {{ compute-full-name }} {#compute}

Имя сервиса — `compute`.

{% include [compute-events-dp](../../_includes/audit-trails/events/compute-events-dp.md) %}

## {{ iam-full-name }} {#iam}

Имя сервиса — `iam`.

{% include [iam-events-dp](../../_includes/audit-trails/events/iam-events-dp.md) %}

## {{ kms-full-name }} {#kms}

Имя сервиса — `kms`.

{% include [kms-events-dp](../../_includes/audit-trails/events/kms-events-dp.md) %}

## {{ lockbox-full-name }} {#lockbox}

Имя сервиса — `lockbox`.

{% include [lockbox-events-dp](../../_includes/audit-trails/events/lockbox-events-dp.md) %}

## {{ mmg-full-name }} {#mmg}

{% include [note-sending](../../_includes/audit-trails/note-sending.md) %}

Имя сервиса — `mdb.mongodb`.

{% include [mmg-events-dp](../../_includes/audit-trails/events/mmg-events-dp.md) %}

## {{ mmy-full-name }} {#mmy}

{% include [note-sending](../../_includes/audit-trails/note-sending.md) %}

Имя сервиса — `mdb.mysql`.

{% include [mmy-events-dp](../../_includes/audit-trails/events/mmy-events-dp.md) %}

## {{ mpg-full-name }} {#mpg}

{% include [note-sending](../../_includes/audit-trails/note-sending.md) %}

Имя сервиса — `mdb.postgresql`.

{% include [mpg-events-dp](../../_includes/audit-trails/events/mpg-events-dp.md) %}

## {{ objstorage-full-name }} {#objstorage}

Имя сервиса — `storage`.

{% include [storage-events-dp](../../_includes/audit-trails/events/storage-events-dp.md) %}

## {{ speechsense-full-name }} {#speechsense}

Имя сервиса — `speechsense`.

{% include [speechsense-events-dp](../../_includes/audit-trails/events/speechsense-events-dp.md) %}

## {{ wiki-full-name }} {#wiki}

Имя сервиса — `wiki`.

{% include [wiki-events-dp](../../_includes/audit-trails/events/wiki-events-dp.md) %}

