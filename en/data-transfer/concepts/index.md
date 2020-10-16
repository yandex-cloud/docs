# Overview

You can use {{ data-transfer-full-name }} to easily transfer data between databases. This way you can reduce the migration period and minimize downtime when switching to a new database. You don't need to install any drivers to transfer data. All the settings are available in the management console.

## Endpoint {#endpoint}

_Endpoint_ is configuration used to connect to the database.

Endpoints are available for the following databases:

* {{ MY }} user database.
* A database in [{{ mmy-short-name }}<sup>®</sup>](../../managed-mysql).
* {{ PG }} user database.
* A database in [{{ mpg-short-name }}](../../managed-postgresql).

### Types of endpoints {#endpoint-type}

The following types of endpoints are available:

* Source: describes the settings of the database you are going to transfer the data from.
* Target: describes the settings of the database you are going to transfer the data to.

## Transfer {#transfer}

_Transfer_ is the process of transferring data between two endpoints. Put the transfer in the same folder with the endpoints that it connects together.

During the [Preview stage](../../overview/concepts/launch-stages.md), you can only connect endpoints of the same database type. You can make transfers between the following endpoints:

| Source database | Target database |
| ---- | ---- |
| {{ MY }} | {{ mmy-short-name }} |
| {{ mmy-short-name }} | {{ MY }} |
| {{ PG }} | {{ mpg-short-name }} |
| {{ mpg-short-name }} | {{ PG }} |

### Types of transfers {#transfer-type}

The following types of transfers are available:

* Copy: make a one-time transfer of the database snapshot.
* Replicate: continuously retrieve changes from the source database and apply them to the target database.
* Copy and replicate: transfer the data and keep the target database in sync with the source database.

## What tasks does the service solve? {#solutions}

### Migrating homogeneous databases {#migration}

Transfer your data to Yandex.Cloud or from Yandex.Cloud using your disaster recovery scenario. In this case, the source and target must be the same database, and their schema structures, data types, and codes must be compatible.

### Organizing the development process and load sharing {#development}

Use {{ data-transfer-name }} to separate different development environments.

For example, the developers, testers, or analysts of your product use the Yandex.Cloud infrastructure for their tasks. You can quickly build an environment for a new team member, using {{ data-transfer-name }} to provide them with an up-to-date copy of your product environment.

The scheme can work in the reverse order, when your current stable version of the service is deployed in Yandex.Cloud, but you need a replica of the data in your local databases for operational purposes.

### Merging multiple databases {#merge}

Use {{ data-transfer-name }} to combine multiple databases into one database.

For example, when you migrate to Yandex.Cloud, you can combine your data into a single database using the managed database service. Only homogeneous databases can be combined.

## Bandwidth {#bandwidth}

The speed for copying data can reach 15 MBps. It takes 2-3 hours to copy a 100 GB database. When you replicate data, the bandwidth is 20-30 thousand transactions per second.

## Specifics of the service {#specific}

We can't guarantee data migration scenarios between major versions with a minor version.

As databases vary in the protocols they use, please keep in mind the following nuances:

* [{#T}](#mysql).
* [{#T}](#postgresql).

### MySQL specifics {#mysql}

1. Make sure that full binary log mode is enabled for the source database.

1. Working with constraints (`CONSTRAINT`).

    * Constraints (`CONSTRAINT`) are enabled on the target by default. This is taken into account during the transfer. For large databases, this can significantly affect replication performance.
    * At the transfer level, you can disable `CONSTRAINT` to regain performance. However, the behavior may vary depending on the low-level data storage subsystem: unlike [MyISAM](https://en.wikipedia.org/wiki/MyISAM), we can't guarantee cascade delete for [InnoDB](https://en.wikipedia.org/wiki/InnoDB).
1. Only the MyISAM and InnoDB low-level storage subsystems are tested regularly. We don't guarantee that the other low-level storage subsystems will behave properly.

1. Running the `ALTER` operators:

    * In some cases, such operators may slow down replication, but the performance usually recovers after a while.
    * If you perform complex manipulations that involve changing the schema on the source, run explicit checks on the target database.
1. You can change the limit on the size of the chunk sent using the `max_allowed_packet` parameter.

1. [SQL mode](https://dev.mysql.com/doc/mysql-replication-excerpt/5.6/en/replication-features-sql-mode.html) must be the same on the source and target.

    The transfer checks this requirement and, if any discrepancy is found, requests administrator intervention.

### PostgreSQL specifics {#postgresql}

1. If you use [User-defined](https://www.postgresql.org/docs/9.5/xtypes.html) types in your schemas, create a schema for the target database in advance.

    Because of the replication protocol limitations, the replication can only save data from such columns if they have the `text` type.
1. At the copying stage, make sure that the following options are disabled on the target: integrity check for foreign keys, triggers, and other `constraints`.

    This is necessary because it's not possible to check a specific insert. In this configuration, the source ensures guarantees based on foreign keys.
1. Working with [sequences](https://www.postgresql.org/docs/9.5/sql-createsequence.html).

    Replication can't guarantee that sequence values are preserved, so we recommend updating the `sequences` on the target.
1. You can't use the PostgreSQL replication protocol to get information about data schema changes.

    If you change the database schema on the source, the replication operation issues an error at the first insert to a new field or table. To change the schema at this stage, you need the administrator to intervene on the target.

