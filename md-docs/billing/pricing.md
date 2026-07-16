[Документация Yandex Cloud](../index.md) > [Yandex Cloud Billing](index.md) > Правила тарификации

# Правила тарификации Yandex Cloud

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


{% note info %}

Цены на ресурсы Yandex Cloud в разных регионах различаются. Подробнее о доступных регионах в разделе [Регионы](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта в разделе [Регистрация аккаунта в Yandex Cloud](quickstart/index.md).

{% endnote %}

В Yandex Cloud вы можете использовать ресурсы как тарифицируемых, так и нетарифицируемых сервисов. Стоимость использования сервиса Yandex Cloud Billing входит в стоимость оплачиваемых сервисов и дополнительно не тарифицируется.

## Тарифы отдельных сервисов {#billable}


Стоимость тарифицируемых сервисов рассчитывается на основе количества потребленных ресурсов и времени потребления. Каждый сервис реализует собственную логику подсчета потребленных ресурсов.

* <code><b><small>Preview</small></b></code> [GOST Gateway](../gost-gateway/pricing.md)
* [Monium](../monium/pricing.md)
* [SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/pricing)
* [SourceCraft Code Assistant](https://sourcecraft.dev/portal/docs/ru/sourcecraft/pricing)
* [Yandex AI Studio](https://aistudio.yandex.ru/docs/ru/ai-studio/pricing)
    * [Генеративные модели и ИИ-агенты](https://aistudio.yandex.ru/docs/ru/ai-studio/pricing#rules-model-gallery)
    * [Yandex Search API](https://aistudio.yandex.ru/docs/ru/search-api/pricing)
    * [Yandex SpeechKit](https://aistudio.yandex.ru/docs/ru/speechkit/pricing)
        * [Синтез речи](https://aistudio.yandex.ru/docs/ru/speechkit/pricing#prices-tts)
        * [SpeechKit Brand Voice](https://aistudio.yandex.ru/docs/ru/speechkit/pricing#brand-voice)
        * [Распознавание речи](https://aistudio.yandex.ru/docs/ru/speechkit/pricing#prices-stt)
    * [Yandex Translate](https://aistudio.yandex.ru/docs/ru/translate/pricing)
    * [Yandex Vision OCR](https://aistudio.yandex.ru/docs/ru/vision/pricing)
* [Yandex API Gateway](../api-gateway/pricing.md)
* [Yandex Application Load Balancer](../application-load-balancer/pricing.md)
* [Yandex Audit Trails](../audit-trails/pricing.md)
* [Yandex BareMetal](../baremetal/pricing.md)
* [Yandex Cloud Backup](../backup/pricing.md)
* [Yandex Cloud CDN](../cdn/pricing.md)
* <code><b><small>Preview</small></b></code> [Yandex Cloud Desktop](../cloud-desktop/pricing.md)
* [Yandex Cloud DNS](../dns/pricing.md)
* [Yandex Cloud Functions](../functions/pricing.md)
* [Yandex Cloud Interconnect](../interconnect/pricing.md)
* [Yandex Cloud Logging](../logging/pricing.md)
* [Yandex Cloud Notification Service](../notifications/pricing.md)
* [Yandex Cloud Postbox](../postbox/pricing.md)
* [Yandex Cloud Registry](../cloud-registry/pricing.md)
* [Yandex Cloud Stackland](../stackland/pricing.md)
* [Yandex Cloud Video](../video/pricing.md)
* [Yandex Compute Cloud](../compute/pricing.md)
    * [Вычислительные ресурсы ВМ](../compute/pricing.md#prices-instance-resources)
    * [Кластеры GPU](../compute/pricing.md#prices-gpu-clusters)
    * [Диски, снимки и образы](../compute/pricing.md#prices-storage)
    * [Файловые хранилища](../compute/pricing.md#prices-nfs)
* [Yandex Container Registry](../container-registry/pricing.md)
* [Yandex Data Processing](../data-proc/pricing.md)
* [Yandex Data Streams](../data-streams/pricing.md)
* [Yandex Data Transfer](../data-transfer/pricing.md)
* [Yandex DataLens](../datalens/pricing.md)
* [Yandex DataSphere](../datasphere/pricing.md)
* [Yandex Identity Hub](../organization/pricing.md)
* [Yandex IoT Core](../iot-core/pricing.md)
* [Yandex Key Management Service](../kms/pricing.md)
* [Yandex Lockbox](../lockbox/pricing.md)
* [Yandex Managed Service for Apache Airflow™](../managed-airflow/pricing.md)
* [Yandex Managed Service for Apache Kafka®](../managed-kafka/pricing.md)
* [Yandex Managed Service for Apache Spark™](../managed-spark/pricing.md)
* [Yandex Managed Service for ClickHouse®](../managed-clickhouse/pricing.md)
* [Yandex Managed Service for GitLab](../managed-gitlab/pricing.md)
* [Yandex Managed Service for Kubernetes®](../managed-kubernetes/pricing.md)
* [Yandex Managed Service for MySQL®](../managed-mysql/pricing.md)
* [Yandex Managed Service for OpenSearch](../managed-opensearch/pricing.md)
* [Yandex Managed Service for PostgreSQL](../managed-postgresql/pricing.md)
* [Yandex Managed Service for Sharded PostgreSQL](../managed-spqr/pricing.md)
* [Yandex Managed Service for Trino](../managed-trino/pricing.md)
* [Yandex Managed Service for Valkey™](../managed-valkey/pricing.md)
* [Yandex Managed Service for YDB](../ydb/pricing/index.md)
* [Yandex Managed Service for YTsaurus](../managed-ytsaurus/pricing.md)
* [Yandex Message Queue](../message-queue/pricing.md)
* [Yandex MetaData Hub](../metadata-hub/pricing.md)
* [Yandex Monitoring](../monitoring/pricing.md)
    * [Monitoring API](../monitoring/pricing.md#monitoring-api)
    * [Prometheus Remote API](../monitoring/pricing.md#prometheus-remote-api)
* [Yandex Network Load Balancer](../network-load-balancer/pricing.md)
* [Yandex MPP Analytics for PostgreSQL](../managed-greenplum/pricing/index.md)
* [Yandex Object Storage](../storage/pricing.md)
* [Yandex Query](../query/pricing.md)
* <code><b><small>Preview</small></b></code> [Yandex Security Deck](../security-deck/pricing.md)
* [Yandex Serverless Containers](../serverless-containers/pricing.md)
* [Yandex SmartCaptcha](../smartcaptcha/pricing.md)
* [Yandex Smart Web Security](../smartwebsecurity/pricing.md)
* [Yandex SpeechSense](https://aistudio.yandex.ru/docs/ru/speechsense/pricing)
    * [Анализ аудиозаписей диалогов](https://aistudio.yandex.ru/docs/ru/speechsense/pricing#speech)
    * [Анализ текстовых диалогов](https://aistudio.yandex.ru/docs/ru/speechsense/pricing#text)
* [Yandex StoreDoc](../storedoc/pricing.md)
* [Yandex Virtual Private Cloud](../vpc/pricing.md)

## Нетарифицируемые сервисы {#free}

Расчет стоимости за использование следующих сервисов не производится:

* [Yandex Certificate Manager](../certificate-manager/pricing.md)
* [Yandex Cloud Console](../console/pricing.md)
* [Yandex Cloud Quota Manager](../quota-manager/pricing.md)
* <code><b><small>Preview</small></b></code> [Yandex Cloud Router](../cloud-router/pricing.md)
* [Yandex Identity and Access Management](../iam/pricing.md)
* [Yandex Resource Manager](../resource-manager/pricing.md)
* <code><b><small>Preview</small></b></code> [Yandex Serverless Integrations](../serverless-integrations/pricing.md)
* [Yandex WebSQL](../websql/pricing.md)

 Тегом <code><b><small>Preview</small></b></code> отмечены сервисы на стадии [Preview](../overview/concepts/launch-stages.md).