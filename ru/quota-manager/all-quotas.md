---
title: Список квот в сервисах {{ yandex-cloud }}
description: Во многих сервисах {{ yandex-cloud }} действуют мягкие ограничения на ресурсы — квоты. Посмотреть значение квоты и создать запрос на ее изменение можно по идентификатору квоты, указанному в этом разделе
---

# Квоты для сервисов {{ yandex-cloud }}

Сервис {{ quota-manager-name }} позволяет управлять квотами ваших сервисов {{ yandex-cloud }} с помощью различных интерфейсов. 

В этом разделе собраны квоты для сервисов, которые доступны в {{ quota-manager-short-name }}. В таблице с квотами приведены названия и идентификаторы, которые позволяют управлять квотами через {{ quota-manager-short-name }}. Если идентификатор не указан, квота недоступна для просмотра и изменения через {{ quota-manager-short-name }}.

Для квот приведены значения по умолчанию, которые совпадают с квотами на время [пробного периода](../getting-started/free-trial/concepts/quickstart.md). Ограничения действуют на ресурсы всего [облака](../resource-manager/concepts/resources-hierarchy.md#cloud), если не указано иное.

## {{ api-gw-full-name }} {#api-gw}

Для сервисов {{ api-gw-name }}, {{ sf-name }} и {{ serverless-containers-name }} действует общая квота — `Количество триггеров в одном облаке` (`serverless.triggers.count`). Квота находится в списке квот сервиса [{{ sf-name }}](#sf).

## {{ alb-full-name }} {#alb}

Сервис — `alb`, тип ресурса — `resource-manager.cloud`.

{% include notitle [alb-quotas](../_includes/application-load-balancer/alb-limits.md#quotas) %}

## {{ at-full-name }} {#at}

Сервис — `audit-trails`, тип ресурса — `resource-manager.cloud`.

{% include notitle [alb-quotas](../_includes/audit-trails-limits.md#audit-trails-quotas) %}

## {{ baremetal-full-name }} {#baremetal}

Сервис — `baremetal`, тип ресурса — `resource-manager.cloud`.

{% include notitle [baremetal-quotas](../_includes/baremetal-limits.md#baremetal-quotas) %}

## {{ certificate-manager-full-name }} {#certificate-manager}

Сервис — `certificate-manager`, тип ресурса — `resource-manager.cloud`.

{% include notitle [certificate-manager-quotas](../_includes/certificate-manager/certificate-manager-limits.md#certificate-manager-quotas) %}

## {{ backup-full-name }} {#backup}

Сервис — `backup`, тип ресурса — `resource-manager.cloud`.

{% include notitle [backup-quotas](../_includes/backup-limits.md#backup-quotas) %}

## {{ cdn-full-name }} {#cdn}

Сервис — `cdn`, тип ресурса — `resource-manager.cloud`.

{% include notitle [cdn-quotas](../_includes/cdn/limits.md#cdn-quotas) %}

## {{ cloud-desktop-full-name }} {#cloud-desktop}

Сервис — `cloud-desktop`, тип ресурса — `resource-manager.cloud`.

{% include notitle [cloud-desktop-quotas](../_includes/cloud-desktop/limits.md#quotas) %}

## {{ dns-full-name }} {#dns}

Сервис — `dns`, тип ресурса — `resource-manager.cloud`.

{% include notitle [dns-quotas](../_includes/cloud-dns-limits.md#cloud-dns-quotas) %}

## {{ sf-full-name }} {#sf}

Сервис — `serverless-functions`, тип ресурса — `resource-manager.cloud`.

{% include notitle [functions-quotas](../_includes/functions-limits.md#functions-quotas) %}

## {{ cloud-logging-full-name }} {#logging}

Сервис — `logging`, тип ресурса — `resource-manager.cloud`.

{% include notitle [logging-quotas](../_includes/logging/logging-limits.md#logging-quotas) %}


## {{ postbox-full-name }} {#postbox}

Сервис — `postbox`, тип ресурса — `resource-manager.cloud`.

{% include notitle [postbox-quotas](../_includes/postbox/postbox-limits.md#postbox-quotas) %}

## {{ compute-full-name }} {#compute}

Сервис — `compute`, тип ресурса — `resource-manager.cloud`.

{% include notitle [compute-quotas](../_includes/compute-limits.md#compute-quotas) %}

## {{ container-registry-full-name }} {#container-registry}

Сервис — `container-registry`, тип ресурса — `resource-manager.cloud`.

{% include notitle [container-registry-quotas](../_includes/container-registry-limits.md#container-registry-quotas) %}


## {{ dataproc-full-name }} {#dataproc}

{% include notitle [data-processing-quotas](../_includes/data-processing/data-processing-limits.md#dataproc-quotas) %}


## {{ data-transfer-full-name }} {#data-transfer}

Сервис — `data-transfer`, тип ресурса — `resource-manager.cloud`.

{% include notitle [data-transfer-quotas](../_includes/data-transfer/data-transfer-limits.md#dataproc-quotas) %}

## {{ iam-full-name }} {#iam}

Сервис — `iam`, тип ресурса — `resource-manager.cloud`.

{% include notitle [iam-quotas](../_includes/iam/iam-limits.md#iam-quotas) %}

## {{ org-full-name }} {#organization}

Сервис — `organization-manager`, тип ресурса — `organization-manager.organization`.

{% include notitle [org-quotas](../_includes/organization/org-limits.md#organization-quotas) %}

## {{ iot-full-name }} {#iot}

Сервис — `iot`, тип ресурса — `resource-manager.cloud`.

{% include notitle [iot-quotas](../_includes/iot-limits.md#iot-quotas) %}

## {{ kms-full-name }} {#kms}

Сервис — `kms`, тип ресурса — `resource-manager.cloud`.

{% include notitle [kms-quotas](../_includes/kms/kms-limits.md#kms-quotas) %}

## {{ load-testing-full-name }} {#load-testing}


Потребление вычислительных ресурсов [агентами](../load-testing/concepts/agent.md) учитывается в квотах сервиса [{{ compute-full-name }}](#compute).

## {{ lockbox-name }} {#lockbox}

Сервис — `lockbox`, тип ресурса — `resource-manager.cloud`.

{% include notitle [lockbox-quotas](../_includes/lockbox-limits.md#quotas) %}

## {{ maf-full-name }} {#airflow}

Сервис — `managed-airflow`, тип ресурса — `resource-manager.cloud`.

{% include notitle [airflow-quotas](../_includes/mdb/maf/limits.md#quotas) %}

## {{ mkf-full-name }} {#mkf}

Сервис — `mdb`, тип ресурса — `resource-manager.cloud`.

{% include notitle [mkf-quotas](../_includes/mdb/mkf-limits.md#mkf-quotas) %}

## {{ msp-full-name }} {#msp}

Сервис — `managed-spark`, тип ресурса — `resource-manager.cloud`.

{% include notitle [msp-quotas](../_includes/managed-spark/limits.md#quotas) %}

## {{ mch-full-name }} {#mch}

Сервис — `mdb`, тип ресурса — `resource-manager.cloud`.

{% include notitle [mch-quotas](../_includes/mdb/mch-limits.md#mch-quotas) %}

## {{ mgl-full-name }} {#mgl}

Сервис — `managed-gitlab`, тип ресурса — `resource-manager.cloud`.

{% include notitle [mgl-quotas](../_includes/managed-gitlab/limits.md#quotas) %}


## {{ mgp-full-name }} {#mgp}

Сервис — `mdb`, тип ресурса — `resource-manager.cloud`.

{% include notitle [mgp-quotas](../_includes/mdb/mgp/limits.md#quotas) %}


## {{ managed-k8s-full-name }} {#managed-k8s}

Сервис — `managed-kubernetes`, тип ресурса — `resource-manager.cloud`.

{% include notitle [managed-kube-quotas](../_includes/managed-kube-limits.md#managed-k8s-quotas) %}

## {{ mmy-full-name }} {#mmy}

Сервис — `mdb`, тип ресурса — `resource-manager.cloud`.

{% include notitle [mmy-quotas](../_includes/mdb/mmy-limits.md#mmy-quotas) %}

## {{ mos-full-name }} {#mos}

Сервис — `mdb`, тип ресурса — `resource-manager.cloud`.

{% include notitle [limits.md](../_includes/mdb/mos/limits.md#quotas) %}

## {{ mpg-full-name }} {#mpg}

Сервис — `mdb`, тип ресурса — `resource-manager.cloud`.

{% include notitle [mpg-quotas](../_includes/mdb/mpg-limits.md#mpg-quotas) %}

## {{ mtr-full-name }} {#mtr}

Сервис — `managed-trino`, тип ресурса — `resource-manager.cloud`.

{% include notitle [mtr-quotas](../_includes/managed-trino/limits.md#quotas) %}

## {{ mrd-full-name }} {#mrd}

Сервис — `mdb`, тип ресурса — `resource-manager.cloud`.

{% include notitle [mrd-quotas](../_includes/mdb/mrd-limits.md#mrd-quotas) %}

## {{ ydb-full-name }} {#ydb}

Сервис — `ydb`, тип ресурса — `resource-manager.cloud`.

{% include notitle [ydb-quotas](../_includes/ydb/ydb-limits.md#ydb-quotas) %}

## {{ myt-full-name }} {#myt}

Сервис — `managed-ytsaurus`, тип ресурса — `resource-manager.cloud`.

{% include notitle [myt-quotas](../_includes/managed-ytsaurus/limits.md#quotas) %}

## {{ metadata-hub-full-name }} {#metadata-hub}

Сервис — `metadata-hub`, тип ресурса — `resource-manager.cloud`.

### {{ connection-manager-name }} {#connection-manager-quota}

{% include notitle [connection-manager-quotas](../_includes/metadata-hub/connection-manager-quotas.md) %}

### {{ schema-registry-name }} {#schema-registry-quota}

{% include notitle [schema-registry-quotas](../_includes/metadata-hub/schema-registry-quotas.md) %}

### {{ metastore-name }} {#metastore-quota}

Сервис — `managed-metastore`, тип ресурса — `resource-manager.cloud`.

{% include notitle [metastore-quotas](../_includes/metadata-hub/metastore-quotas.md) %}

## {{ monitoring-full-name }} {#monitoring}

Сервис — `monitoring`, тип ресурса — `resource-manager.cloud`.

{% include notitle [monitoring-quotas](../_includes/monitoring/monitoring-limits.md#monitoring-quotas) %}

## {{ network-load-balancer-full-name }} {#load-balancer}

Сервис — `ylb`, тип ресурса — `resource-manager.cloud`.

{% include notitle [load-balancer-quotas](../_includes/load-balancer-limits.md#load-balancer-quotas) %}

## {{ objstorage-full-name }} {#storage}

Сервис — `storage`, тип ресурса — `resource-manager.cloud`.

{% include notitle [storage-quotas](../_includes/storage-limits.md#storage-quotas) %}

## {{ yq-full-name }} {#yq}

Сервис — `query`, тип ресурса — `resource-manager.cloud`.

{% include notitle [limits.md](../query/_includes/limits.md#yq-quotas) %}

## {{ resmgr-full-name }} {#resource-manager}

Сервис — `resource-manager`, тип ресурса — `organization-manager.organization`.

{% include notitle [resource-manager-quotas](../_includes/resource-manager-limits.md#resmgr-quotas) %}

## {{ serverless-containers-full-name }} {#serverless-containers}

Сервис — `serverless-containers`, тип ресурса — `resource-manager.cloud`.

{% include notitle [serverless-containers-quotas](../_includes/serverless-containers/serverless-containers-limits.md#serverless-containers-quotas) %}

## {{ captcha-full-name }} {#captcha}

Сервис — `smartcaptcha`, тип ресурса — `resource-manager.cloud`.

{% include notitle [smartcaptcha-quotas](../_includes/smartcaptcha-limits.md#quotas) %}

## {{ sws-full-name }} {#sws}

Сервис — `smartwebsecurity`, тип ресурса — `resource-manager.cloud`.

{% include notitle [smartwebsecurity-quotas](../_includes/sws-limits.md#quotas) %}

## {{ mmg-full-name }} {#mmg}

Сервис — `mdb`, тип ресурса — `resource-manager.cloud`.

{% include notitle [mmg-quotas](../_includes/mdb/mmg-limits.md#mmg-quotas) %}

## {{ vpc-full-name }} {#vpc}

Сервис — `vpc`, тип ресурса — `resource-manager.cloud`.

{% include notitle [vpc-quotas](../_includes/vpc-limits.md#vpc-quotas) %}
