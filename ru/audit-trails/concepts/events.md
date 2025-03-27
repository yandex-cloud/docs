---
title: Справочник событий уровня конфигурации {{ at-full-name }}
description: В данном разделе приведены описания событий уровня конфигурации, собираемых в сервисах {{ yandex-cloud }}.
---

# Справочник событий уровня конфигурации

Значение поля `event_type` (_тип события_) аудитного лога уровня конфигурации определяется сервисом-источником события.

Общий вид значения:

```text
{{ at-event-prefix }}.audit.<имя_сервиса>.<имя_события>
```

Ниже описаны события для сервисов:

{% include [cp-events-service-list](../../_includes/audit-trails/cp-events-service-list.md) %}

## {{ api-gw-full-name }} {#api-gateway}

Имя сервиса — `serverless.apigateway`.

{% include [api-gw-events](../../_includes/audit-trails/events/api-gw-events.md) %}

## {{ alb-full-name }} {#alb}

Имя сервиса — `apploadbalancer`.

{% include [alb-events](../../_includes/audit-trails/events/alb-events.md) %}

## {{ at-full-name }} {#audit-trails}

Имя сервиса — `audittrails`.

Имя события | Описание
--- | ---
`CreateTrail` | Создание трейла
`DeleteTrail` | Удаление трейла
`SetTrailAccessBindings` | Назначение прав доступа для трейла
`UpdateTrail` | Изменение трейла
`UpdateTrailAccessBindings` | Изменение прав доступа для трейла

## {{ certificate-manager-full-name }} {#certificate-manager}

Имя сервиса — `certificatemanager`.

{% include [cm-events](../../_includes/audit-trails/events/cm-events.md) %}

## {{ cloud-apps-full-name }} {#cloud-apps}

Имя сервиса — `cloudapps`.

{% include [cloud-apps-events](../../_includes/audit-trails/events/cloud-apps-events.md) %}

## {{ backup-full-name }} {#backup}

Имя сервиса — `backup`.

{% include [backup-events](../../_includes/audit-trails/events/backup-events.md) %}

## {{ billing-name }} {#billing}

Имя сервиса — `billing`.

{% include [billing-events](../../_includes/audit-trails/events/billing-events.md) %}

## {{ cdn-full-name }} {#cdn}

Имя сервиса — `cdn`.

{% include [cdn-events](../../_includes/audit-trails/events/cdn-events.md) %}

## {{ cloud-desktop-full-name }} {#clouddesktop}

Имя сервиса — `clouddesktop`.

{% include [clouddesktop-events](../../_includes/audit-trails/events/clouddesktop-events.md) %}

## {{ dns-full-name }} {#dns}

Имя сервиса — `dns`.

{% include [dns-events](../../_includes/audit-trails/events/dns-events.md) %}

## {{ sf-full-name }} {#functions}

Имя сервиса — `serverless`.

{% include [functions-events](../../_includes/audit-trails/events/functions-events.md) %}

## {{ cloud-logging-full-name }} {#cloud-logging}

Имя сервиса — `logging`.

{% include [logging-events](../../_includes/audit-trails/events/logging-events.md) %}

## {{ marketplace-full-name }} {#marketplace}

Имя сервиса — `marketplace.licensemanager`.

{% include [marketplace-events](../../_includes/audit-trails/events/marketplace-events.md) %}

## {{ org-full-name }} {#organization}

Имя сервиса — `organizationmanager`.

{% include [org-events](../../_includes/audit-trails/events/org-events.md) %}

## {{ postbox-full-name }} {#postbox}

Имя сервиса — `postbox`.

{% include [postbox-events](../../_includes/audit-trails/events/postbox-events.md) %}

## {{ cloud-registry-full-name }} {#cloud-registry}

Имя сервиса — `cloudregistry`.

{% include [cloudregistry-events](../../_includes/audit-trails/events/cloudregistry-events.md) %}

## {{ video-full-name }} {#video}

Имя сервиса — `video`.

{% include [video-events](../../_includes/audit-trails/events/video-events.md) %}

## {{ compute-full-name }} {#compute}

Имя сервиса — `compute`.

{% include [compute-events](../../_includes/audit-trails/events/compute-events.md) %}

## {{ container-registry-full-name }} {#container-registry}

Имя сервиса — `containerregistry`.

{% include [container-registry-events](../../_includes/audit-trails/events/container-registry-events.md) %}

## {{ dataproc-full-name }} {#dataproc}

Имя сервиса — `dataproc`.

{% include [dataproc-events](../../_includes/audit-trails/events/data-processing-events.md) %}

## {{ data-transfer-full-name }} {#datatransfer}

Имя сервиса — `datatransfer`.

{% include [datatransfer-events](../../_includes/audit-trails/events/datatransfer-events.md) %}

## {{ datalens-full-name }} {#datalens}

Имя сервиса — `datalens`.

{% include [datalens-events](../../_includes/audit-trails/events/datalens-events.md) %}

## {{ ml-platform-full-name }} {#datasphere}

Имя сервиса — `datasphere`.

{% include [ds-events](../../_includes/audit-trails/events/ds-events.md) %}

## {{ iam-full-name }} {#iam}

Имя сервиса — `iam`.

{% include [iam-events](../../_includes/audit-trails/events/iam-events.md) %}

