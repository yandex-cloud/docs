---
title: Data event reference {{ at-full-name }}
description: This section provides descriptions of the service level events collected in {{ yandex-cloud }} services.
---

# Data event reference

The value of the `event_type` field in a data event audit log is determined by the event source service.

The general value format is as follows:

```text
{{ at-event-prefix }}.audit.<service_name>.<event_name>
```

On this page, you will find events for the following services:

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
* [{{ objstorage-full-name }}](#objstorage)
* [{{ speechsense-full-name }}](#speechsense)
* [{{ sws-full-name }}](#sws)
* [{{ wiki-full-name }}](#wiki)
* [{{ websql-full-name }}](#websql)

## {{ certificate-manager-full-name }} {#certificate-manager}

Service name: `certificatemanager`.

{% include [certificate-manager-events-dp](../../_includes/audit-trails/events/certificate-manager-events-dp.md) %}

## {{ dns-full-name }} {#dns}

Service name: `dns`.

{% include [dns-events-dp](../../_includes/audit-trails/events/dns-events-dp.md) %}

## {{ compute-full-name }} {#compute}

Service name: `compute`.

{% include [compute-events-dp](../../_includes/audit-trails/events/compute-events-dp.md) %}

## {{ iam-full-name }} {#iam}

Service name: `iam`.

{% include [iam-events-dp](../../_includes/audit-trails/events/iam-events-dp.md) %}

## {{ kms-full-name }} {#kms}

Service name: `kms`.

{% include [kms-events-dp](../../_includes/audit-trails/events/kms-events-dp.md) %}

## {{ lockbox-full-name }} {#lockbox}

Service name: `lockbox`.

{% include [lockbox-events-dp](../../_includes/audit-trails/events/lockbox-events-dp.md) %}

## {{ mch-full-name }} {#mch}

Service name: `mdb.clickhouse`.

{% include [mch-events-dp](../../_includes/audit-trails/events/mch-events-dp.md) %}


## {{ mmg-full-name }} {#mmg}

Service name: `mdb.mongodb`.

{% include [mmg-events-dp](../../_includes/audit-trails/events/mmg-events-dp.md) %}

## {{ mmy-full-name }} {#mmy}

Service name: `mdb.mysql`.

{% include [mmy-events-dp](../../_includes/audit-trails/events/mmy-events-dp.md) %}

## {{ mpg-full-name }} {#mpg}

Service name: `mdb.postgresql`.

{% include [mpg-events-dp](../../_includes/audit-trails/events/mpg-events-dp.md) %}

## {{ objstorage-full-name }} {#objstorage}

Service name: `storage`.

{% include [storage-events-dp](../../_includes/audit-trails/events/storage-events-dp.md) %}

## {{ speechsense-full-name }} {#speechsense}

Service name: `speechsense`.

{% include [speechsense-events-dp](../../_includes/audit-trails/events/speechsense-events-dp.md) %}

## {{ sws-full-name }} {#sws}

Service name: `smartwebsecurity`.

{% include [sws-events-dp](../../_includes/audit-trails/events/sws-events-dp.md) %}

## {{ wiki-full-name }} {#wiki}

Service name: `wiki`.

{% include [wiki-events-dp](../../_includes/audit-trails/events/wiki-events-dp.md) %}

## {{ websql-full-name }} {#websql}

Service name: `websql`.

{% include [websql-events-dp](../../_includes/audit-trails/events/websql-events-dp.md) %}