---
title: Data plane event reference {{ at-full-name }}
description: This section provides descriptions of the data events collected in {{ yandex-cloud }} services.
---

# Data event reference

The value of the `event_type` field in a data event audit log is determined by the event source service.

The general value format is as follows:

```text
{{ at-event-prefix }}.audit.<service_name>.<event_name>
```

On this page, you will find events for the following services:

{% include [dp-events-service-list](../../_includes/audit-trails/dp-events-service-list.md) %}

## {{ alb-full-name }} {#alb}

Service name: `apploadbalancer`.

{% include [alb-events-dp](../../_includes/audit-trails/events/alb-events-dp.md) %}

## {{ certificate-manager-full-name }} {#certificate-manager}

Service name: `certificatemanager`.

{% include [certificate-manager-events-dp](../../_includes/audit-trails/events/certificate-manager-events-dp.md) %}

## {{ cloud-desktop-full-name }} {#clouddesktop}

Service name: `clouddesktop`.

{% include [clouddesktop-events-dp](../../_includes/audit-trails/events/clouddesktop-events-dp.md) %}

## {{ dns-full-name }} {#dns}

Service name: `dns`.

{% include [dns-events-dp](../../_includes/audit-trails/events/dns-events-dp.md) %}

## {{ compute-full-name }} {#compute}

Service name: `compute`.

{% include [compute-events-dp](../../_includes/audit-trails/events/compute-events-dp.md) %}

## {{ foundation-models-full-name }} {#foundation-models}

Service name: `ai.foundationmodels`.

{% include [foundation-models-dp](../../_includes/audit-trails/events/foundation-models-dp.md) %}

## {{ org-full-name }} {#organization}

Service name: `organizationmanager`.

{% include [org-events-dp](../../_includes/audit-trails/events/org-events-dp.md) %}

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

## {{ managed-k8s-full-name }} {#managed-service-for-kubernetes}

Service name: `k8s`.

{% include [managed-k8s-events-dp](../../_includes/audit-trails/events/managed-k8s-events-dp.md) %}

## {{ mmg-full-name }} {#mmg}

Service name: `mdb.mongodb`.

{% include [mmg-events-dp](../../_includes/audit-trails/events/mmg-events-dp.md) %}

## {{ mmy-full-name }} {#mmy}

Service name: `mdb.mysql`.

{% include [mmy-events-dp](../../_includes/audit-trails/events/mmy-events-dp.md) %}

## {{ mpg-full-name }} {#mpg}

Service name: `mdb.postgresql`.

{% include [mpg-events-dp](../../_includes/audit-trails/events/mpg-events-dp.md) %}

## {{ mrd-full-name }} {#mrd}

Service name: `mdb.redis`.

{% include [mrd-events-dp](../../_includes/audit-trails/events/mrd-events-dp.md) %}

## {{ objstorage-full-name }} {#objstorage}

Service name: `storage`.

{% include [storage-events-dp](../../_includes/audit-trails/events/storage-events-dp.md) %}

## {{ sd-full-name }} {#security-deck}

### {{ atr-name }} module {#sd-access-transparency}

Service name: `accesstransparency`.

{% include [sd-events-dp](../../_includes/audit-trails/events/sd-events-dp.md) %}

## {{ speechkit-full-name }} {#speechkit}

Service name: `ai.speechkit`.

{% include [speechkit-events-dp](../../_includes/audit-trails/events/speechkit-events-dp.md) %}

## {{ speechsense-full-name }} {#speechsense}

Service name: `speechsense`.

{% include [speechsense-events-dp](../../_includes/audit-trails/events/speechsense-events-dp.md) %}

## {{ sws-full-name }} {#sws}

Service name: `smartwebsecurity`.

{% include [sws-events-dp](../../_includes/audit-trails/events/sws-events-dp.md) %}

## {{ translate-full-name }} {#translate}

Service name: `ai.translate`.

{% include [translate-events-dp](../../_includes/audit-trails/events/translate-events-dp.md) %}


## {{ vision-full-name }} {#vision}

Service name: `ai.ocr`.

{% include [vision-events-dp](../../_includes/audit-trails/events/vision-events-dp.md) %}

## {{ wiki-full-name }} {#wiki}

Service name: `wiki`.

{% include [wiki-events-dp](../../_includes/audit-trails/events/wiki-events-dp.md) %}

## {{ websql-full-name }} {#websql}

Service name: `websql`.

{% include [websql-events-dp](../../_includes/audit-trails/events/websql-events-dp.md) %}