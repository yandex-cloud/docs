#  Уровень нетарифицируемого использования (free tier) для сервисов экосистемы бессерверных вычислений


На сервисы экосистемы бессерверных вычислений действуют специальные тарифы, в рамках которых определенный объем услуг не тарифицируется. Объем рассчитан так, чтобы у вас была возможность разработать и запустить небольшой сервис, сайт или приложение.


Free tier распространяется на сервисы:
* [{{ api-gw-full-name }}](#api-gw)
* [{{ sf-full-name }}](#sf)
* [{{ ydb-full-name }}](#ydb)
* [{{ objstorage-full-name }}](#objstorage)
* [{{ message-queue-full-name }}](#message-queue)
* [{{ iot-full-name }}](#iot)
* [{{ vpc-full-name }}](#vpc)
* [{{ yds-full-name }}](#yds)
* [{{ serverless-containers-full-name }}](#serverless-containers)


## {{ api-gw-full-name }} {#api-gw}

[{{ api-gw-full-name }}](../../api-gateway/quickstart/) — сервис для управления API-шлюзами, поддерживающий [спецификацию OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) и набор расширений для взаимодействия с другими облачными сервисами.

{% include [not-charged-gateway.md](../../_includes/pricing/price-formula/not-charged-gateway.md) %} 

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../api-gateway/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}



## {{ sf-full-name }} {#sf}

Сервис [{{ sf-full-name }}](../../functions/quickstart/) позволяет запускать приложения в безопасном, отказоустойчивом и масштабируемом окружении без создания и обслуживания виртуальных машин.

{% include [not-charged-functions.md](../../_includes/pricing/price-formula/not-charged-functions.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../functions/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}



## Бессерверный режим {{ ydb-full-name }} {#ydb}

[{{ ydb-full-name }}](../../ydb/quickstart.md) помогает разворачивать и поддерживать базы данных {{ ydb-short-name }} в инфраструктуре {{ yandex-cloud }}.

{% include [not-charged-database.md](../../_includes/pricing/price-formula/not-charged-database.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../ydb/pricing/serverless.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}


## {{ objstorage-full-name }} {#objstorage}

[{{ objstorage-full-name }}](../../storage/quickstart.md) — это универсальное масштабируемое решение для хранения данных. Оно подходит как для высоконагруженных сервисов, которым требуется надежный и быстрый доступ к данным, так и для проектов с невысокими требованиями к инфраструктуре хранения.

{% include [not-charged-storage.md](../../_includes/pricing/price-formula/not-charged-storage.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../storage/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}


## {{ message-queue-full-name }} {#message-queue}

[{{ message-queue-full-name }}](../../message-queue/quickstart.md) — универсальное масштабируемое решение для обмена сообщениями между приложениями. Для работы с сервисом можно использовать популярные инструменты: API сервиса совместим с Amazon SQS API.

{% include [not-charged-queue.md](../../_includes/pricing/price-formula/not-charged-queue.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../message-queue/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}



## {{ iot-full-name }} {#iot}

[{{ iot-full-name }}](../../iot-core/quickstart.md) — это облачный отказоустойчивый MQTT-сервер, позволяющий наладить двустороннюю защищенную связь между устройствами и локальными или облачными ресурсами.

{% include [not-charged-iot.md](../../_includes/pricing/price-formula/not-charged-iot.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../iot-core/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}


## {{ vpc-full-name }} {#vpc}

[{{ vpc-full-name }}](../../vpc/quickstart.md) служит для управления облачными сетями и связи облачных ресурсов между собой и с интернетом.

{% include [not-charged-iot.md](../../_includes/pricing/price-formula/not-charged-vpc.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../vpc/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}


## {{ yds-full-name }} {#yds}

[{{ yds-full-name }}](../../data-streams/quickstart/) — масштабируемый сервис для управления потоками данных в режиме реального времени. {{ yds-short-name }} непрерывно выполняет сбор данных из различных источников, например, истории посещений веб‑сайтов, логов работы приложений и системных журналов. API сервиса совместим с Amazon Kinesis Data Streams API.

{% include [not-charged-streams.md](../../_includes/pricing/price-formula/not-charged-streams.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../data-streams/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}



## {{ serverless-containers-full-name }} {#serverless-containers}

Сервис [{{ serverless-containers-full-name }}](../../serverless-containers/quickstart/) позволяет запускать контейнеризированные приложения в безопасном, отказоустойчивом и масштабируемом окружении без создания и обслуживания виртуальных машин.

{% include [not-charged-streams.md](../../_includes/pricing/price-formula/not-charged-serverless-containers.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../serverless-containers/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}




## Примеры расчетов с применением free tier {#examples}

Стоимость использованного объема услуг сервиса рассчитывается в соответствии с тарифами этого сервиса за вычетом нетарифицируемого объема услуг. Например:

### Расчет стоимости использования функции {#function-example}

{% include [prices-example](../../_includes/functions/prices-example.md) %}

### Расчет стоимости использования API-шлюза {api-gateway-example}

{% include [prices-example](../../_includes/api-gateway/prices-example.md) %}

### Расчет стоимости использования {{ iot-full-name }} {#iot-example}

{% include [prices-example](../../_includes/iot-core/prices-example.md) %}
