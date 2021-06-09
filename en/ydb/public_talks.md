# Public materials

## Overview materials {#overview}

- [Yandex Database Whitepaper](https://storage.yandexcloud.net/ydb-public-talks/yandex-database-a4.pdf).

### 2021: YDB Webinar 2021-01-21 {#webinar20210121}

- Topic: Serverless case study: Integration of {{ yandex-cloud }} services with Voximplant voice technologies.
  - [About the event](https://cloud.yandex.ru/events/298).
  - [Recorded broadcast](https://youtu.be/mB0Wpn2473U).
  - Description:
    1. Voximplant Kit integration with {{ speechkit-full-name }}, a speech recognition and synthesis service.
    2. Voximplant Kit dialog processing setup and automation.
    3. CRM system built around a serverless API Gateway, Yandex Cloud Functions, and Yandex Database (serverless).
    4. [Sample app in Go](https://github.com/yandex-cloud/examples/tree/master/serverless/serverless_voximplant).

### 2020: YDB Webinar 2020-04-23 {#webinar20200423}

- Topic: Yandex Database News.
  - [Recorded broadcast](https://youtu.be/6LMH4Q4uGBU).
  - Description:
    1. Sample app in Node.js.
    1. JSON support in YDB.
    1. YDB database in {{ yandex-cloud }} available online (whitelisted IP addresses).

### 2019: YaTalks Moscow {#yatalks-moscow-2019}

- Topic: Yandex Database: How to make HDD perform 10K IOPS and insert 50K records into a table on a single core.
  - [Presentation](https://storage.yandexcloud.net/ydb-public-talks/yatalks-ydb.pptx).
  - [Recorded broadcast](https://youtu.be/hXH_tRBxFnA?t=11283).
  - Description:
    1. A story about successfully using Yandex Database as a backend for distributed Jaeger tracing from [Auto.ru](https://auto.ru) and [Yandex.Realty](https://realty.yandex.ru/) representatives.
    1. A talk about the architecture of distributed network storage in Yandex Database.

### 2019: Yandex Scale {#scale}

- Topic: Yandex Database: An effective alternative to traditional noSQL solutions.
  - [Presentation](https://storage.yandexcloud.net/ydb-public-talks/08-20190905_yscale_fomichev.pptx).
  - [Recorded broadcast](https://youtu.be/MlSdUq5RIN8).
  - Description: How and why Yandex Database was created, how it differs from other databases, and what tasks it is best suited for.

- Topic: Yandex Database at Scale: Practical application in Yandex highload services.
  - [Presentation](https://storage.yandexcloud.net/ydb-public-talks/2019-webinar.pptx).
  - [Recorded broadcast](https://youtu.be/kubFwIKJjBY).
  - Description: Representatives from [Auto.ru](https://auto.ru), [Yandex.Tutor](https://yandex.ru/tutor/), [Alice Voice Assistant](https://yandex.ru/alice), and [Condé Nast](https://www.condenast.ru/) explain why they chose Yandex Database and how this DBMS helps them develop their products.

### 2019: YDB Webinar {#webinar}

- Topic: Yandex Database use experience in Yandex products.
  - [Presentation](https://storage.yandexcloud.net/ydb-public-talks/2019-webinar.pptx).
  - [Recorded broadcast](https://youtu.be/qWqU-R-X3Dc).
  - Description: Yandex Database use experience in Yandex products.

### 2018: about:cloud {#about-cloud}

- Topic: Yandex Database: A platform for distributed latency-critical data storage systems.
  - [Recorded broadcast](https://youtu.be/Kr6WIYPts8I?t=8558).
  - Description: A look at YDB, a platform for building a variety of data storage and processing systems.

- Topic: Yandex Database: A newSQL database. A few words about YDB as a database.
  - [Recorded broadcast](https://youtu.be/Kr6WIYPts8I?t=10550).
  - Description: YDB as a database.

- Topic: Yandex Database: Network Block Store.
  - [Recorded broadcast](https://youtu.be/Kr6WIYPts8I?t=12861).
  - Description: A talk about Network Block Store, a virtual disk service running all {{ yandex-cloud }} VMs.

## Comprehensive YDB materials {#internals}

### 2019: HighLoad++ Moscow {#highloadmoscow2019}

- Topic: Distributed transactions in YDB.
  - [Abstracts and presentation](https://www.highload.ru/moscow/2019/abstracts/5324).
  - [Recorded broadcast](https://youtu.be/8AR1u5OZIm8).
  - Description: Mechanism for distributed transaction execution in YDB.

### 2019: DevZen Podcast {#devzen}

- Topic: Yandex Database Structure.
  - [Recorded podcast](https://devzen.ru/episode-0272/).
  - Description: A detailed talk about the YDB structure and answers to questions.

### 2019: YaTalks Yekaterinburg {#yatalks}

- Topic: Yandex Database: A newSQL database from Yandex.
  - [Presentation](https://storage.yandexcloud.net/ydb-public-talks/YdbInCloud_2.pptx).
  - [Recorded broadcast](https://youtu.be/tzANIAbc99o?t=3012).
  - Description: Basics of distributed query execution in YDB:
    1. Transaction model and isolation levels.
    1. Specifics of the Yandex Query Language (YQL) SQL dialect.
    1. Multi-stage transactions and optimistic blocking.
    1. Efficient query execution against distributed databases.
    1. Key query performance factors.
    1. Standard YDB practices and developer tools.

### 2019: BackendConf {#backendconf}

- Topic: Yandex Database: Distributed queries in the cloud.
  - [Recorded broadcast](https://youtu.be/V95bBGB-89Y?t=15514).
  - Description: How YDB runs YQL queries.

### 2019: HighLoad++ Siberia {#highload}

- Topic: Yandex Database: How we ensure fault-tolerance.
  - [Recorded broadcast](https://youtu.be/-GlRSxG4JQU?t=10779).
  - Description: How YDB enables redundant data storage and distributed consensus.

{% if audience != "external" %}

### 2019: HydraConf {#hydraconf}

- Topic: Yandex Database: how we guarantee fault tolerance.
  - [Presentation](https://storage.yandexcloud.net/ydb-public-talks/Hydra_2019_Vladislav_Kuznetsov_Yandex_Database__kak_my_obespechivayem_otkazoustoychivost.pptx).
  - [Recorded broadcast](https://youtu.be/_7FAeeWAhT4).
  - Description: How YDB enables redundant data storage and distributed consensus.
- Topic: Distributed transactions in YDB.
  - [Presentation](https://storage.yandexcloud.net/ydb-public-talks/Hydra_2019_Semen_Checherinda_Raspredelennyye_tranzaktsii_v_YDB%20(2).pptx).
  - [Recorded broadcast](https://youtu.be/85GIFpG3zx4).
  - Description: Mechanism for distributed transaction execution in YDB.

{% endif %}
