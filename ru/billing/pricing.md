---
title: Правила тарификации для {{ yandex-cloud }}
description: Из статьи вы узнаете о правилах тарификации сервисов в {{ yandex-cloud }}.
editable: false
---

# Правила тарификации {{ yandex-cloud }}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

В {{ yandex-cloud }} вы можете использовать ресурсы как тарифицируемых, так и нетарифицируемых сервисов. Стоимость использования сервиса {{ billing-name }} входит в стоимость оплачиваемых сервисов и дополнительно не тарифицируется.


{% note tip %}

Чтобы рассчитать стоимость использования сервисов, воспользуйтесь [калькулятором]({{ link-cloud-calculator }}) на сайте {{ yandex-cloud }} или ознакомьтесь с [тарифами отдельных сервисов](#billable).

{% endnote %}


Цены на продукты сервисов также доступны в [Прайс-листе](/price-list?installationCode=ru).

## Тарифы отдельных сервисов {#billable}


Стоимость тарифицируемых сервисов рассчитывается на основе количества потребленных ресурсов и времени потребления. Каждый сервис реализует собственную логику подсчета потребленных ресурсов.

* [{{ api-gw-full-name }}](../api-gateway/pricing.md)
* [{{ alb-full-name }}](../application-load-balancer/pricing.md)
* [{{ at-full-name }}](../audit-trails/pricing.md)
* [{{ backup-full-name }}](../backup/pricing.md)
* [{{ cdn-full-name }}](../cdn/pricing.md)
* [{{ dns-full-name }}](../dns/pricing.md)
* [{{ sf-full-name }}](../functions/pricing.md)
* [{{ interconnect-full-name }}](../interconnect/pricing.md)
* [{{ cloud-logging-full-name }}](../logging/pricing.md)
* [{{ postbox-name }}](../postbox/pricing.md)
* [{{ compute-full-name }}](../compute/pricing.md)
    * [Вычислительные ресурсы ВМ](../compute/pricing.md#prices-instance-resources)
    * [Кластеры GPU](../compute/pricing.md#prices-gpu-clusters)
    * [Диски, снимки и образы](../compute/pricing.md#prices-storage)
    * [Файловые хранилища](../compute/pricing.md#prices-nfs)
* [{{ container-registry-full-name }}](../container-registry/pricing.md)
* [{{ dataproc-full-name }}](../data-proc/pricing.md)
* [{{ yds-full-name }}](../data-streams/pricing.md)
* [{{ data-transfer-full-name }}](../data-transfer/pricing.md)
* [{{ datalens-full-name }}](../datalens/pricing.md)
* [{{ ml-platform-full-name }}](../datasphere/pricing.md)
* [{{ foundation-models-full-name }}](../foundation-models/pricing.md)
    * [Генерация текста в {{ gpt-lite }} или {{ gpt-pro }}](../foundation-models/pricing.md#pricing-generating)
    * [Векторизация текста в {{ foundation-models-full-name }}](../foundation-models/pricing.md#pricing-embedding)
    * [Генерация изображений c помощью {{ yandexart-name }}](../foundation-models/pricing.md#pricing-image-generation)
* [{{ iot-full-name }}](../iot-core/pricing.md)
* [{{ kms-full-name }}](../kms/pricing.md)
* [{{ load-testing-full-name }}](../load-testing/pricing.md)
* [{{ lockbox-name }}](../lockbox/pricing.md)
* [{{ maf-full-name }}](../managed-airflow/pricing.md)
* [{{ mkf-full-name }}](../managed-kafka/pricing.md)
* [{{ mch-full-name }}](../managed-clickhouse/pricing.md)
* [{{ mgl-full-name }}](../managed-gitlab/pricing.md)
* [{{ mgp-full-name }}](../managed-greenplum/pricing/index.md)
* [{{ managed-k8s-full-name }}®](../managed-kubernetes/pricing.md)
* [{{ mmg-full-name }}](../managed-mongodb/pricing.md)
* [{{ mmy-full-name }}](../managed-mysql/pricing.md)
* [{{ mos-full-name }}](../managed-opensearch/pricing.md)
* [{{ mpg-full-name }}](../managed-postgresql/pricing.md)
* [{{ mrd-full-name }}](../managed-redis/pricing.md)
* [{{ ydb-full-name }}](../ydb/pricing/index.md)
* [{{ message-queue-full-name }}](../message-queue/pricing.md)
* [{{ monitoring-full-name }}](../monitoring/pricing.md)
    * [{{ monitoring-short-name }} API](../monitoring/pricing.md#monitoring-api)
    * [{{ prometheus-name }} Remote API](../monitoring/pricing.md#prometheus-remote-api)
* [{{ network-load-balancer-full-name }}](../network-load-balancer/pricing.md)
* [{{ objstorage-full-name }}](../storage/pricing.md)
* [{{ yq-full-name }}](../query/pricing.md)
* [{{ search-api-full-name }}](../search-api/pricing.md)
* [{{ serverless-containers-full-name }}](../serverless-containers/pricing.md)
* [{{ captcha-full-name }}](../smartcaptcha/pricing.md)
* [{{ sws-full-name }}](../smartwebsecurity/pricing.md)
* [{{ speechkit-full-name }}](../speechkit/pricing.md)
    * [Синтез речи](../speechkit/pricing.md#prices-tts)
    * [{{ brand-voice-name }}](../speechkit/pricing.md#brand-voice)
    * [Распознавание речи](../speechkit/pricing.md#prices-stt)
* [{{ speechsense-full-name }}](../speechsense/pricing.md)
    * [Анализ аудиозаписей диалогов](../speechsense/pricing.md#speech)
    * [Анализ текстовых диалогов](../speechsense/pricing.md#text)
* [{{ tracker-full-name }}]({{ link-tracker-cloudless }})
* [{{ translate-full-name }}](../translate/pricing.md)
* [{{ vpc-full-name }}](../vpc/pricing.md)
* [{{ vision-full-name }}](../vision/pricing.md)

## Нетарифицируемые сервисы {#free}

Расчет стоимости за использование следующих сервисов не производится:

* {{ preview-stage }} [{{ baremetal-full-name }}](../baremetal/pricing.md)
* [{{ certificate-manager-full-name }}](../certificate-manager/pricing.md)
* [Yandex Cloud Console](../console/pricing.md)
* {{ preview-stage }} [{{ cloud-desktop-full-name }}](../cloud-desktop/pricing.md)
* {{ preview-stage }} [{{ cns-full-name }}](../notifications/pricing.md)
* [{{ org-full-name }}](../organization/pricing.md)
* {{ preview-stage }} [{{ cloud-registry-full-name }}](../cloud-registry/pricing.md)
* {{ preview-stage }} [{{ video-full-name }}](../video/pricing.md)
* {{ preview-stage }} [{{ ca-full-name }}](../code-assistant/pricing.md)
* [{{ forms-full-name }}]({{ link-forms-cloudless }})
* [{{ iam-full-name }}](../iam/pricing.md)
* {{ preview-stage }} [{{ mtr-full-name }}](../managed-trino/pricing.md)
* {{ preview-stage }} [{{ metadata-hub-full-name }}](../metadata-hub/pricing.md)
* [{{ resmgr-full-name }}](../resource-manager/pricing.md)
* {{ preview-stage }} [{{ sd-full-name }}](../security-deck/pricing.md)
* {{ preview-stage }} [{{ si-full-name }}](../serverless-integrations/pricing.md)
* [{{ websql-full-name }}](../websql/pricing.md)
* [{{ wiki-full-name }}]({{ link-wiki-cloudless }})

 Тегом {{ preview-stage }} отмечены сервисы на стадии [Preview](../overview/concepts/launch-stages.md). 