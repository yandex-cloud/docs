---
title: Уровень нетарифицируемого использования (free tier)
description: Из статьи вы узнаете, что такое free-tier и для каких сервисов он доступен.
---

# Уровень нетарифицируемого использования (free tier)


На некоторые сервисы {{ yandex-cloud }} действуют специальные тарифы, в рамках которых определенный объем услуг не тарифицируется. Объем рассчитан так, чтобы у вас была возможность разработать и запустить небольшой сервис, сайт или приложение, или попробовать возможности сервиса.

{% include [price-formula/free-tier](../../_includes/pricing/price-formula/free-tier.md) %}

{% note info %}

Free tier применяется к платежному аккаунту. Если к платежному аккаунту привязаны несколько организаций или облаков, счетчик учитывает все потребленные ими ресурсы. 

Например, к платежному аккаунту привязаны Облако-1 и Облако-2. За месяц Облако-1 потребило 500&nbsp;000 вызовов функций, Облако-2 — 600&nbsp;000. Free tier для вызовов функций — 1&nbsp;000&nbsp;000. Значит, объем тарифицируемых вызовов функций рассчитывается следующим образом:

> (500&nbsp;000 + 600&nbsp;000) − 1&nbsp;000&nbsp;000 = 100&nbsp;000

{% endnote %}

Чтобы рассчитать стоимость использования сервисов, воспользуйтесь [калькулятором]({{ link-cloud-calculator }}) на сайте {{ yandex-cloud }} или ознакомьтесь с [Прайс-листом](/price-list?installationCode=ru).


