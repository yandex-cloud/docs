# Free-tier {% if product == "yandex-cloud" %}serverless ecosystem{% endif %}{% if product == "cloud-il" %}{{ yandex-cloud }}{% endif %} usage

{% if product == "cloud-il" %}

{% note info %}

At the [Preview](../../overview/concepts/launch-stages.md) stage, {{ yandex-cloud }} services can be used free of charge, so free-tier service usage is described for informative purposes only.

{% endnote %}

{% endif %}

Special rates are applicable to {% if product == "cloud-il" %}some services of {{ yandex-cloud }}{% endif %}{% if product == "yandex-cloud" %}services within the serverless computing ecosystem{% endif %} that include certain quantities of services at no extra charge. These are selected to enable you to develop and launch a small service, website, or application.

{% if audience != "internal" %}

Free tier applies to the following services:
{% if product == "yandex-cloud" %}* [{{ api-gw-full-name }}](#api-gw){% endif %}
{% if product == "yandex-cloud" %}* [{{ sf-full-name }}](#sf){% endif %}
{% if product == "yandex-cloud" %}* [{{ ydb-full-name }}](#ydb){% endif %}
* [{{ objstorage-full-name }}](#objstorage)
* [{{ message-queue-full-name }}](#message-queue)
{% if product == "yandex-cloud" %}* [{{ iot-full-name }}](#iot){% endif %}
* [{{ vpc-full-name }}](#vpc)
{% if product == "yandex-cloud" %}* [{{ yds-full-name }}](#yds){% endif %}
{% if product == "yandex-cloud" %}* [{{ serverless-containers-full-name }}](#serverless-containers){% endif %}

{% if product == "yandex-cloud" %}

## {{ api-gw-full-name }} {#api-gw}

{% include [not-charged-gateway.md](../../_includes/pricing/price-formula/not-charged-gateway.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../api-gateway/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

## {{ sf-full-name }} {#sf}

{% include [not-charged-functions.md](../../_includes/pricing/price-formula/not-charged-functions.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../functions/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

##  {{ ydb-full-name }} serverless mode {#ydb}

{% include [not-charged-database.md](../../_includes/pricing/price-formula/not-charged-database.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../ydb/pricing/serverless.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% endif %}

## {{ objstorage-full-name }} {#objstorage}

{% include [not-charged-storage.md](../../_includes/pricing/price-formula/not-charged-storage.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../storage/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ message-queue-full-name }} {#message-queue}

{% include [not-charged-queue.md](../../_includes/pricing/price-formula/not-charged-queue.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../message-queue/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% if product == "yandex-cloud" %}

## {{ iot-full-name }} {#iot}

{% include [not-charged-iot.md](../../_includes/pricing/price-formula/not-charged-iot.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../iot-core/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% endif %}

## {{ vpc-full-name }} {#vpc}

{% include [not-charged-iot.md](../../_includes/pricing/price-formula/not-charged-vpc.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../vpc/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% if product == "yandex-cloud" %}

## {{ yds-full-name }} {#yds}

{% include [not-charged-streams.md](../../_includes/pricing/price-formula/not-charged-streams.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../data-streams/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

## {{ serverless-containers-full-name }} {#serverless-containers}

{% include [not-charged-streams.md](../../_includes/pricing/price-formula/not-charged-serverless-containers.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../serverless-containers/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

{% endif %}

{% endif %}
