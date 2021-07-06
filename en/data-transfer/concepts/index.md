---
title: "Relationship between {{data-transfer-full-name}} service resources"
description: "{{data-transfer-full-name}} allows you to easily transfer data between databases. The service allows you to reduce the time for the migration process, minimize downtime when switching to a new database or have a permanent replica of the database."
---

# Relationship between service resources

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

* Source: Describes the settings of the database you are going to transfer the data from.
* Target: Describes the settings of the database you are going to transfer the data to.

## Transfer {#transfer}

_Transfer_ is the process of transmitting data between the source and target endpoints. Put the transfer in the same folder with the endpoints that it connects together.

You can make transfers between the following endpoints:

| Source database | Target database |
| ---- | ---- |
| {{ MY }} | {{ mmy-short-name }} |
| {{ mmy-short-name }} | {{ MY }} |
| {{ PG }} | {{ mpg-short-name }} |
| {{ mpg-short-name }} | {{ PG }} |

### Types of transfers {#transfer-type}

The following types of transfers are available:

* Copy: Make a one-time transfer of the database snapshot.
* Replicate: Continuously retrieve changes from the source database and apply them to the target database.
* Copy and replicate: Transfer the data and keep the target database in sync with the source database.

## Bandwidth {#bandwidth}

The speed for copying data can reach 15 MBps. It takes 2-3 hours to copy a 100 GB database. When you replicate data, the bandwidth is 20-30 thousand transactions per second.

