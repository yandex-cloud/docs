---
title: Migrating a database from a third-party {{ MY }} cluster to a {{ mmy-full-name }} cluster
description: 'There are two ways to transfer data from a third-party source cluster to a target {{ mmy-name }} cluster: via {{ data-transfer-full-name }} and by creating and restoring a logical dump.'
---

# Migrating a database from a third-party {{ MY }} cluster to a {{ mmy-full-name }} cluster


You can migrate data from a third-party _source cluster_ to a {{ mmy-name }} _target cluster_ using the following two methods:

* [Migrating data via {{ data-transfer-full-name }}](data-transfer.md).

    This method is easy to configure, does not require the creation of an intermediate VM, and allows you to transfer the entire database without interrupting user service. To use it, allow connections to the source cluster from the internet.

    For more information, see [{#T}](../../../data-transfer/concepts/use-cases.md).

* [Migrating data using a logical dump (backup and restore)](logical-dump-migration.md).

    A _logical dump_ is a file containing a sequence of commands allowing you to restore a database to its saved state. To ensure the logical dump is complete, switch the source cluster to <q>read-only</q> mode before creating the dump.

    Use this method only if data migration via {{ data-transfer-name }} is impossible.