Free tier распространяется на сервисы:
* [{{ api-gw-full-name }}](#api-gw)
* [{{ dns-full-name }}](#dns)
* [{{ sf-full-name }}](#sf)
* [{{ cloud-logging-full-name }}](#logging)
* [{{ postbox-full-name }}](#postbox)
* [{{ compute-full-name }}](#compute)
* [{{ container-registry-full-name }}](#cr)
* [{{ dataproc-full-name }}](#dataproc)
* [{{ yds-full-name }}](#yds)
* [{{ data-transfer-full-name }}](#transfer)
* [{{ datalens-full-name }}](#datalens)
* [{{ foundation-models-full-name }}](#foundation-models)
* [{{ iot-full-name }}](#iot)
* [{{ load-testing-full-name }}](#load-testing)
* [{{ ydb-full-name }}](#ydb)
* [{{ message-queue-full-name }}](#message-queue)
* [{{ monitoring-full-name }}](#monitoring)
* [{{ objstorage-full-name }}](#objstorage)
* [{{ yq-full-name }}](#yq)
* [{{ search-api-full-name }}](#search-api)
* [{{ serverless-containers-full-name }}](#serverless-containers)
* [{{ captcha-full-name }}](#smartcaptcha)
* [{{ sws-full-name }}](#smartwebsecurity)
* [{{ tracker-full-name }}](#tracker)
* [{{ vpc-full-name }}](#vpc)

## {{ api-gw-full-name }} {#api-gw}

[{{ api-gw-full-name }}](../../api-gateway/quickstart/) — сервис для управления API-шлюзами, поддерживающий [спецификацию OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) и набор расширений для взаимодействия с другими облачными сервисами.

{% include [not-charged-gateway.md](../../_includes/pricing/price-formula/not-charged-gateway.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../api-gateway/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ dns-full-name }} {#dns}

[{{ dns-full-name }}](../../dns/quickstart.md) служит для управления зонами DNS и доменными именами ваших ресурсов.

{% include [not-charged-dns.md](../../_includes/pricing/price-formula/not-charged-dns.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../dns/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ sf-full-name }} {#sf}

Сервис [{{ sf-full-name }}](../../functions/quickstart/) позволяет запускать приложения в безопасном, отказоустойчивом и масштабируемом окружении без создания и обслуживания виртуальных машин.

{% include [not-charged-functions.md](../../_includes/pricing/price-formula/not-charged-functions.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../functions/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ cloud-logging-full-name }} {#logging}

Сервис [{{ cloud-logging-full-name }}](../../logging/quickstart.md) позволяет читать и записывать логи сервисов и пользовательских приложений, объединяя сообщения в лог-группы.

{% include [not-charged-logging.md](../../_includes/pricing/price-formula/not-charged-logging.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../logging/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ postbox-full-name }} {#postbox}

[{{ postbox-full-name }}](../../postbox/quickstart.md) — сервис отправки транзакционных почтовых сообщений.

{% include [not-charged-postbox.md](../../_includes/pricing/price-formula/not-charged-postbox.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../postbox/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ compute-full-name }} {#compute}

Сервис [{{ compute-full-name }}](../../compute/quickstart/) предоставляет масштабируемые вычислительные мощности для создания виртуальных машин и управления ими. Сервис поддерживает [прерываемые](../../compute/concepts/preemptible-vm.md) виртуальные машины, а также отказоустойчивые [группы виртуальных машин](../../compute/concepts/instance-groups/index.md).

{% include [not-charged-compute.md](../../_includes/pricing/price-formula/not-charged-compute.md) %}

## {{ container-registry-full-name }} {#cr}

[{{ container-registry-full-name }}](../../container-registry/quickstart/) — сервис для хранения и распространения Docker-образов.

{% include [not-charged-cr.md](../../_includes/pricing/price-formula/not-charged-cr.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../container-registry/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ dataproc-full-name }} {#dataproc}

Сервис [{{ dataproc-full-name }}](../../data-proc/quickstart.md) помогает разворачивать кластеры Apache Hadoop® и Apache Spark™ в инфраструктуре {{ yandex-cloud }}. Вы сами определяете размер кластера, мощность узлов и набор сервисов Apache® (Spark™, HDFS, YARN, Hive, HBase®, Oozie™, Sqoop™, Flume™, Tez®, Zeppelin™).

{% include [not-charged-data-processing.md](../../_includes/pricing/price-formula/not-charged-data-processing.md) %}

## {{ yds-full-name }} {#yds}

[{{ yds-full-name }}](../../data-streams/quickstart/) — масштабируемый сервис для управления потоками данных в режиме реального времени. {{ yds-short-name }} непрерывно выполняет сбор данных из различных источников, например, истории посещений веб‑сайтов, логов работы приложений и системных журналов. API сервиса совместим с Amazon Kinesis Data Streams API.

{% include [not-charged-streams.md](../../_includes/pricing/price-formula/not-charged-streams.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../data-streams/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ data-transfer-full-name }} {#transfer}

Сервис [{{ data-transfer-full-name }}](../../data-transfer/quickstart.md) предназначен для логического переноса данных между источниками и приемниками. В качестве источников и приемников данных могут выступать СУБД, объектные хранилища или брокеры сообщений.

{% include [not-charged-transfer.md](../../_includes/pricing/price-formula/not-charged-transfer.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../data-transfer/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ datalens-full-name }} {#datalens}

[{{ datalens-full-name }}](../../datalens/quickstart.md) — это сервис для бизнес-аналитики. Сервис позволяет подключаться к различным источникам данных, строить визуализации, собирать дашборды и делиться полученными результатами.

{% include [not-charged-datalens.md](../../_includes/pricing/price-formula/not-charged-datalens.md) %}

## {{ foundation-models-full-name }} {#foundation-models}

[{{ foundation-models-full-name }}](../../foundation-models/index.yaml) — это сервис больших генеративных моделей для бизнеса. {{ yandex-cloud }} предоставляет доступ к нейросетям {{ gpt-lite }}, {{ gpt-pro }} и {{ yandexart-name }} и позволяет применять их в ваших бизнес-приложениях и веб-сервисах.

{% include [not-charged-foundation-models](../../_includes/pricing/price-formula/not-charged-foundation-models.md) %}

## {{ iot-full-name }} {#iot}

[{{ iot-full-name }}](../../iot-core/quickstart.md) — это облачный отказоустойчивый MQTT-сервер, позволяющий наладить двустороннюю защищенную связь между устройствами и локальными или облачными ресурсами.

{% include [not-charged-iot.md](../../_includes/pricing/price-formula/not-charged-iot.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../iot-core/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ load-testing-full-name }} {#load-testing}

[{{ load-testing-full-name }}](../../load-testing/quickstart.md) позволяет проводить нагрузочное тестирование, чтобы анализировать производительность ваших сервисов и приложений.

{% include [not-charged-load-testing.md](../../_includes/pricing/price-formula/not-charged-load-testing.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../load-testing/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ ydb-full-name }} {#ydb}

[{{ ydb-full-name }}](../../ydb/quickstart.md) помогает разворачивать и поддерживать базы данных {{ ydb-short-name }} в инфраструктуре {{ yandex-cloud }}.

{% include [not-charged-database.md](../../_includes/pricing/price-formula/not-charged-database.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../ydb/pricing/index.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ message-queue-full-name }} {#message-queue}

[{{ message-queue-full-name }}](../../message-queue/quickstart.md) — универсальное масштабируемое решение для обмена сообщениями между приложениями. Для работы с сервисом можно использовать популярные инструменты: API сервиса совместим с Amazon SQS API.

{% include [not-charged-queue.md](../../_includes/pricing/price-formula/not-charged-queue.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../message-queue/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ monitoring-full-name }} {#monitoring}

[{{ monitoring-full-name }}](../../monitoring/quickstart.md) позволяет собирать и хранить метрики, а также отображать их в виде графиков на дашбордах.

{% include [not-charged-monitoring.md](../../_includes/pricing/price-formula/not-charged-monitoring.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../monitoring/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ objstorage-full-name }} {#objstorage}

[{{ objstorage-full-name }}](../../storage/quickstart.md) — это универсальное масштабируемое решение для хранения данных. Оно подходит как для высоконагруженных сервисов, которым требуется надежный и быстрый доступ к данным, так и для проектов с невысокими требованиями к инфраструктуре хранения.

{% include [not-charged-storage.md](../../_includes/pricing/price-formula/not-charged-storage.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../storage/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ yq-full-name }} {#yq}

[{{ yq-full-name }}](../../query/quickstart/) — интерактивный, полностью управляемый сервис для инженеров данных и аналитиков. Сервис позволяет выполнять аналитические и потоковые запросы реального времени к структурированным или частично структурированным данным с помощью единого диалекта SQL.

{% include [not-charged-query.md](../../_includes/pricing/price-formula/not-charged-query.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../query/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ search-api-full-name }} {#search-api}

[{{ search-api-full-name }}](../../search-api/quickstart.md) — сервис, позволяющий отправлять запросы к поисковой базе Яндекса и получать ответы в формате XML. Сервис предназначен для разработчиков и вебмастеров и помогает организовать поиск по сайту, группе сайтов или интернету, а также дает возможность отслеживать позиции сайтов по поисковым запросам в поисковой выдаче Яндекса.

{% include [not-charged-search-api.md](../../_includes/pricing/price-formula/not-charged-search-api.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../search-api/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ serverless-containers-full-name }} {#serverless-containers}

Сервис [{{ serverless-containers-full-name }}](../../serverless-containers/quickstart/) позволяет запускать контейнеризированные приложения в безопасном, отказоустойчивом и масштабируемом окружении без создания и обслуживания виртуальных машин.

{% include [not-charged-streams.md](../../_includes/pricing/price-formula/not-charged-serverless-containers.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../serverless-containers/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ captcha-full-name }} {#smartcaptcha}

[{{ captcha-full-name }}](../../smartcaptcha/quickstart.md) позволяет определить, кем является пользователь системы: человеком или компьютером.

{% include [not-charged-smartcaptcha.md](../../_includes/pricing/price-formula/not-charged-smartcaptcha.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../smartcaptcha/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ sws-full-name }} {#smartwebsecurity}

[{{ sws-full-name }}](../../smartwebsecurity/quickstart.md) позволяет защитить вашу инфраструктуру от DDoS-атак и ботов на уровне приложений (L7).

{% include [not-charged-smartwebsecurity.md](../../_includes/pricing/price-formula/not-charged-smartwebsecurity.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../smartwebsecurity/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ tracker-full-name }} {#tracker}

[{{ tracker-full-name }}](../../tracker/quick-start.md) — это сервис для управления проектами и процессами.

{% include [not-charged-tracker.md](../../_includes/pricing/price-formula/not-charged-tracker.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../tracker/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ vpc-full-name }} {#vpc}

[{{ vpc-full-name }}](../../vpc/quickstart.md) служит для управления облачными сетями и связи облачных ресурсов между собой и с интернетом.

{% include [not-charged-iot.md](../../_includes/pricing/price-formula/not-charged-vpc.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../vpc/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}



## Примеры расчетов с применением free tier {#examples}

Стоимость использованного объема услуг сервиса рассчитывается в соответствии с тарифами этого сервиса за вычетом нетарифицируемого объема услуг. Например:

### Расчет стоимости использования функции {#function-example}

{% include [prices-example](../../_includes/functions/prices-example.md) %}

### Расчет стоимости использования API-шлюза {api-gateway-example}

{% include [prices-example](../../_includes/api-gateway/prices-example.md) %}

### Расчет стоимости использования {{ iot-full-name }} {#iot-example}

{% include [prices-example](../../_includes/iot-core/prices-example.md) %}

