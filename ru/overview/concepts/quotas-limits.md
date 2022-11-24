---
title: "Что такое квоты и лимиты в облаке"
description: "В сервисах {{ yandex-cloud }} могут действовать квоты и лимиты. Квоты — организационные ограничения, которые можно изменить по запросу в техническую поддержку. Лимиты — технические ограничения, обусловленные особенностями архитектуры {{ yandex-cloud }}. Изменение лимитов невозможно."
---

# Квоты и лимиты для сервисов {{ yandex-cloud }}

В сервисах {{ yandex-cloud }} могут действовать квоты и лимиты:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

Проектируя инфраструктуру в {{ yandex-cloud }}, учитывайте лимиты как предел возможностей, которые {{ yandex-cloud }} может вам предоставить. Квоты — изменяемые ограничения, которые потенциально могут быть увеличены до значения лимитов.


## Зачем нужны квоты {#quotas}

Квоты служат мягким ограничением для запроса ресурсов, и позволяют {{ yandex-cloud }} гарантировать стабильность работы сервиса: новые пользователи не могут занять слишком много ресурсов в тестовых целях. Если вы готовы использовать большее количество ресурсов, вы можете увеличить их следующими способами:

* [сформируйте запрос на увеличение]({{ link-console-quotas }});
* обратитесь в [техническую поддержку]({{ link-console-support }}) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.


## Квоты и лимиты по умолчанию для сервисов {{ yandex-cloud }} {#quotas-limits-default}

{% if product == "yandex-cloud" %}

Квоты приведены со значениями по умолчанию, которые совпадают с квотами на время [пробного периода](../../getting-started/free-trial/concepts/quickstart.md).

{% endif %}


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

{% if product == "yandex-cloud" %}

### {{ mmg-full-name }} {#mmg}

{% include [mmg-limits.md](../../_includes/mdb/mmg-limits.md) %}

{% endif %}


### {{ mmy-full-name }} {#mmy}

{% include [mmy-limits.md](../../_includes/mdb/mmy-limits.md) %}


{% if product == "yandex-cloud" %}

### {{ mrd-full-name }} {#mrd}

{% include [mrd-limits.md](../../_includes/mdb/mrd-limits.md) %}

{% endif %}


{% if product == "yandex-cloud" %}

### {{ dataproc-full-name }} {#dataproc}

{% include [dataproc-limits.md](../../_includes/data-proc/dataproc-limits.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

### {{ message-queue-full-name }} {#mq}

{% include [ymq-limits.md](../../_includes/message-queue/ymq-limits.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

### {{ sf-full-name }} {#sf}

{% include [functions-limits.md](../../_includes/functions-limits.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

### {{ speechkit-full-name }} {#speechkit}

{% include [speechkit-limits](../../_includes/speechkit-limits.md) %}

{% endif %}


{% if product == "yandex-cloud" %}

### {{ translate-full-name }} {#translate}

{% include [translate-limits](../../_includes/translate-limits.md) %}

{% endif %}


{% if product == "yandex-cloud" %}

### {{ vision-full-name }} {#vision}

{% include [vision-limits](../../_includes/vision-limits.md) %}

{% endif %}


{% if product == "yandex-cloud" %}

### {{ ml-platform-full-name }} {#ml-platform}

{% include [ml-platform-limits.md](../../_includes/datasphere-limits.md) %}

{% endif %}


{% if product == "yandex-cloud" %}

### {{ datalens-full-name }} {#datalens}

{% include [compute-limits.md](../../_includes/datalens/datalens-limits.md) %}

{% endif %}


{% if product == "yandex-cloud" %}

### {{ iot-full-name }} {#iot}

{% include [iot-limits.md](../../_includes/iot-limits.md) %}

{% endif %}


{% if product == "yandex-cloud" %}

### {{ interconnect-full-name }} {#interconnect}

{% include [interconnect-limits.md](../../_includes/interconnect-limits.md) %}

{% endif %}


{% if product == "yandex-cloud" %}

### {{ ydb-full-name }} {#ydb}

{% include [ydb-limits.md](../../_includes/ydb/ydb-limits.md) %}


{% endif %}


{% if product == "yandex-cloud" %}

### {{ mms-full-name }} {#mms}

{% include [mms-limits.md](../../_includes/mdb/mms-limits.md) %}

{% endif %}


### {{ mkf-full-name }} {#mkf}

{% include [mkf-limits.md](../../_includes/mdb/mkf-limits.md) %}


{% if product == "yandex-cloud" %}

### {{ mes-full-name }} {#mes}

{% include [mes-limits.md](../../_includes/mdb/mes-limits.md) %}

{% endif %}


{% if product == "yandex-cloud" %}

### {{ api-gw-full-name }} {#api-gw}

{% include [api-gateway-limits.md](../../_includes/api-gateway/api-gateway-limits.md) %}

{% endif %}


{% if product == "yandex-cloud" %}

### {{ cloud-logging-full-name }} {#logging}

{% include [logging-limits.md](../../_includes/logging/logging-limits.md) %}

{% endif %}


{% if product == "yandex-cloud" %}

### {{ serverless-containers-full-name }} {#serverless-containers}

{% include [serverless-containers-limits.md](../../_includes/serverless-containers/serverless-containers-limits.md) %}

{% endif %}