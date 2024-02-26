# Data event reference

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

The value of the `event_type` (_event type_) field in a data (data plane) audit log is determined by the event source service.

The general value format is as follows:

```text
{{ at-event-prefix }}.audit.<service_name>.<event_name>
```

On this page, you will find events for the following services:

* [{{ dns-name }}](#dns)
* [{{ iam-name }}](#iam)
* [{{ kms-name }}](#kms)
* [{{ lockbox-name }}](#lockbox)
* [{{ mmg-name }}](#mmg)
* [{{ mmy-name }}](#mmy)
* [{{ mpg-name }}](#mpg)
* [{{ objstorage-name }}](#objstorage)

## {{ dns-name }} {#dns}

Service name: `dns`.

{% include [dns-events-dp](../../_includes/audit-trails/events/dns-events-dp.md) %}

## {{ iam-name }} {#iam}

Service name: `iam`.

{% include [iam-events-dp](../../_includes/audit-trails/events/iam-events-dp.md) %}

## {{ kms-name }} {#kms}

Service name: `kms`.

{% include [kms-events-dp](../../_includes/audit-trails/events/kms-events-dp.md) %}

## {{ lockbox-name }} {#lockbox}

Service name: `lockbox`.

{% include [lockbox-events-dp](../../_includes/audit-trails/events/lockbox-events-dp.md) %}

## {{ mmg-name }} {#mmg}

Service name: `mdb.mongodb`.

{% include [mmg-events-dp](../../_includes/audit-trails/events/mmg-events-dp.md) %}

## {{ mmy-name }} {#mmy}

Service name: `mdb.mysql`.

{% include [mmy-events-dp](../../_includes/audit-trails/events/mmy-events-dp.md) %}

## {{ mpg-name }} {#mpg}

Service name: `mdb.postgresql`.

{% include [mpg-events-dp](../../_includes/audit-trails/events/mpg-events-dp.md) %}

## {{ objstorage-name }} {#objstorage}

Service name: `storage`.

{% include [storage-events-dp](../../_includes/audit-trails/events/storage-events-dp.md) %}
