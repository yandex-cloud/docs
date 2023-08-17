---
title: "What are quotas and limits in a cloud?"
description: "{{ yandex-cloud }} services may be subject to quotas and limits. Quotas are organizational restrictions that can be changed by technical support on request. Limits are technical restrictions due to the {{ yandex-cloud }} architecture. The limits cannot be changed."
---

# {{ yandex-cloud }} services quotas and limits

{{ yandex-cloud }} services can be subject to quotas and limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

When designing your infrastructure in {{ yandex-cloud }}, plan for the maximum limits that {{ yandex-cloud }} can provide you with. Quotas are restrictions that can be potentially increased up to their limit.


## Why quotas are needed {#quotas}

Quotas serve as a soft restriction for requesting resources and enable {{ yandex-cloud }} to guarantee service stability, as new users cannot take up too many resources for testing purposes. If you are willing to use more resources, you can increase them in the following ways:

* [Generate a request for a quota increase]({{ link-console-quotas }}). You must have the `quota-manager.requestOperator` [role](../../iam/concepts/access-control/roles.md#quota-roles) or higher (`editor` or `admin`).
* Contact [support]({{ link-console-support }}) and tell us which quotas you need to increase and by how much.


## Default quotas and limits for {{ yandex-cloud }} services {#quotas-limits-default}


Quotas are listed with default values that match the quotas of the [trial period](../../getting-started/free-trial/concepts/quickstart.md).




### {{ api-gw-full-name }} {#api-gw}

{% include [api-gateway-limits.md](../../_includes/api-gateway/api-gateway-limits.md) %}



### {{ alb-full-name }} {#alb}

{% include [alb-limits](../../_includes/application-load-balancer/alb-limits.md) %}


### {{ at-full-name }} {#at}

{% include [audit-trails.md](../../_includes/audit-trails-limits.md) %}


### {{ certificate-manager-full-name }} {#certificate-manager}

{% include [certificate-manager-limits.md](../../_includes/certificate-manager/certificate-manager-limits.md) %}



### {{ backup-full-name }} {#backup}

{% include [backup-limits.md](../../_includes/backup-limits.md) %}




### {{ cdn-full-name }} {#cdn}

{% include [cdn-limits](../../_includes/cdn/limits.md) %}




### {{ cloud-desktop-full-name }} {#cloud-desktop}

{% include [limits](../../_includes/cloud-desktop/limits.md) %}



### {{ dns-full-name }} {#dns}

{% include [limits](../../_includes/cloud-dns-limits.md) %}



### {{ sf-full-name }} {#sf}

{% include [functions-limits.md](../../_includes/functions-limits.md) %}




### {{ interconnect-full-name }} {#interconnect}

{% include [interconnect-limits.md](../../_includes/interconnect-limits.md) %}



### {{ cloud-logging-full-name }} {#logging}

{% include [logging-limits.md](../../_includes/logging/logging-limits.md) %}


### {{ org-full-name }} {#organization}

{% include [org-limits.md](../../_includes/organization/org-limits.md) %}

### {{ compute-full-name }} {#compute}

{% include [compute-limits.md](../../_includes/compute-limits.md) %}


### {{ container-registry-full-name }} {#container-registry}

{% include [container-registry-limits.md](../../_includes/container-registry-limits.md) %}



### {{ dataproc-full-name }} {#dataproc}

{% include [dataproc-limits.md](../../_includes/data-proc/dataproc-limits.md) %}




### {{ yds-full-name }} {#yds}

{% include [yds-limits.md](../../_includes/yds-limits.md) %}



### {{ data-transfer-full-name }} {#data-transfer}

{% include [data-transfer-limits](../../_includes/data-transfer/data-transfer-limits.md) %}


### {{ datalens-full-name }} {#datalens}

{% include [datalens-limits.md](../../_includes/datalens/datalens-limits.md) %}



### {{ ml-platform-full-name }} {#ml-platform}

{% include [ml-platform-limits.md](../../_includes/datasphere-limits.md) %}



### {{ iam-full-name }} {#iam}

{% include [iam-limits.md](../../_includes/iam/iam-limits.md) %}



### {{ iot-full-name }} {#iot}

{% include [iot-limits.md](../../_includes/iot-limits.md) %}



### {{ kms-full-name }} {#kms}

{% include [kms-limits.md](../../_includes/kms/kms-limits.md) %}



### {{ load-testing-full-name }} {#load-testing}

There are no active quotas in {{ load-testing-name }}.

The computing resources consumed by [agents](../../load-testing/concepts/agent.md) are factored into the [quotas]({{ link-console-quotas }}) for [{{ compute-full-name }}](../../compute/concepts/limits.md).



### {{ lockbox-name }} {#lockbox}

{% include [lockbox-limits.md](../../_includes/lockbox-limits.md) %}


### {{ mkf-full-name }} {#mkf}

{% include [mkf-limits.md](../../_includes/mdb/mkf-limits.md) %}


### {{ mch-full-name }} {#mch}

{% include [mch-limits.md](../../_includes/mdb/mch-limits.md) %}



### {{ mes-full-name }} {#mes}

{% include [mes-limits.md](../../_includes/mdb/mes-limits.md) %}




### {{ mgl-full-name }} {#mgl}

{% include [mgl-limits](../../_includes/managed-gitlab/limits.md) %}




### {{ mgp-full-name }} {#mgp}

{% include [mgp-limits](../../_includes/mdb/mgp/limits.md) %}



### {{ managed-k8s-full-name }} {#managed-k8s}

{% include [managed-kube-limits.md](../../_includes/managed-kube-limits.md) %}



### {{ mmg-full-name }} {#mmg}

{% include [mmg-limits.md](../../_includes/mdb/mmg-limits.md) %}



### {{ mmy-full-name }} {#mmy}

{% include [mmy-limits.md](../../_includes/mdb/mmy-limits.md) %}


### {{ mos-full-name }} {#mos}

{% include [limits.md](../../_includes/mdb/mos/limits.md) %}


### {{ mpg-full-name }} {#mpg}

{% include [mpg-limits.md](../../_includes/mdb/mpg-limits.md) %}


### {{ mrd-full-name }} {#mrd}

{% include [mrd-limits.md](../../_includes/mdb/mrd-limits.md) %}



### {{ ydb-full-name }} {#ydb}

{% include [ydb-limits.md](../../_includes/ydb/ydb-limits.md) %}




### {{ message-queue-full-name }} {#mq}

{% include [ymq-limits.md](../../_includes/message-queue/ymq-limits.md) %}



### {{ monitoring-full-name }} {#monitoring}

{% include [monitoring-limits.md](../../_includes/monitoring/monitoring-limits.md) %}


### {{ network-load-balancer-full-name }} {#load-balancer}

{% include [load-balancer-limits.md](../../_includes/load-balancer-limits.md) %}


### {{ objstorage-full-name }} {#storage}

{% include [storage-limits.md](../../_includes/storage-limits.md) %}


### {{ yq-full-name }} {#yq}

{% include [limits.md](../../query/_includes/limits.md) %}



### {{ resmgr-full-name }} {#resource-manager}

{% include [resource-manager-limits.md](../../_includes/resource-manager-limits.md) %}



### {{ serverless-containers-full-name }} {#serverless-containers}

{% include [serverless-containers-limits.md](../../_includes/serverless-containers/serverless-containers-limits.md) %}




### {{ captcha-full-name }} {#captcha}

{% include [smartcaptcha-limits](../../_includes/smartcaptcha-limits.md) %}



### {{ speechkit-full-name }} {#speechkit}

{% include [speechkit-limits](../../_includes/speechkit-limits.md) %}



### {{ translate-full-name }} {#translate}

{% include [translate-limits](../../_includes/translate-limits.md) %}



### {{ vpc-full-name }} {#vpc}

{% include [vpc-limits.md](../../_includes/vpc-limits.md) %}



### {{ vision-full-name }} {#vision}

{% include [vision-limits](../../_includes/vision-limits.md) %}

