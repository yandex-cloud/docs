---
canonical: '{{ link-docs }}/tutorials/dataplatform/mysql-data-migration/'
noIndex: true
---

# Migrating a database from a third-party {{ MY }} cluster

{% note info %}

Migrating data to a third-party {{ MY }} cluster is described in [{#T}](../mmy-to-mysql-migration.md).

{% endnote %}

There are two ways to migrate data from a third-party _source cluster_ to a {{ mmy-name }} _target cluster_:

* [Transferring data using {{ data-transfer-full-name }}](data-transfer.md).

    This method is easy to configure, does not require the creation of an intermediate VM, and allows you to transfer the entire database without interrupting user service. To use it, allow connections to the source cluster from the internet.

    For more information, see [{#T}](../../../data-transfer/concepts/use-cases.md).

* [Transferring data by creating and restoring a logical dump](logical-dump-migration.md).

    A _logical dump_ is a file with a set of commands running which one by one you can restore the state of a database. To achieve a full logical dump, before you create it, switch the source cluster to <q>read-only</q>.

    Use this method only if, for some reason, it is not possible to migrate data using {{ data-transfer-name }}.
