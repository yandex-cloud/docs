---
title: Migrating a database from a third-party {{ MY }} cluster to a {{ mmy-full-name }} cluster
description: 'There are two ways to transfer data from a third-party source cluster to a target {{ mmy-name }} cluster: via {{ data-transfer-full-name }} and by creating and restoring a logical dump.'
---

# Migrating a database from a third-party {{ MY }} cluster to a {{ mmy-full-name }} cluster


There are two ways to migrate data from a third-party _source cluster_ to a {{ mmy-name }} _target cluster_:

* [Transferring data using {{ data-transfer-full-name }}](data-transfer.md).

    This method is easy to configure, does not require the creation of an intermediate VM, and allows you to transfer the entire database without interrupting user service. To use it, allow connections to the source cluster from the internet.

    For more information, see [{#T}](../../../data-transfer/concepts/use-cases.md).

* [Transferring data by creating and restoring a logical dump](logical-dump-migration.md).

    A _logical dump_ is a file with a set of commands running which one by one you can restore the state of a database. To achieve a full logical dump, before you create it, switch the source cluster to <q>read-only</q>.

    Use this method only if, for some reason, it is not possible to migrate data using {{ data-transfer-name }}.
