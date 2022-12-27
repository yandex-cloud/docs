#  Уровень нетарифицируемого использования (free tier) для сервисов {% if product == "yandex-cloud" %}экосистемы бессерверных вычислений{% endif %}{% if product == "cloud-il" %}{{ yandex-cloud }}{% endif %}

На {% if product == "cloud-il" %}некоторые сервисы {{ yandex-cloud }}{% endif %}{% if product == "yandex-cloud" %}сервисы экосистемы бессерверных вычислений{% endif %} действуют специальные тарифы, в рамках которых определенный объем услуг не тарифицируется. Объем рассчитан так, чтобы у вас была возможность разработать и запустить небольшой сервис, сайт или приложение.

{% if audience != "internal" %}

Free tier распространяется на сервисы:
{% if product == "yandex-cloud" %}* [{{ api-gw-full-name }}](#api-gw){% endif %}
{% if product == "yandex-cloud" %}* [{{ sf-full-name }}](#sf){% endif %}
{% if product == "yandex-cloud" %}* [{{ ydb-full-name }}](#ydb){% endif %}
* [{{ objstorage-full-name }}](#objstorage)
{% if product == "yandex-cloud" %}* [{{ message-queue-full-name }}](#message-queue){% endif %}
{% if product == "yandex-cloud" %}* [{{ iot-full-name }}](#iot){% endif %}
* [{{ vpc-full-name }}](#vpc)
{% if product == "yandex-cloud" %}* [{{ yds-full-name }}](#yds){% endif %}
{% if product == "yandex-cloud" %}* [{{ serverless-containers-full-name }}](#serverless-containers){% endif %}

{% if product == "yandex-cloud" %}

## {{ api-gw-full-name }} {#api-gw}

{% include [not-charged-gateway.md](../../_includes/pricing/price-formula/not-charged-gateway.md) %} 

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../api-gateway/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

## {{ sf-full-name }} {#sf}

{% include [not-charged-functions.md](../../_includes/pricing/price-formula/not-charged-functions.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../functions/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

## Бессерверный режим {{ ydb-full-name }} {#ydb}

{% include [not-charged-database.md](../../_includes/pricing/price-formula/not-charged-database.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../ydb/pricing/serverless.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% endif %}

## {{ objstorage-full-name }} {#objstorage}

{% include [not-charged-storage.md](../../_includes/pricing/price-formula/not-charged-storage.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../storage/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% if product == "yandex-cloud" %}

## {{ message-queue-full-name }} {#message-queue}

{% include [not-charged-queue.md](../../_includes/pricing/price-formula/not-charged-queue.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../message-queue/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

## {{ iot-full-name }} {#iot}

{% include [not-charged-iot.md](../../_includes/pricing/price-formula/not-charged-iot.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../iot-core/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% endif %}

## {{ vpc-full-name }} {#vpc}

{% include [not-charged-iot.md](../../_includes/pricing/price-formula/not-charged-vpc.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../vpc/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% if product == "yandex-cloud" %}

## {{ yds-full-name }} {#yds}

{% include [not-charged-streams.md](../../_includes/pricing/price-formula/not-charged-streams.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../data-streams/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

## {{ serverless-containers-full-name }} {#serverless-containers}

{% include [not-charged-streams.md](../../_includes/pricing/price-formula/not-charged-serverless-containers.md) %}

После того, как вы израсходуете нетарифицируемый объем услуг, начнет взиматься плата в соответствии с [тарифами](../../serverless-containers/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% endif %}

{% endif %}
