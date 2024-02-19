# Data event reference

The value of the `event_type` (_event type_) field in a data (data plane) audit log is determined by the event source service.

The general value format is as follows:

```text
{{ at-event-prefix }}.audit.<service_name>.<event_name>
```

On this page, you will find events for the following services:

* [{{ dns-name }}](#dns)
* [{{ lockbox-name }}](#lockbox)
* [{{ kms-name }}](#kms)
* [{{ objstorage-name }}](#objstorage)

## {{ dns-name }} {#dns}

Service name: `dns`.

{% include [dns-events-dp](../../_includes/audit-trails/events/dns-events-dp.md) %}

## {{ lockbox-name }} {#lockbox}

Service name: `lockbox`.

{% include [lockbox-events-dp](../../_includes/audit-trails/events/lockbox-events-dp.md) %}

## {{ kms-name }} {#kms}

Service name: `kms`.

{% include [kms-events-dp](../../_includes/audit-trails/events/kms-events-dp.md) %}

## {{ objstorage-name }} {#objstorage}

Service name: `storage`.

{% include [storage-events-dp](../../_includes/audit-trails/events/storage-events-dp.md) %}
