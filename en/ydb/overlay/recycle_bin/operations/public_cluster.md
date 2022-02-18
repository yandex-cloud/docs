<!-- Looks like an outdated version of yandex-team's quickstart.md from / -->

## Getting started with YDB {#how-to-get-started-with-ydb}

The main entry point to YDB: [https://ydb.yandex-team.ru](https://ydb.yandex-team.ru)

### Try YDB {#try-ydb}

If you want to try YDB, just log in to the [web interface](https://ydb.yandex-team.ru) and click Create database.

![Create database](../_assets/db_ui_create_database_button.png)

1. Select a location for the database.

You can select a geographical location for your database.
If a single data center cluster is sufficient, choose dev-sas-slice2 (Sasovo).
If you need a cross-data center cluster, choose ydb-ru (Mytishchi-Vladimir-Sasovo) or ydb-eu (Mäntsälä-Vladimir-Sasovo).

2. Select an account

If you are just starting to work with YDB clusters and don't have a project account, fill out the [form](https://st.yandex-team.ru/createTicket?queue=KIKMIR) to create one.
By default, the home account is selected.

3. Create or select a folder

By default, a folder with your username is created.

4. Select a name for your database.

By default, a database named mydb is created.
Database names can only contain Latin letters.

### Computing resources {#computing-resources}

Computing slots let you increase the number of queries per second that your database processes.
One slot is limited to XX GB of RAM and YY cores.

5. Select the required number of computing slots. We recommend N slots for a load of ZZZZ RPS.

6. If you select multiple computing slots and a cross-data center cluster, you can configure the policy for distributing slots across data centers.

Possible options:
* Auto: Slots are located in a single data center. If it goes down, they're moved to available data centers.
* In one DC: Slots are located in a single data center. If it goes down, all slots are moved to another data center, but are still hosted in a single data center.
* Uniform distribution: Slots are evenly distributed across data centers. If one of them goes down, they're moved to other data centers.

### Data storage {#data-storage}

You can select different types of storage based on the required bandwidth, load profile, query RPS, and redundancy (fault tolerance) requirements.
For cold data storage, choose HDD.
For hot data storage (OLTP load profile), choose SSD.

Storage options are available with the following types of redundancy:
* Mirror-3: Data is stored as 3 complete replicas. Recovery is possible if no more than 2 replicas are lost.
* block-M-N (block-4-2): Data is stored as M fragments that are non-intersecting substrings of source data, supplemented by N fragments of redundancy. Recovery is possible if no more than N replicas are lost.

Below is an example of a form for creating a new database.

![Create new database](../_assets/db_ui_create_new_database.png)

### Old text to be reworked and deleted {#good-old-need-to-be-recycled-and-removed}

You can try KiKiMR using a public cluster named Public Playground (load balancer: playground.ydb.yandex.net). This cluster is deployed in a single data center.

You can work with the cluster via any API (C++/Python/HTTP/CLI). For more information, see [APIs and References](../api/api_libs_overview/).

The KiKiMR Public Playground cluster is available from [YQL](http://yql.yandex-team.ru). Select the KiKiMR cluster type and a specific `Ydbtest` cluster (here's an [operation example](https://yql.yandex-team.ru/Operations/Wfbe98qy16E0f0wX9hDQ5RGv71WN_1iIKXfxWdmsRz4=)).

You can also try a cross-data center cluster that's available to the 3dc-ydb-dev.yandex.net load balancer.
This cluster is also available via the yql web interface under the name `ydbtest_3dc`

Here's an [operation example](https://yql.yandex-team.ru/Operations/WrKQwSdq_dyaIHdHnoUtld_w8u2XDxLLHaZZTp-Mo_A=)