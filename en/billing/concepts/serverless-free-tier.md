# Free-tier serverless ecosystem usage


Special rates are applicable to services within the serverless computing ecosystem that include certain quantities of services at no extra charge. These are selected to enable you to develop and launch a small service, website, or application.


Free tier applies to the following services:
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

[{{ api-gw-full-name }}](../../api-gateway/quickstart/) is a service for managing API gateways that supports [OpenAPI Specification 3.0](https://github.com/OAI/OpenAPI-Specification) and a set of extensions for interacting with other cloud services.

{% include [not-charged-gateway.md](../../_includes/pricing/price-formula/not-charged-gateway.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../api-gateway/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}



## {{ sf-full-name }} {#sf}

The [{{ sf-full-name }}](../../functions/quickstart/) service allows you to run your applications in a secure, fault-tolerant, and scalable environment without creating or maintaining VMs.

{% include [not-charged-functions.md](../../_includes/pricing/price-formula/not-charged-functions.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../functions/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}



## {{ ydb-full-name }} serverless mode {#ydb}

With [{{ ydb-full-name }}](../../ydb/quickstart.md), you can deploy and maintain {{ ydb-short-name }} databases in the {{ yandex-cloud }} infrastructure.

{% include [not-charged-database.md](../../_includes/pricing/price-formula/not-charged-database.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../ydb/pricing/serverless.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}


## {{ objstorage-full-name }} {#objstorage}

[{{ objstorage-full-name }}](../../storage/quickstart.md) is a universal scalable solution for data storage. It is the perfect choice both for high-load services that require reliable and fast access to data, and for projects with minimal requirements for storage infrastructure.

{% include [not-charged-storage.md](../../_includes/pricing/price-formula/not-charged-storage.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../storage/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}


## {{ message-queue-full-name }} {#message-queue}

[{{ message-queue-full-name }}](../../message-queue/quickstart.md) is a universal, scalable solution to enable messaging between applications. You can use popular tools to work with the service: the service API is compatible with the Amazon SQS API.

{% include [not-charged-queue.md](../../_includes/pricing/price-formula/not-charged-queue.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../message-queue/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}



## {{ iot-full-name }} {#iot}

[{{ iot-full-name }}](../../iot-core/quickstart.md) is a cloud-based fault-tolerant MQTT server that ensures secure two-way communication between devices and local or cloud resources.

{% include [not-charged-iot.md](../../_includes/pricing/price-formula/not-charged-iot.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../iot-core/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}


## {{ vpc-full-name }} {#vpc}

[{{ vpc-full-name }}](../../vpc/quickstart.md) is used for managing cloud networks and enabling cloud resource connections to each other and to the internet.

{% include [not-charged-iot.md](../../_includes/pricing/price-formula/not-charged-vpc.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../vpc/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}


## {{ yds-full-name }} {#yds}

[{{ yds-full-name }}](../../data-streams/quickstart/) is a scalable service that allows you to manage data streams in real time. {{ yds-short-name }} continuously collects data from various sources, including web browsing history and application and system logs. The service API is compatible with the Amazon Kinesis Data Streams API.

{% include [not-charged-streams.md](../../_includes/pricing/price-formula/not-charged-streams.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../data-streams/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}



## {{ serverless-containers-full-name }} {#serverless-containers}

[{{ serverless-containers-full-name }}](../../serverless-containers/quickstart/) allows you to run containerized applications in a secure, fault-tolerant, and scalable environment without creating or maintaining VMs.

{% include [not-charged-streams.md](../../_includes/pricing/price-formula/not-charged-serverless-containers.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../serverless-containers/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}




## Examples of cost calculations with free tier {#examples}

Usage cost is calculated based on the pricing plans of the relevant service and does not include the amount of services provided for free. Here is an example:

### Calculation of function usage cost {#function-example}

{% include [prices-example](../../_includes/functions/prices-example.md) %}

### Calculation of API gateway usage cost {api-gateway-example}

{% include [prices-example](../../_includes/api-gateway/prices-example.md) %}

### Calculation of {{ iot-full-name }} usage cost {#iot-example}

{% include [prices-example](../../_includes/iot-core/prices-example.md) %}
