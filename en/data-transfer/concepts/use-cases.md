# What tasks is the service used for?

{{ data-transfer-name }} is designed for a variety of application tasks for migrating databases.

As a source for all tasks, you can use the types of databases that are deployed:

* On-premise.
* In other clouds.
* In [{{ compute-full-name }}](https://cloud.yandex.com/services/compute).
* In [{{ mmy-full-name }}](https://cloud.yandex.com/services/managed-mysql) and [{{ mpg-full-name }}](https://cloud.yandex.com/services/managed-postgresql).

## Testing {{ yandex-cloud }} {#testing}

Test {{ mmy-full-name }} and {{ mpg-full-name }} using your own real data. With {{ data-transfer-name }}, you can easily transfer your data to these services and get acquainted with their features.

You can also launch your application and connect databases from {{ mmy-short-name }} or {{ mpg-short-name }} to it.

## Migrating databases to {{ yandex-cloud }} {#migration}

Transfer your data to {{ yandex-cloud }} using {{ data-transfer-name }}. In this case, the source and target must be the same database, and their schema structures, data types, and codes must be compatible.

## Disaster recovery scenario {#migration}

Use {{ data-transfer-name }} to migrate data from {{ yandex-cloud }} to your local DB. Your server will always have an up-to-date data replica.

## Organizing the development process and load sharing {#development}

Use {{ data-transfer-name }} to separate different development environments.

For example, the developers, testers, or analysts of your product use the {{ yandex-cloud }} infrastructure for their tasks. You can quickly build an environment for a new team member by using {{ data-transfer-name }} to provide them with an up-to-date copy of your product environment.

The scheme can work in reverse order when your current stable version of the service is deployed in {{ yandex-cloud }}, but you need a replica of the data in your local databases for operational purposes. In this case, your production database won't be under extra load.

## Splitting and merging databases {#separation}

Split a single database into several separate ones. You can transfer a different set of tables from the source database to each new one.

Merge multiple databases into one. For example, when migrating to {{ yandex-cloud }}, you can combine your data into a single database using one of the managed DB services. Only homogeneous databases can be merged.

