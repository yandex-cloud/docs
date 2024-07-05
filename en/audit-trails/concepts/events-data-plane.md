# Data event reference

The value of the `event_type` field in a data event audit log is determined by the event source service.

The general value format is as follows:

```text
{{ at-event-prefix }}.audit.<service_name>.<event_name>
```

On this page, you will find events for the following services:

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

## {{ mmg-full-name }} {#mmg}

{% include [note-sending](../../_includes/audit-trails/note-sending.md) %}

Service name: `mdb.mongodb`.

{% include [mmg-events-dp](../../_includes/audit-trails/events/mmg-events-dp.md) %}

## {{ mmy-full-name }} {#mmy}

{% include [note-sending](../../_includes/audit-trails/note-sending.md) %}

Service name: `mdb.mysql`.

{% include [mmy-events-dp](../../_includes/audit-trails/events/mmy-events-dp.md) %}

## {{ mpg-full-name }} {#mpg}

{% include [note-sending](../../_includes/audit-trails/note-sending.md) %}

Service name: `mdb.postgresql`.

{% include [mpg-events-dp](../../_includes/audit-trails/events/mpg-events-dp.md) %}

## {{ objstorage-full-name }} {#objstorage}

Service name: `storage`.

{% include [storage-events-dp](../../_includes/audit-trails/events/storage-events-dp.md) %}

## {{ speechsense-full-name }} {#speechsense}

Service name: `speechsense`.

{% include [speechsense-events-dp](../../_includes/audit-trails/events/speechsense-events-dp.md) %}

## {{ wiki-full-name }} {#wiki}

Service name: `wiki`.

{% include [wiki-events-dp](../../_includes/audit-trails/events/wiki-events-dp.md) %}