## {{ iot-full-name }} {#iot}

Имя сервиса — `iot`.

{% include [iot-events](../../_includes/audit-trails/events/iot-events.md) %}

## {{ kms-full-name }} {#kms}

Имя сервиса — `kms`.

{% include [kms-events](../../_includes/audit-trails/events/kms-events.md) %}

## {{ load-testing-full-name }} {#loadtesting}

Имя сервиса — `loadtesting`.

{% include [load-testing-events](../../_includes/audit-trails/events/load-testing-events.md) %}

## {{ lockbox-full-name }} {#lockbox}

Имя сервиса — `lockbox`.

{% include [lockbox-events](../../_includes/audit-trails/events/lockbox-events.md) %}

## {{ maf-full-name }} {#managed-service-for-airflow}

Имя сервиса — `airflow`.

{% include [airflow-events](../../_includes/audit-trails/events/managed-airflow-events.md) %}

## {{ mkf-full-name }} {#managed-service-for-kafka}

Имя сервиса — `mdb.kafka`

{% include [managed-kafka-events](../../_includes/audit-trails/events/managed-kafka-events.md) %}

## {{ mch-full-name }} {#managed-service-for-clickhouse}

Имя сервиса — `mdb.clickhouse`.

{% include [mch-events](../../_includes/audit-trails/events/mch-events.md) %}


## {{ mgl-full-name }} {#managed-service-for-gitlab}

Имя сервиса — `gitlab`.

{% include [mgl-events](../../_includes/audit-trails/events/mgl-events.md) %}

## {{ mgp-full-name }} {#managed-service-for-greenplum}

Имя сервиса — `mdb.greenplum`.

{% include [mgp-events](../../_includes/audit-trails/events/managed-greenplum-events.md) %}

## {{ managed-k8s-full-name }} {#managed-service-for-kubernetes}

Имя сервиса — `k8s`.

{% include [managed-k8s-events](../../_includes/audit-trails/events/managed-k8s-events.md) %}

## {{ mmg-full-name }} {#managed-service-for-mongodb}

Имя сервиса — `mdb.mongodb`.

{% include [mongodb-events](../../_includes/audit-trails/events/mongodb-events.md) %}

## {{ mmy-full-name }} {#managed-service-for-mysql}

Имя сервиса — `mdb.mysql`.

{% include [mysql-events](../../_includes/audit-trails/events/mysql-events.md) %}

## {{ mos-full-name }} {#managed-service-for-opensearch}

Имя сервиса — `mdb.opensearch`.

{% include [mos-events](../../_includes/audit-trails/events/mos-events.md) %}

## {{ mpg-full-name }} {#managed-service-for-postgresql}

Имя сервиса — `mdb.postgresql`.

{% include [mpg-events](../../_includes/audit-trails/events/managed-postgresql-events.md) %}

## {{ mrd-full-name }} {#managed-service-for-redis}

Имя сервиса — `mdb.redis`.

{% include [mrd-events](../../_includes/audit-trails/events/mrd-events.md) %}

## {{ ydb-full-name }} {#ydb}

Имя сервиса — `ydb`.

{% include [ydb-events](../../_includes/audit-trails/events/ydb-events.md) %}

## {{ network-load-balancer-full-name }} {#network-load-balancer}

Имя сервиса — `loadbalancer`.

{% include [network-load-balancer-events](../../_includes/audit-trails/events/network-load-balancer-events.md) %}

## {{ objstorage-full-name }} {#objstorage}

Имя сервиса — `storage`.

{% include [storage-events](../../_includes/audit-trails/events/storage-events.md) %}

## {{ yq-full-name }} {#yq}

Имя сервиса — `yq`.

{% include [yq-events](../../_includes/audit-trails/events/yq-events.md) %}

## {{ resmgr-full-name }} {#resmgr}

Имя сервиса — `resourcemanager`.

{% include [resmgr-events](../../_includes/audit-trails/events/resmgr-events.md) %}

## {{ search-api-full-name }} {#searchapi}

Имя сервиса — `searchapi`.

{% include [searchapi-events](../../_includes/audit-trails/events/searchapi-events.md) %}

## {{ serverless-containers-full-name }} {#serverless-containers}

Имя сервиса — `serverless.containers`.

{% include [serverless-containers-events](../../_includes/audit-trails/events/serverless-containers-events.md) %}

## {{ captcha-full-name }} {#smartcaptcha}

Имя сервиса — `smartcaptcha`.

{% include [captcha-events](../../_includes/audit-trails/events/captcha-events.md) %}

## {{ sws-full-name }} {#smartwebsecurity}

Имя сервиса — `smartwebsecurity`.

{% include [sws-events](../../_includes/audit-trails/events/sws-events.md) %}

## {{ speechsense-full-name }} {#speechsense}

Имя сервиса — `speechsense`.

{% include [org-events](../../_includes/audit-trails/events/speechsense-events.md) %}

## {{ vpc-full-name }} {#vpc}

Имя сервиса — `network`.

{% include [vpc-events](../../_includes/audit-trails/events/vpc-events.md) %}

## {{ websql-full-name }} {#websql}

Имя сервиса — `websql`.

{% include [websql-events](../../_includes/audit-trails/events/websql-events.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
