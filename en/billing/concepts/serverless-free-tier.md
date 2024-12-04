---
title: Free tier
description: In this article, you will learn about the free tier and what services it is available for.
---

# Free tier


Some {{ yandex-cloud }} services offer special plans where certain amounts of services are provided free of charge. These are selected to enable you to develop and launch a small service, website, or application, or try out the service features.

{% note info %}

Free tier applies to billing accounts. If multiple organizations or clouds are linked to a billing account, the tag counts all the resources they consume.

For example, Cloud-1 and Cloud-2 are linked to a billing account. Cloud-1 has consumed 500,000 function calls, and Cloud-2 600,000 function calls a month. For function calls, free tier is 1,000,000. This is our calculation of the number of billable function calls:

> (500,000 + 600,000) - 1,000,000 = 100,000

{% endnote %}


Free tier applies to the following services:
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

[{{ api-gw-full-name }}](../../api-gateway/quickstart/) is an API gateway management service supporting [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) and extensions for compatibility with other cloud services.

{% include [not-charged-gateway.md](../../_includes/pricing/price-formula/not-charged-gateway.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../api-gateway/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ dns-full-name }} {#dns}

[{{ dns-full-name }}](../../dns/quickstart.md) is a DNS zone and domain name management tool for your resources.

{% include [not-charged-dns.md](../../_includes/pricing/price-formula/not-charged-dns.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../dns/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ sf-full-name }} {#sf}

The [{{ sf-full-name }}](../../functions/quickstart/) service allows you to run your applications in a secure, fault-tolerant, and scalable environment without creating or maintaining VMs.

{% include [not-charged-functions.md](../../_includes/pricing/price-formula/not-charged-functions.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../functions/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ cloud-logging-full-name }} {#logging}

[{{ cloud-logging-full-name }}](../../logging/quickstart.md) allows you to read and write logs of services and user applications by grouping messages into log groups.

{% include [not-charged-logging.md](../../_includes/pricing/price-formula/not-charged-logging.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../logging/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ postbox-full-name }} {#postbox}

[{{ postbox-full-name }}](../../postbox/quickstart.md) is a transaction email service.

{% include [not-charged-postbox.md](../../_includes/pricing/price-formula/not-charged-postbox.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../postbox/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ compute-full-name }} {#compute}

[{{ compute-full-name }}](../../compute/quickstart/) provides scalable computing capacity to create and manage virtual machines. The service supports [preemptible](../../compute/concepts/preemptible-vm.md) VMs and fault-tolerant [instance groups](../../compute/concepts/instance-groups/index.md).

{% include [not-charged-compute.md](../../_includes/pricing/price-formula/not-charged-compute.md) %}

## {{ container-registry-full-name }} {#cr}

[{{ container-registry-full-name }}](../../container-registry/quickstart/) is a service for storing and distributing Docker images.

{% include [not-charged-cr.md](../../_includes/pricing/price-formula/not-charged-cr.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../container-registry/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ dataproc-full-name }} {#dataproc}

[{{ dataproc-full-name }}](../../data-proc/quickstart.md) assists in deploying Apache Hadoop® and Apache Spark™ clusters in a {{ yandex-cloud }} infrastructure. The cluster size, node capacity, and selection of Apache® services (Spark™, HDFS, YARN, Hive, HBase®, Oozie™, Sqoop™, Flume™, Tez®, Zeppelin™) are all up to you.

{% include [not-charged-dataproc.md](../../_includes/pricing/price-formula/not-charged-dataproc.md) %}

## {{ yds-full-name }} {#yds}

[{{ yds-full-name }}](../../data-streams/quickstart/) is a scalable service that allows you to manage data streams in real time. {{ yds-short-name }} continuously collects data from various sources, including web browsing history and application and system logs. The service API is compatible with the Amazon Kinesis Data Streams API.

{% include [not-charged-streams.md](../../_includes/pricing/price-formula/not-charged-streams.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../data-streams/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ data-transfer-full-name }} {#transfer}

[{{ data-transfer-full-name }}](../../data-transfer/quickstart.md) enables logical data transfer between sources and targets. DBMS, object storage, or message brokers can be used as sources and targets.

{% include [not-charged-transfer.md](../../_includes/pricing/price-formula/not-charged-transfer.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../data-transfer/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ datalens-full-name }} {#datalens}

[{{ datalens-full-name }}](../../datalens/quickstart.md) is a business analytics service. It allows you to connect to various data sources, visualize data, create dashboards, and share your results.

{% include [not-charged-datalens.md](../../_includes/pricing/price-formula/not-charged-datalens.md) %}

## {{ foundation-models-full-name }} {#foundation-models}

[{{ foundation-models-full-name }}](../../foundation-models/index.yaml) is a service that provides large generative models for businesses. {{ yandex-cloud }} offers the {{ yagpt-name }} and {{ yandexart-name }} neural networks for your business apps and web services.

{% include [not-charged-foundation-models](../../_includes/pricing/price-formula/not-charged-foundation-models.md) %}

## {{ iot-full-name }} {#iot}

[{{ iot-full-name }}](../../iot-core/quickstart.md) is a cloud-based fault-tolerant MQTT server that ensures secure two-way communication between devices and local or cloud resources.

{% include [not-charged-iot.md](../../_includes/pricing/price-formula/not-charged-iot.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../iot-core/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ load-testing-full-name }} {#load-testing}

[{{ load-testing-full-name }}](../../load-testing/quickstart.md) allows you to perform load testing to analyze the performance of your services and applications.

{% include [not-charged-load-testing.md](../../_includes/pricing/price-formula/not-charged-load-testing.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../load-testing/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ ydb-full-name }} {#ydb}

With [{{ ydb-full-name }}](../../ydb/quickstart.md), you can deploy and maintain {{ ydb-short-name }} databases in the {{ yandex-cloud }} infrastructure.

{% include [not-charged-database.md](../../_includes/pricing/price-formula/not-charged-database.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../ydb/pricing/index.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ message-queue-full-name }} {#message-queue}

[{{ message-queue-full-name }}](../../message-queue/quickstart.md) is a universal, scalable solution to enable messaging between applications. You can use well-known and familiar tools to work with {{ message-queue-name}}, since its API is compatible with the Amazon SQS API.

{% include [not-charged-queue.md](../../_includes/pricing/price-formula/not-charged-queue.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../message-queue/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ monitoring-full-name }} {#monitoring}

[{{ monitoring-full-name }}](../../monitoring/quickstart.md) is a tool used to collect and store metrics and also present them as charts on dashboards.

{% include [not-charged-monitoring.md](../../_includes/pricing/price-formula/not-charged-monitoring.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../monitoring/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ objstorage-full-name }} {#objstorage}

[{{ objstorage-full-name }}](../../storage/quickstart.md) is a universal scalable solution for data storage. It is equally suited for high-load services requiring reliable and fast access to data and for projects with moderate storage infrastructure requirements.

{% include [not-charged-storage.md](../../_includes/pricing/price-formula/not-charged-storage.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../storage/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ yq-full-name }} {#yq}

[{{ yq-full-name }}](../../query/quickstart/) is an interactive, fully managed service for data engineers and analysts. The service enables real-time analytical and streaming queries to structured and partially structured data using a common SQL dialect.

{% include [not-charged-query.md](../../_includes/pricing/price-formula/not-charged-query.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../query/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ search-api-full-name }} {#search-api}

[{{ search-api-full-name }}](../../search-api/quickstart.md) is a service you can use to submit requests to the Yandex search database and get XML responses. {{ search-api-full-name }} is tailored for developers and webmasters, helping them to implement the search feature on individual websites, groups of websites, or across the internet. Additionally, it offers features to monitor website ranking for specific queries in Yandex search results.

{% include [not-charged-search-api.md](../../_includes/pricing/price-formula/not-charged-search-api.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../search-api/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ serverless-containers-full-name }} {#serverless-containers}

[{{ serverless-containers-full-name }}](../../serverless-containers/quickstart/) allows you to run containerized applications in a secure, fault-tolerant, and scalable environment without creating or maintaining VMs.

{% include [not-charged-streams.md](../../_includes/pricing/price-formula/not-charged-serverless-containers.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../serverless-containers/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ captcha-full-name }} {#smartcaptcha}

[{{ captcha-full-name }}](../../smartcaptcha/quickstart.md) can tell human system users from computers.

{% include [not-charged-smartcaptcha.md](../../_includes/pricing/price-formula/not-charged-smartcaptcha.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../smartcaptcha/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ sws-full-name }} {#smartwebsecurity}

[{{ sws-full-name }}](../../smartwebsecurity/quickstart.md) protects your infrastructure against DDoS attacks and bots at the application level (L7).

{% include [not-charged-smartwebsecurity.md](../../_includes/pricing/price-formula/not-charged-smartwebsecurity.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../smartwebsecurity/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ tracker-full-name }} {#tracker}

[{{ tracker-full-name }}](../../tracker/quick-start.md) is a management service for your projects and processes.

{% include [not-charged-tracker.md](../../_includes/pricing/price-formula/not-charged-tracker.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../tracker/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}

## {{ vpc-full-name }} {#vpc}

[{{ vpc-full-name }}](../../vpc/quickstart.md) is used for managing cloud networks and enabling cloud resource connections to each other and to the internet.

{% include [not-charged-iot.md](../../_includes/pricing/price-formula/not-charged-vpc.md) %}

After you spend the free amount of services, you will be charged at the applicable [rate](../../vpc/pricing.md).

{% include [if-not-used-amount.md](../../_includes/pricing/price-formula/if-not-used-amount.md) %}



## Examples of cost calculations with free tier {#examples}

Usage cost is calculated based on the pricing plans of the relevant service and does not include the amount of services provided for free. See the examples below.

### Calculation of function usage cost {#function-example}

{% include [prices-example](../../_includes/functions/prices-example.md) %}

### Calculation of API gateway usage cost {api-gateway-example}

{% include [prices-example](../../_includes/api-gateway/prices-example.md) %}

### Calculation of {{ iot-full-name }} usage cost {#iot-example}

{% include [prices-example](../../_includes/iot-core/prices-example.md) %}

