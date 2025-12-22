---
title: List of {{ yandex-cloud }} service quotas
description: Many {{ yandex-cloud }} services have soft constraints on resource usage called quotas. You can view the quota value and create an update request using the quota ID specified in this section.
---

# {{ yandex-cloud }} service quotas

{{ quota-manager-name }} allows you to manage quotas of your {{ yandex-cloud }} services using different interfaces. 

This section contains quotas for services available in {{ quota-manager-short-name }}. Each table lists quota names and IDs you can use to manage quotas via {{ quota-manager-short-name }}. If the ID is not specified, you cannot use {{ quota-manager-short-name }} to view or update the quota.

The tables indicate the default quota values, which are the same as the [trial period](../getting-started/free-trial/concepts/quickstart.md) quotas. The limits apply to all [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud) resources, unless otherwise specified.

## {{ api-gw-full-name }} {#api-gw}

{{ api-gw-name }}, {{ sf-name }}, and {{ serverless-containers-name }} share the same quota for the `Number of triggers per cloud ` (`serverless.triggers.count`). This quota is listed together with [{{ sf-name }} quotas](#sf).

## {{ alb-full-name }} {#alb}

Service: `alb`, resource type: `resource-manager.cloud`.

{% include notitle [alb-quotas](../_includes/application-load-balancer/alb-limits.md#quotas) %}

## {{ at-full-name }} {#at}

Service: `audit-trails`, resource type: `resource-manager.cloud`.

{% include notitle [alb-quotas](../_includes/audit-trails-limits.md#audit-trails-quotas) %}

## {{ baremetal-full-name }} {#baremetal}

Service: `baremetal`, resource type: `resource-manager.cloud`.

{% include notitle [baremetal-quotas](../_includes/baremetal-limits.md#baremetal-quotas) %}

## {{ certificate-manager-full-name }} {#certificate-manager}

Service: `certificate-manager`, resource type: `resource-manager.cloud`.

{% include notitle [certificate-manager-quotas](../_includes/certificate-manager/certificate-manager-limits.md#certificate-manager-quotas) %}

## {{ backup-full-name }} {#backup}

Service: `backup`, resource type: `resource-manager.cloud`.

{% include notitle [backup-quotas](../_includes/backup-limits.md#backup-quotas) %}

## {{ cdn-full-name }} {#cdn}

Service: `cdn`, resource type: `resource-manager.cloud`.

{% include notitle [cdn-quotas](../_includes/cdn/limits.md#cdn-quotas) %}

## {{ cloud-desktop-full-name }} {#cloud-desktop}

Service: `cloud-desktop`, resource type: `resource-manager.cloud`.

{% include notitle [cloud-desktop-quotas](../_includes/cloud-desktop/limits.md#quotas) %}

## {{ dns-full-name }} {#dns}

Service: `dns`, resource type: `resource-manager.cloud`.

{% include notitle [dns-quotas](../_includes/cloud-dns-limits.md#cloud-dns-quotas) %}

## {{ sf-full-name }} {#sf}

Service: `serverless-functions`, resource type: `resource-manager.cloud`.

{% include notitle [functions-quotas](../_includes/functions-limits.md#functions-quotas) %}

## {{ cloud-logging-full-name }} {#logging}

Service: `logging`, resource type: `resource-manager.cloud`.

{% include notitle [logging-quotas](../_includes/logging/logging-limits.md#logging-quotas) %}


## {{ postbox-full-name }} {#postbox}

Service: `postbox`, resource type: `resource-manager.cloud`.

{% include notitle [postbox-quotas](../_includes/postbox/postbox-limits.md#postbox-quotas) %}

## {{ compute-full-name }} {#compute}

Service: `compute`, resource type: `resource-manager.cloud`.

{% include notitle [compute-quotas](../_includes/compute-limits.md#compute-quotas) %}

## {{ container-registry-full-name }} {#container-registry}

Service: `container-registry`, resource type: `resource-manager.cloud`.

{% include notitle [container-registry-quotas](../_includes/container-registry-limits.md#container-registry-quotas) %}


## {{ dataproc-full-name }} {#dataproc}

{% include notitle [data-processing-quotas](../_includes/data-processing/data-processing-limits.md#dataproc-quotas) %}


## {{ data-transfer-full-name }} {#data-transfer}

Service: `data-transfer`, resource type: `resource-manager.cloud`.

{% include notitle [data-transfer-quotas](../_includes/data-transfer/data-transfer-limits.md#dataproc-quotas) %}

## {{ iam-full-name }} {#iam}

Service: `iam`, resource type: `resource-manager.cloud`.

{% include notitle [iam-quotas](../_includes/iam/iam-limits.md#iam-quotas) %}

## {{ org-full-name }} {#organization}

Service: `organization-manager`, resource type: `organization-manager.organization`.

{% include notitle [org-quotas](../_includes/organization/org-limits.md#organization-quotas) %}

## {{ iot-full-name }} {#iot}

Service: `iot`, resource type: `resource-manager.cloud`.

{% include notitle [iot-quotas](../_includes/iot-limits.md#iot-quotas) %}

## {{ kms-full-name }} {#kms}

Service: `kms`, resource type: `resource-manager.cloud`.

{% include notitle [kms-quotas](../_includes/kms/kms-limits.md#kms-quotas) %}

## {{ load-testing-full-name }} {#load-testing}


The computing resources consumed by [agents](../load-testing/concepts/agent.md) are included in [{{ compute-full-name }} quotas](#compute).

## {{ lockbox-name }} {#lockbox}

Service: `lockbox`, resource type: `resource-manager.cloud`.

{% include notitle [lockbox-quotas](../_includes/lockbox-limits.md#quotas) %}

## {{ maf-full-name }} {#airflow}

Service: `managed-airflow`, resource type: `resource-manager.cloud`.

{% include notitle [airflow-quotas](../_includes/mdb/maf/limits.md#quotas) %}

## {{ mkf-full-name }} {#mkf}

Service: `mdb`, resource type: `resource-manager.cloud`.

{% include notitle [mkf-quotas](../_includes/mdb/mkf-limits.md#mkf-quotas) %}

## {{ msp-full-name }} {#msp}

Service: `managed-spark`, resource type: `resource-manager.cloud`.

{% include notitle [msp-quotas](../_includes/managed-spark/limits.md#quotas) %}

## {{ mch-full-name }} {#mch}

Service: `mdb`, resource type: `resource-manager.cloud`.

{% include notitle [mch-quotas](../_includes/mdb/mch-limits.md#mch-quotas) %}

## {{ mgl-full-name }} {#mgl}

Service: `managed-gitlab`, resource type: `resource-manager.cloud`.

{% include notitle [mgl-quotas](../_includes/managed-gitlab/limits.md#quotas) %}


## {{ mgp-full-name }} {#mgp}

Service: `mdb`, resource type: `resource-manager.cloud`.

{% include notitle [mgp-quotas](../_includes/mdb/mgp/limits.md#quotas) %}


## {{ managed-k8s-full-name }} {#managed-k8s}

Service: `managed-kubernetes`, resource type: `resource-manager.cloud`.

{% include notitle [managed-kube-quotas](../_includes/managed-kube-limits.md#managed-k8s-quotas) %}

## {{ mmy-full-name }} {#mmy}

Service: `mdb`, resource type: `resource-manager.cloud`.

{% include notitle [mmy-quotas](../_includes/mdb/mmy-limits.md#mmy-quotas) %}

## {{ mos-full-name }} {#mos}

Service: `mdb`, resource type: `resource-manager.cloud`.

{% include notitle [limits.md](../_includes/mdb/mos/limits.md#quotas) %}

## {{ mpg-full-name }} {#mpg}

Service: `mdb`, resource type: `resource-manager.cloud`.

{% include notitle [mpg-quotas](../_includes/mdb/mpg-limits.md#mpg-quotas) %}

## {{ mtr-full-name }} {#mtr}

Service: `managed-trino`, resource type: `resource-manager.cloud`.

{% include notitle [mtr-quotas](../_includes/managed-trino/limits.md#quotas) %}

## {{ mrd-full-name }} {#mrd}

Service: `mdb`, resource type: `resource-manager.cloud`.

{% include notitle [mrd-quotas](../_includes/mdb/mrd-limits.md#mrd-quotas) %}

## {{ ydb-full-name }} {#ydb}

Service: `ydb`, resource type: `resource-manager.cloud`.

{% include notitle [ydb-quotas](../_includes/ydb/ydb-limits.md#ydb-quotas) %}

## {{ myt-full-name }} {#myt}

Service: `managed-ytsaurus`, resource type: `resource-manager.cloud`.

{% include notitle [myt-quotas](../_includes/managed-ytsaurus/limits.md#quotas) %}

## {{ metadata-hub-full-name }} {#metadata-hub}

Service: `metadata-hub`, resource type: `resource-manager.cloud`.

### {{ connection-manager-name }} {#connection-manager-quota}

{% include notitle [connection-manager-quotas](../_includes/metadata-hub/connection-manager-quotas.md) %}

### {{ schema-registry-name }} {#schema-registry-quota}

{% include notitle [schema-registry-quotas](../_includes/metadata-hub/schema-registry-quotas.md) %}

### {{ metastore-name }} {#metastore-quota}

Service: `managed-metastore`, resource type: `resource-manager.cloud`.

{% include notitle [metastore-quotas](../_includes/metadata-hub/metastore-quotas.md) %}

## {{ monitoring-full-name }} {#monitoring}

Service: `monitoring`, resource type: `resource-manager.cloud`.

{% include notitle [monitoring-quotas](../_includes/monitoring/monitoring-limits.md#monitoring-quotas) %}

## {{ network-load-balancer-full-name }} {#load-balancer}

Service: `ylb`, resource type: `resource-manager.cloud`.

{% include notitle [load-balancer-quotas](../_includes/load-balancer-limits.md#load-balancer-quotas) %}

## {{ objstorage-full-name }} {#storage}

Service: `storage`, resource type: `resource-manager.cloud`.

{% include notitle [storage-quotas](../_includes/storage-limits.md#storage-quotas) %}

## {{ yq-full-name }} {#yq}

Service: `query`, resource type: `resource-manager.cloud`.

{% include notitle [limits.md](../query/_includes/limits.md#yq-quotas) %}

## {{ resmgr-full-name }} {#resource-manager}

Service: `resource-manager`, resource type: `organization-manager.organization`.

{% include notitle [resource-manager-quotas](../_includes/resource-manager-limits.md#resmgr-quotas) %}

## {{ serverless-containers-full-name }} {#serverless-containers}

Service: `serverless-containers`, resource type: `resource-manager.cloud`.

{% include notitle [serverless-containers-quotas](../_includes/serverless-containers/serverless-containers-limits.md#serverless-containers-quotas) %}

## {{ captcha-full-name }} {#captcha}

Service: `smartcaptcha`, resource type: `resource-manager.cloud`.

{% include notitle [smartcaptcha-quotas](../_includes/smartcaptcha-limits.md#quotas) %}

## {{ sws-full-name }} {#sws}

Service: `smartwebsecurity`, resource type: `resource-manager.cloud`.

{% include notitle [smartwebsecurity-quotas](../_includes/sws-limits.md#quotas) %}

## {{ mmg-full-name }} {#mmg}

Service: `mdb`, resource type: `resource-manager.cloud`.

{% include notitle [mmg-quotas](../_includes/mdb/mmg-limits.md#mmg-quotas) %}

## {{ vpc-full-name }} {#vpc}

Service: `vpc`, resource type: `resource-manager.cloud`.

{% include notitle [vpc-quotas](../_includes/vpc-limits.md#vpc-quotas) %}
