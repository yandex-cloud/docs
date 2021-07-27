---
title: What are quotas and limits in the cloud
description: 'Quotas and limits may apply to Yandex.Cloud services. Quotas are organizational restrictions that can be changed upon request to technical support. Limits are technical limitations due to the peculiarities of the Yandex.Cloud architecture. Limits cannot be changed.'

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Quotas and limits

{{ yandex-cloud }} services can be subject to quotas and limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

When designing your infrastructure in {{ yandex-cloud }}, plan for the limits as the maximum that {{ yandex-cloud }} can provide you with. Quotas are restrictions that can potentially be increased up to their limit.

## Why quotas are needed {#quotas}

Quotas serve as a soft restriction for requesting resources and let {{ yandex-cloud }} guarantee service stability because new users can't take up too many resources for testing purposes. If you're willing to use more resources, you can increase them in the following ways:

* [Submit an increase request]({{ link-console-quotas }});
* Contact the [technical support]({{ link-console-support }}) and tell us which consumed quotas you need to increase and by how much.

## Default quotas and limits for services {{ yandex-cloud }} {#quotas-limits-default}

Quotas are listed with default values that match the quotas of the [trial period](../../free-trial/).

### {{ compute-full-name }} {#compute}

{% include [compute-limits.md](../../_includes/compute-limits.md) %}

### {{ objstorage-full-name }} {#storage}

{% include [storage-limits.md](../../_includes/storage-limits.md) %}

### {{ vpc-full-name }} {#vpc}

{% include [vpc-limits.md](../../_includes/vpc-limits.md) %}

### {{ iam-full-name }} {#iam}

{% include [iam-limits.md](../../_includes/iam/iam-limits.md) %}

### {{ resmgr-full-name }} {#resource-manager}

{% include [resource-manager-limits.md](../../_includes/resource-manager-limits.md) %}

### {{ certificate-manager-full-name }} {#certificate-manager}

{% include [certificate-manager-limits.md](../../_includes/certificate-manager/certificate-manager-limits.md) %}

### {{ kms-full-name }} {#kms}

{% include [kms-limits.md](../../_includes/kms/kms-limits.md) %}

### {{ network-load-balancer-full-name }} {#load-balancer}

{% include [load-balancer-limits.md](../../_includes/load-balancer-limits.md) %}

### {{ container-registry-full-name }} {#container-registry}

{% include [container-registry-limits.md](../../_includes/container-registry-limits.md) %}

### {{ managed-k8s-full-name }} {#managed-k8s}

{% include [managed-kube-limits.md](../../_includes/managed-kube-limits.md) %}

### {{ monitoring-full-name }} {#monitoring}

{% include [monitoring-limits.md](../../_includes/monitoring/monitoring-limits.md) %}

### {{ mpg-full-name }} {#mpg}

{% include [mpg-limits.md](../../_includes/mdb/mpg-limits.md) %}

### {{ mch-full-name }} {#mch}

{% include [mch-limits.md](../../_includes/mdb/mch-limits.md) %}

### {{ mmg-full-name }} {#mmg}

{% include [mmg-limits.md](../../_includes/mdb/mmg-limits.md) %}

### {{ mmy-full-name }} {#mmy}

{% include [mmy-limits.md](../../_includes/mdb/mmy-limits.md) %}

### {{ mrd-full-name }} {#mrd}

{% include [mrd-limits.md](../../_includes/mdb/mrd-limits.md) %}

### {{ dataproc-full-name }} {#dataproc}

{% include[dataproc-limits.md](../../_includes/data-proc/dataproc-limits.md) %}

### {{ message-queue-full-name }} {#mq}

{% include [ymq-limits.md](../../_includes/message-queue/ymq-limits.md) %}

### {{ sf-full-name }} {#sf}

{% include [functions-limits.md](../../_includes/functions-limits.md) %}

### {{ speechkit-full-name }} {#speechkit}

{% include [speechkit-limits](../../_includes/speechkit-limits.md) %}

### {{ translate-full-name }} {#translate}

{% include [translate-limits](../../_includes/translate-limits.md) %}

### {{ vision-full-name }} {#vision}

{% include [vision-limits](../../_includes/vision-limits.md) %}

### {{ ml-platform-full-name }} {#ml-platform}

{% include [ml-platform-limits.md](../../_includes/datasphere-limits.md) %}

### {{ datalens-full-name }} {#datalens}

{% include [compute-limits.md](../../_includes/datalens/datalens-limits.md) %}

### {{ iot-full-name }} {#iot}

{% include [iot-limits.md](../../_includes/iot-limits.md) %}

### {{ interconnect-full-name }} {#interconnect}

{% include [interconnect-limits.md](../../_includes/interconnect-limits.md) %}

### {{ ydb-full-name }} {#ydb}

{% include [ydb-limits.md](../../ydb/_includes/ydb-limits.md) %}

### {{ mms-full-name }} {#mms}

{% include [mms-limits.md](../../_includes/mdb/mms-limits.md) %}

### {{ mkf-full-name }} {#mkf}

{% include [mkf-limits.md](../../_includes/mdb/mkf-limits.md) %}

### {{ mes-full-name }} {#mes}

{% include [mes-limits.md](../../_includes/mdb/mes-limits.md) %}

### {{ api-gw-full-name }} {#api-gw}

{% include [api-gateway-limits.md](../../_includes/api-gateway/api-gateway-limits.md) %}

