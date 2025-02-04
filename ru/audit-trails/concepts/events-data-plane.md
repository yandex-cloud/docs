---
title: Справочник событий уровня сервисов {{ at-full-name }}
description: В данном разделе приведены описания событий уровня сервисов, собираемых в сервисах {{ yandex-cloud }}.
---

# Справочник событий уровня сервисов

Значение поля `event_type` (_тип события_) аудитного лога уровня сервисов определяется сервисом-источником события.

Общий вид значения:

```text
{{ at-event-prefix }}.audit.<имя_сервиса>.<имя_события>
```

Ниже описаны события для сервисов:

* [{{ certificate-manager-full-name }}](#certificate-manager)
* [{{ dns-full-name }}](#dns)
* [{{ compute-full-name }}](#compute)
* [{{ iam-full-name }}](#iam)
* [{{ kms-full-name }}](#kms)
* [{{ lockbox-full-name }}](#lockbox)
* [{{ mch-full-name }}](#mch)
* [{{ mmg-full-name }}](#mmg)
* [{{ mmy-full-name }}](#mmy)
* [{{ mpg-full-name }}](#mpg)
* [{{ mrd-full-name }}](#mrd)
* [{{ objstorage-full-name }}](#objstorage)
* [{{ sd-full-name }}](#security-deck)
* [{{ speechsense-full-name }}](#speechsense)
* [{{ sws-full-name }}](#sws)
* [{{ wiki-full-name }}](#wiki)
* [{{ websql-full-name }}](#websql)

## {{ certificate-manager-full-name }} {#certificate-manager}

Имя сервиса — `certificatemanager`.

{% include [certificate-manager-events-dp](../../_includes/audit-trails/events/certificate-manager-events-dp.md) %}

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

## {{ mch-full-name }} {#mch}

Имя сервиса — `mdb.clickhouse`.

{% include [mch-events-dp](../../_includes/audit-trails/events/mch-events-dp.md) %}


## {{ mmg-full-name }} {#mmg}

Имя сервиса — `mdb.mongodb`.

{% include [mmg-events-dp](../../_includes/audit-trails/events/mmg-events-dp.md) %}

## {{ mmy-full-name }} {#mmy}

Имя сервиса — `mdb.mysql`.

{% include [mmy-events-dp](../../_includes/audit-trails/events/mmy-events-dp.md) %}

## {{ mpg-full-name }} {#mpg}

Имя сервиса — `mdb.postgresql`.

{% include [mpg-events-dp](../../_includes/audit-trails/events/mpg-events-dp.md) %}

## {{ mrd-full-name }} {#mrd}

Имя сервиса — `mdb.redis`.

{% include [mrd-events-dp](../../_includes/audit-trails/events/mrd-events-dp.md) %}

## {{ objstorage-full-name }} {#objstorage}

Имя сервиса — `storage`.

{% include [storage-events-dp](../../_includes/audit-trails/events/storage-events-dp.md) %}

## {{ sd-full-name }} {#security-deck}

### Модуль Access Transparency {#sd-access-transparency}

Имя сервиса — `accesstransparency`.

{% include [sd-events-dp](../../_includes/audit-trails/events/sd-events-dp.md) %}

## {{ speechsense-full-name }} {#speechsense}

Имя сервиса — `speechsense`.

{% include [speechsense-events-dp](../../_includes/audit-trails/events/speechsense-events-dp.md) %}

## {{ sws-full-name }} {#sws}

Имя сервиса — `smartwebsecurity`.

{% include [sws-events-dp](../../_includes/audit-trails/events/sws-events-dp.md) %}

## {{ wiki-full-name }} {#wiki}

Имя сервиса — `wiki`.

{% include [wiki-events-dp](../../_includes/audit-trails/events/wiki-events-dp.md) %}

## {{ websql-full-name }} {#websql}

Имя сервиса — `websql`.

{% include [websql-events-dp](../../_includes/audit-trails/events/websql-events-dp.md) %}