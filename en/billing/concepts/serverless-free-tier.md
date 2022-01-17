# Free-tier serverless ecosystem usage

Special rates are applicable to services within the serverless computing ecosystem that include certain quantities of services at no extra charge. These are selected to enable you to develop and launch a small service, website, or application.

{% if audience != "internal" %}

Free tier applies to the following services:

* [{{ api-gw-full-name }}](#api-gw)
* [{{ sf-full-name }}](#sf)
* [{{ ydb-full-name }}](#ydb)
* [{{ objstorage-full-name }}](#objstorage)
* [{{ message-queue-full-name }}](#message-queue)
* [{{ iot-full-name }}](#iot)
* [{{ vpc-full-name }}](#vpc)
* [{{ yds-full-name }}](#yds)

## {{ api-gw-full-name }} {#api-gw}

The first 100,000 requests to API gateways each month are not charged. They are then charged at the applicable [rate](../../api-gateway/pricing.md).

The unused balance of free services is reset at the end of the month.

## {{ sf-full-name }} {#sf}

The following is offered at no extra charge each month:

* The first 1,000,000 function invocations.
* The first 10 GB×hour of function execution.

After you spend the free amount of services, you will be charged at the applicable [rate](../../functions/pricing.md).

The unused balance of free services is reset at the end of the month.

## {{ ydb-full-name }} serverless mode {#ydb}

The following is offered at no extra charge each month:

* The first 1,000,000 operations (in Request Units).
* The first 1 GB/month of data storage.

After you spend the free amount of services, you will be charged at the applicable [rate](../../ydb/pricing/serverless.md).

The unused balance of free services is reset at the end of the month.

## {{ objstorage-full-name }} {#objstorage}

Standard storage resources are provided free of charge every month:

* The first 1 GB of storage a month.
* The first 10,000 PUT, POST operations.
* The first 100,000 GET, HEAD operations.

After you spend the free amount of services, you will be charged at the applicable [rate](../../storage/pricing.md).

The unused balance of free services is reset at the end of the month.

## {{ message-queue-full-name }} {#message-queue}

The first 100,000 queue requests are free of charge every month.

After you spend the free amount of services, you will be charged at the applicable [rate](../../message-queue/pricing.md).

The unused balance of free services is reset at the end of the month.

## {{ iot-full-name }} {#iot}

The first 100,000 queue messages each month are free of charge.

After you spend the free amount of services, you will be charged at the applicable [rate](../../iot-core/pricing.md).

The unused balance of free services is reset at the end of the month.

## {{ vpc-full-name }} {#vpc}

The first 10 GB of outgoing traffic are provided free of charge every month.

After you spend the free amount of services, you will be charged at the applicable [rate](../../vpc/pricing.md).

The unused balance of free services is reset at the end of the month.

## {{ yds-full-name }} {#yds}

Data stream services with the following properties are provided free of charge each month:

* Segment write speed: no more than 128 KB/s.
* Message retention period: 1 hour.
* Number of data units written per month: no more than 2 million.

After you spend the free amount of services, you will be charged at the applicable [rate](../../data-streams/pricing.md).

The unused balance of free services is reset at the end of the month.

{% endif %}

