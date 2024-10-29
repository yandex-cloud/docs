---
title: Что такое квоты и лимиты в {{ yandex-cloud }}
description: В сервисах {{ yandex-cloud }} могут действовать квоты и лимиты. Квоты — организационные ограничения, которые можно изменить по запросу в техническую поддержку. Лимиты — технические ограничения, обусловленные особенностями архитектуры {{ yandex-cloud }}. Изменение лимитов невозможно.
---

# Квоты и лимиты для сервисов {{ yandex-cloud }}

В сервисах {{ yandex-cloud }} могут действовать квоты и лимиты:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

Проектируя инфраструктуру в {{ yandex-cloud }}, учитывайте лимиты как предел возможностей, которые {{ yandex-cloud }} может вам предоставить. Квоты — изменяемые ограничения, которые потенциально могут быть увеличены до значений лимитов.


## Зачем нужны квоты {#quotas}

Квоты служат мягким ограничением для запроса ресурсов и позволяют {{ yandex-cloud }} гарантировать стабильность работы сервиса: новые пользователи не могут занять слишком много ресурсов в тестовых целях.

Если вы готовы использовать большее количество ресурсов, вы можете увеличить их следующими способами:

* [сформируйте запрос на увеличение]({{ link-console-quotas }}). У вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`);
* обратитесь в [техническую поддержку]({{ link-console-support }}) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

## Квоты и лимиты по умолчанию для сервисов {{ yandex-cloud }} {#quotas-limits-default}


Квоты приведены со значениями по умолчанию, которые совпадают с квотами на время [пробного периода](../../getting-started/free-trial/concepts/quickstart.md).




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




### {{ billing-name }} {#billing}

{% include [billing-limits](../../_includes/billing/billing-limits.md) %}




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


### {{ cns-full-name }} {#cns}

{% include [cns-limits.md](../../_includes/cns-limits.md) %}


### {{ org-full-name }} {#organization}

{% include [org-limits.md](../../_includes/organization/org-limits.md) %}



### {{ postbox-full-name }} {#postbox}

{% include [postbox-limits](../../_includes/postbox/postbox-limits.md) %}



### {{ video-full-name }} {#video}

{% include [video-limits](../../_includes/video-limits.md) %}


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

В сервисе {{ load-testing-name }} нет действующих квот.

Потребление вычислительных ресурсов [агентами](../../load-testing/concepts/agent.md) учитывается в [квотах]({{ link-console-quotas }}) и ограничено лимитами сервиса [{{ compute-full-name }}](../../compute/concepts/limits.md).



### {{ lockbox-name }} {#lockbox}

{% include [lockbox-limits.md](../../_includes/lockbox-limits.md) %}



### {{ maf-full-name }} {#airflow}

{% include [airflow-limits.md](../../_includes/mdb/maf/limits.md) %}



### {{ mkf-full-name }} {#mkf}

{% include [mkf-limits.md](../../_includes/mdb/mkf-limits.md) %}


### {{ mch-full-name }} {#mch}

{% include [mch-limits.md](../../_includes/mdb/mch-limits.md) %}





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



### {{ search-api-full-name }} {#search-api}

{% include [search-api-limits](../../_includes/search-api-limits.md) %}




### {{ serverless-containers-full-name }} {#serverless-containers}

{% include [serverless-containers-limits.md](../../_includes/serverless-containers/serverless-containers-limits.md) %}




### {{ captcha-full-name }} {#captcha}

{% include [smartcaptcha-limits](../../_includes/smartcaptcha-limits.md) %}




### {{ sws-full-name }} {#sws}

{% include [smartwebsecurity-limits](../../_includes/sws-limits.md) %}



### {{ speechkit-full-name }} {#speechkit}

{% include [speechkit-limits](../../_includes/speechkit-limits.md) %}



### {{ translate-full-name }} {#translate}

{% include [translate-limits](../../_includes/translate-limits.md) %}



### {{ vpc-full-name }} {#vpc}

{% include [vpc-limits.md](../../_includes/vpc-limits.md) %}



### {{ vision-full-name }} {#vision}

{% include [vision-limits](../../_includes/vision-limits.md) %}




### {{ websql-full-name }} {#websql}

{% include [websql-limits](../../_includes/websql-limits.md) %}




### {{ yagpt-full-name }} {#yagpt}

{% include [yandexgpt-limits](../../_includes/yandexgpt-limits.md) %}


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
