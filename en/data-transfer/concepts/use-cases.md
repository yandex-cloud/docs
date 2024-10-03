---
title: What tasks {{ data-transfer-full-name }} is used for
description: In this tutorial, you will learn about {{ data-transfer-full-name }} use cases.
---

# What tasks {{ data-transfer-full-name }} is used for

## Testing {{ yandex-cloud }} {#testing}

{{ data-transfer-name }} allows you to test working with [{{ mmg-full-name }}](../../managed-mongodb/), [{{ mmy-full-name }}](../../managed-mysql/), and [{{ mpg-full-name }}](../../managed-postgresql/) on real data.

For example, using {{ data-transfer-name }}, you can connect copies of databases hosted in these services to your application. {{ data-transfer-name }} will keep these copies up-to-date.

## Migrating databases to {{ yandex-cloud }} {#migration}

{{ data-transfer-name }} allows you to transfer your data from third-party services to {{ yandex-cloud }}. For more information about source and target compatibility, see [{#T}](./index.md#connectivity-matrix).

## Creating backups {#backup}

{{ data-transfer-name }} allows you to create and maintain an up-to-date copy of data from {{ yandex-cloud }} in local database. This copy can later be used for disaster recovery.

## Replication and load sharing {#development}

{{ data-transfer-name }} is suitable for separating multiple development environments.

If a stable version of your product is based in {{ yandex-cloud }}, using {{ data-transfer-name }}, you can maintain an up-to-date copy for developers in local databases. Also, {{ data-transfer-name }} allows you to maintain an up-to-date copy of the data in the {{ yandex-cloud }} environment if the stable version is based locally.

At the same time, the main database will not be overloaded.

## Splitting and merging databases {#separation}

Using {{ data-transfer-name }}, you can:

* Split a database into several separate ones.
* Combine multiple databases into one, including by combining different sets of tables.
* During migration, combine all the data into a single database hosted in one of the managed database services.

For more information, see [Compatibility of sources and targets](./index.md#connectivity-matrix).
