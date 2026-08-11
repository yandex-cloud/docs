---
title: Правила тарификации для {{ yandex-cloud }}
description: Из статьи вы узнаете о правилах тарификации сервисов в {{ yandex-cloud }}.
editable: false
---

# Правила тарификации {{ yandex-cloud }}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      sm: 4
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервисов, исходя из ваших потребностей
        icon: ../_assets/console-icons/calculator.svg
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Прайс-лист
        text: Актуальные тарифы на все наши услуги
        icon: ../_assets/console-icons/circle-ruble.svg
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Акции и free tier
        text: Гранты, специальные условия и программы поддержки
        icon: ../_assets/console-icons/flame.svg
        urlTitle: Акции и free tier
        url: https://yandex.cloud/ru/all-offers
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::


{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

В {{ yandex-cloud }} вы можете использовать ресурсы как тарифицируемых, так и нетарифицируемых сервисов. Стоимость использования сервиса {{ billing-name }} входит в стоимость оплачиваемых сервисов и дополнительно не тарифицируется.

## Тарифы отдельных сервисов {#billable}


Стоимость тарифицируемых сервисов рассчитывается на основе количества потребленных ресурсов и времени потребления. Каждый сервис реализует собственную логику подсчета потребленных ресурсов.

* {{ preview-stage }} [{{ gost-gateway-name }}](../gost-gateway/pricing.md)
* [{{ monium-name }}](../monium/pricing.md)
* [{{ src-full-name }}]({{ link-src-docs }}/sourcecraft/pricing)
* [{{ ca-full-name }}]({{ link-src-docs }}/sourcecraft/pricing)
* [{{ ai-studio-full-name }}]({{ link-docs-ai }}ai-studio/pricing)
    * [Генеративные модели и ИИ-агенты]({{ link-docs-ai }}ai-studio/pricing#rules-model-gallery)
    * [{{ search-api-full-name }}]({{ link-docs-ai }}search-api/pricing)
    * [{{ speechkit-full-name }}]({{ link-docs-ai }}speechkit/pricing)
        * [Синтез речи]({{ link-docs-ai }}speechkit/pricing#prices-tts)
        * [{{ brand-voice-name }}]({{ link-docs-ai }}speechkit/pricing#brand-voice)
        * [Распознавание речи]({{ link-docs-ai }}speechkit/pricing#prices-stt)
    * [{{ translate-full-name }}]({{ link-docs-ai }}translate/pricing)
    * [{{ vision-full-name }}]({{ link-docs-ai }}ai-studio/pricing#rules-image-recognition)
* [{{ api-gw-full-name }}](../api-gateway/pricing.md)
* [{{ alb-full-name }}](../application-load-balancer/pricing.md)
* [{{ at-full-name }}](../audit-trails/pricing.md)
* [{{ baremetal-full-name }}](../baremetal/pricing.md)
* [{{ backup-full-name }}](../backup/pricing.md)
* [{{ cdn-full-name }}](../cdn/pricing.md)
* {{ preview-stage }} [{{ cloud-desktop-full-name }}](../cloud-desktop/pricing.md)
* [{{ dns-full-name }}](../dns/pricing.md)
* [{{ sf-full-name }}](../functions/pricing.md)
* [{{ interconnect-full-name }}](../interconnect/pricing.md)
* [{{ cloud-logging-full-name }}](../logging/pricing.md)
* [{{ cns-full-name }}](../notifications/pricing.md)
* [{{ postbox-name }}](../postbox/pricing.md)
* [{{ cloud-registry-full-name }}](../cloud-registry/pricing.md)
* [{{ stackland-full-name }}](../stackland/pricing.md)
* [{{ video-full-name }}](../video/pricing.md)
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
* [{{ org-full-name }}](../organization/pricing.md)
* [{{ iot-full-name }}](../iot-core/pricing.md)
* [{{ kms-full-name }}](../kms/pricing.md)
* [{{ lockbox-name }}](../lockbox/pricing.md)
* [{{ maf-full-name }}](../managed-airflow/pricing.md)
* [{{ mkf-full-name }}](../managed-kafka/pricing.md)
* [{{ msp-full-name }}](../managed-spark/pricing.md)
* [{{ mch-full-name }}](../managed-clickhouse/pricing.md)
* [{{ mgl-full-name }}](../managed-gitlab/pricing.md)
* [{{ managed-k8s-full-name }}®](../managed-kubernetes/pricing.md)
* [{{ mmy-full-name }}](../managed-mysql/pricing.md)
* [{{ mos-full-name }}](../managed-opensearch/pricing.md)
* [{{ mpg-full-name }}](../managed-postgresql/pricing.md)
* [{{ mspqr-full-name }}](../managed-spqr/pricing.md)
* [{{ mtr-full-name }}](../managed-trino/pricing.md)
* [{{ mrd-full-name }}](../managed-valkey/pricing.md)
* [{{ ydb-full-name }}](../ydb/pricing/index.md)
* [{{ myt-full-name }}](../managed-ytsaurus/pricing.md)
* [{{ message-queue-full-name }}](../message-queue/pricing.md)
* [{{ metadata-hub-full-name }}](../metadata-hub/pricing.md)
* [{{ monitoring-full-name }}](../monitoring/pricing.md)
    * [{{ monitoring-short-name }} API](../monitoring/pricing.md#monitoring-api)
    * [{{ prometheus-name }} Remote API](../monitoring/pricing.md#prometheus-remote-api)
* [{{ network-load-balancer-full-name }}](../network-load-balancer/pricing.md)
* [{{ mgp-full-name }}](../managed-greenplum/pricing/index.md)
* [{{ objstorage-full-name }}](../storage/pricing.md)
* [{{ yq-full-name }}](../query/pricing.md)
* {{ preview-stage }} [{{ sd-full-name }}](../security-deck/pricing.md)
* [{{ serverless-containers-full-name }}](../serverless-containers/pricing.md)
* [{{ captcha-full-name }}](../smartcaptcha/pricing.md)
* [{{ sws-full-name }}](../smartwebsecurity/pricing.md)
* [{{ speechsense-full-name }}]({{ link-docs-ai }}speechsense/pricing)
    * [Анализ аудиозаписей диалогов]({{ link-docs-ai }}speechsense/pricing#speech)
    * [Анализ текстовых диалогов]({{ link-docs-ai }}speechsense/pricing#text)
* [{{ mmg-full-name }}](../storedoc/pricing.md)
* [{{ vpc-full-name }}](../vpc/pricing.md)

## Нетарифицируемые сервисы {#free}

Расчет стоимости за использование следующих сервисов не производится:

* [{{ certificate-manager-full-name }}](../certificate-manager/pricing.md)
* [Yandex Cloud Console](../console/pricing.md)
* [{{ quota-manager-full-name }}](../quota-manager/pricing.md)
* {{ preview-stage }} [{{ cr-full-name }}](../cloud-router/pricing.md)
* [{{ iam-full-name }}](../iam/pricing.md)
* [{{ resmgr-full-name }}](../resource-manager/pricing.md)
* {{ preview-stage }} [{{ si-full-name }}](../serverless-integrations/pricing.md)
* [{{ websql-full-name }}](../websql/pricing.md)

 Тегом {{ preview-stage }} отмечены сервисы на стадии [Preview](../overview/concepts/launch-stages.md). 