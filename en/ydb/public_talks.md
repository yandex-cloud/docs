---
sourcePath: overlay/public_talks.md
---

# Public materials

## Overview materials {#overview}

* [{{ ydb-name }} Whitepaper](https://storage.yandexcloud.net/ydb-public-talks/yandex-database-a4.pdf).

### 2021: about:cloud About Serverless {#about-cloud-20210715}

* Subject: Migrating an application from {{ PG }} to {{ ydb-full-name }} Serverless. Performance, cost, risks.
   * [About the event](/events/408#about).
   * [Presentation](https://storage.yandexcloud.net/ydb-public-talks/pg2ydb.pdf).
   * [Recorded broadcast](https://www.youtube.com/watch?v=8bgtMxkduV8&t=3946s).
   * Description: A study conducted by the {{ ydb-full-name }} team examines aspects of migrating an E-commerce application originally developed for {{ PG }} to {{ ydb-full-name }}. The primary objective of the study is to compare the performance and the cost of the {{ PG }} and {{ ydb-name }} solutions.

### 2021: Yandex Subbotnik for infrastructure development {#inframeetup20210621}

* Subject: Yandex's multi-tenant approach to building a data processing infrastructure.
   * [About the event](https://events.yandex.ru/events/ya-subbotnik-po-infr_19-06-2021/).
   * [Recorded broadcast](https://www.youtube.com/watch?v=35Q2338ywEw&t=4282s).
   * Description: The days when a database instance ran on a dedicated machine are long gone. Now, managed solutions are everywhere launching processes on demand on virtual machines. For computing tasks, we leverage a more advanced approach called serverless computing, for example, AWS Lambda or {{ sf-full-name }}. Serverless databases are the absolute cutting-edge. We'll be discussing serverless solutions that were popular at Yandex long before they were a household name and are still in use for data storage and processing.

### 2021: DevOpsConf {#devopsconf2021}

* Subject: Distributed tracing with Jaeger and {{ ydb-name }}. Auto.ru and {{ yandex-cloud }} share their experience.
   * [About the event](https://devopsconf.io/moscow/2021/abstracts/7522).
   * [Recorded broadcast](https://youtu.be/J0OT8Qxbsvc).
   * Description: We use Jaeger widely as a distributed tracing tool. As load increases, we face the issue of data storage and processing efficiency. In the presentation, we describe our process for choosing a database to store Jaeger traces and the subsequent history of using Jaeger and {{ ydb-name }} at Auto.ru and {{ yandex-cloud }}. The solution gained popularity within Yandex, and we released the Jaeger driver for {{ ydb-name }} as open source. The advent of {{ ydb-name }} Serverless helped users save money, and we wanted to share the results of testing Jaeger with {{ ydb-name }} Serverless.

### 2021: Habr {#habr2021}

* Subject: Serverless alternative to conventional databases.
   * [Article](https://habr.com/ru/post/562746/).
   * Description: A modern distributed DBMS must be able to support different types of load and meet the needs of very different users. The {{ ydb-name }} DBMS enables you to store petabytes of data, support the processing of millions of queries per second and a serverless computing mode, all at the same time. This platform helps support projects with different types of load: key-value, conventional web applications with a relational database, and document-oriented databases.
* Subject: Immersion in Serverless. How {{ ydb-name }} was born.
   * [Article](https://habr.com/ru/post/552032/).
   * Description: We continue our talks with the developers of the Serverless ecosystem: Andrey Fomichev will share details about NewSQL.
* Subject: Yandex's multi-tenant approach to building a data processing infrastructure.
   * [Article](https://habr.com/ru/company/yandex/blog/564854/).
   * Description: The days when a database instance ran on a dedicated machine are long gone. Now, managed solutions are everywhere launching processes on demand on virtual machines. For computing tasks, we leverage a more advanced approach called serverless computing, for example, AWS Lambda or {{ sf-full-name }}. Serverless databases are the absolute cutting-edge. We'll be discussing serverless solutions that were popular at Yandex long before they were a household name and are still in use for data storage and processing.
* Subject: Cooking with serverless. Voice-based service for doctor's appointments and registration at a clinic.
   * [Article](https://habr.com/ru/post/547970/).
   * Description: What kind of a serverless stack do you need, what does a script consist of, and how to build a CRM on the {{ yandex-cloud }} side. The Voximplant communication platform and {{ yandex-cloud }} have created a voice service for registering at a clinic and making doctors' appointments. You can also use it for other similar serverless tasks.

### 2021: Open systems. DBMS {#ospdatabases2021}

* Subject: Serverless alternative to conventional databases.
   * [Article](https://www.osp.ru/os/2021/01/13055826).
   * Description: Serverless computing has become the next step towards reducing the infrastructure "tax" that users of cloud services have to pay; however, there are few databases for this ecosystem out there, and the objective of {{ ydb-name }} is to make up for this shortage.

### 2021: Webinar {{ ydb-short-name }} 2021-01-21 {#webinar20210121}

* Subject: Serverless case study: Integration of {{ yandex-cloud }} services with Voximplant voice technologies.
   * [About the event](/events/298).
   * [Recorded broadcast](https://youtu.be/mB0Wpn2473U).
   * Description:
      1. Voximplant Kit integration with {{ speechkit-full-name }}, a speech recognition and synthesis service.
      1. Voximplant Kit dialog processing setup and automation.
      1. CRM system built with serverless {{ api-gw-full-name }}, {{ sf-name }}, and {{ ydb-name }} (serverless).
      1. [Sample app in Go](https://github.com/yandex-cloud/examples/tree/master/serverless/serverless_voximplant).

### 2020: Yandex Scale. {{ ydb-name }} Serverless. {#scalecloudnative20200925}

* Subject: {{ ydb-name }} Serverless: Public launch.
   * [Recorded broadcast](https://www.youtube.com/watch?v=PD0wjTueIeA&t=9025s).
   * Description: {{ ydb-name }} ({{ ydb-short-name }}) has been launched for public use. Now you can choose to work with dedicated servers or in serverless mode.

### 2020: Webinar {{ ydb-short-name }} 2020-04-23 {#webinar20200423}

* Subject: {{ ydb-name }} news.
   * [Recorded broadcast](https://youtu.be/6LMH4Q4uGBU).
   * Description:
      1. Sample app in Node.js.
      1. JSON support in {{ ydb-short-name }}.
      1. {{ ydb-short-name }} database in {{ yandex-cloud }} available online (whitelisted IP addresses).

### 2019: YaTalks Moscow {#yatalks-moscow-2019}

* Topic: {{ ydb-name }}: How to make HDD perform 10K IOPS and insert 50K records into a table on a single core.
   * [Presentation](https://storage.yandexcloud.net/ydb-public-talks/yatalks-ydb.pptx).
   * [Recorded broadcast](https://youtu.be/hXH_tRBxFnA?t=11283).
   * Description:
      1. A story about successfully using {{ ydb-name }} as a backend for distributed Jaeger trace from [Auto.ru](https://auto.ru) and [Yandex Realty](https://realty.yandex.ru/) representatives.
      1. A talk about the architecture of distributed network storage in {{ ydb-name }}.

### 2019: Yandex Scale {#scale}

* Topic: {{ ydb-name }}: An effective alternative to traditional noSQL solutions.
   * [Presentation](https://storage.yandexcloud.net/ydb-public-talks/08-20190905_yscale_fomichev.pptx).
   * [Recorded broadcast](https://youtu.be/MlSdUq5RIN8).
   * Description: how and why {{ ydb-name }} was created, how it differs from other databases and what tasks it solves best.
* Topic: {{ ydb-name }} at Scale: Practical application in Yandex highload services.
   * [Presentation](https://storage.yandexcloud.net/ydb-public-talks/242-olegbondar.pptx).
   * [Recorded broadcast](https://youtu.be/kubFwIKJjBY).
   * Description: Representatives from [Auto.ru](https://auto.ru), [Yandex Tutor](https://yandex.ru/tutor/), [Alice Voice Assistant](https://yandex.ru/alice), and [Condé Nast](https://www.condenast.ru/) explain why they chose {{ ydb-name }} and how this DBMS helps them develop their products.

### 2019: Webinar {{ ydb-short-name }} {#webinar}

* Subject: {{ ydb-name }} use experience in Yandex products.
   * [Presentation](https://storage.yandexcloud.net/ydb-public-talks/2019-webinar.pptx).
   * [Recorded broadcast](https://youtu.be/qWqU-R-X3Dc).
   * Description: {{ ydb-name }} use experience in Yandex products.

### 2018: about:cloud {#about-cloud}

* Subject: {{ ydb-name }}: a platform for latency-critical distributed data storage systems.
   * [Recorded broadcast](https://youtu.be/Kr6WIYPts8I?t=8558).
   * Description: A look at {{ ydb-short-name }}, a platform for building a variety of data storage and processing systems.
* Subject: {{ ydb-name }}: a distributed SQL database. A few words about {{ ydb-short-name }} as a database.
   * [Recorded broadcast](https://youtu.be/Kr6WIYPts8I?t=10550).
   * Description: {{ ydb-short-name }} as a database.
* Topic: {{ ydb-name }}: network block storage.
   * [Recorded broadcast](https://youtu.be/Kr6WIYPts8I?t=12861).
   * Description: A talk about Network Block Store, a virtual disk service running all {{ yandex-cloud }} VMs.

### 2017: HEISENBUG {#heisenbug2017}

* Subject: Checking a system without starting it.
   * [Presentation](https://2017.heisenbug-moscow.ru/en/talks/2017/msk/79fuksrzakwwqu4cmikw62/).
   * [Recorded broadcast](https://youtu.be/KaeEjsAjV6A).
   * Description: The systems we are developing are getting more complex by the day. And there seems to be no escaping the ubiquitous complexity that permeates everything. Configuration is one aspect of this complexity. On the one hand, configuration has a great impact on system stability and availability, while on the other, there is very little focus on configuration validation. In this report, we will tell you how we test configurations and what benefit it has brought our project. This report will be of interest to anyone wanting to learn a simple approach to increasing a production system's stability and availability.

## Comprehensive {{ ydb-short-name }} {#internals} materials

### 2019: HighLoad++ Moscow {#highloadmoscow2019}

* Subject: Distributed transactions in {{ ydb-short-name }}.
   * [Abstract and presentation](https://www.highload.ru/moscow/2019/abstracts/5324).
   * [Recorded broadcast](https://youtu.be/8AR1u5OZIm8).
   * Description: Mechanism for distributed transaction execution in {{ ydb-short-name }}.

### 2019: DevZen Podcast {#devzen}

* Topic: {{ ydb-name }} structure.
   * [Recorded podcast](https://devzen.ru/episode-0272/).
   * Description: A detailed presentation about the {{ ydb-short-name }} structure and answers to questions.

### 2019: YaTalks Yekaterinburg {#yatalks}

* Subject: {{ ydb-name }}: Distributed SQL database from Yandex.
   * [Presentation](https://storage.yandexcloud.net/ydb-public-talks/YdbInCloud_2.pptx).
   * [Recorded broadcast](https://youtu.be/tzANIAbc99o?t=3012).
   * Description: Basics of distributed query execution in {{ ydb-short-name }}:
      1. Transaction model and isolation levels.
      1. Specifics of the Yandex Query Language (YQL) SQL dialect.
      1. Multi-stage transactions and optimistic blocking.
      1. Efficient execution of queries against distributed databases in general.
      1. Key query performance factors.
      1. Standard {{ ydb-short-name }} practices and developer tools.

### 2019: BackendConf {#backendconf}

* Topic: {{ ydb-name }}: distributed queries in the cloud.
   * [Recorded broadcast](https://youtu.be/V95bBGB-89Y?t=15514).
   * Description: How {{ ydb-short-name }} executes YQL queries.

### 2019: HighLoad++ Siberia {#highload}

* Topic: {{ ydb-name }}: how we ensure fault-tolerance.
   * [Recorded broadcast](https://youtu.be/-GlRSxG4JQU?t=10779).
   * Description: How {{ ydb-short-name }} enables redundant data storage and how {{ ydb-short-name }} ensures distributed consensus.