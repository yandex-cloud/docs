---
canonical: '{{ link-docs }}/tutorials/dataplatform/mysql-data-migration/'
noIndex: true
---

# Migrating a database from a third-party {{ MY }} cluster

{% note info %}

Migrating data to a third-party {{ MY }} cluster is described in [{#T}](../mmy-to-mysql-migration.md).

{% endnote %}

You can migrate data from a third-party _source cluster_ to a {{ mmy-name }} _target cluster_ using the following two methods:

* [Migrating data via {{ data-transfer-full-name }}](data-transfer.md).

    This method is easy to configure, does not require the creation of an intermediate VM, and allows you to transfer the entire database without interrupting user service. To use it, allow connections to the source cluster from the internet.

    For more information, see [{#T}](../../../data-transfer/concepts/use-cases.md).

* [Migrating data using a logical dump (backup and restore)](logical-dump-migration.md).

    A _logical dump_ is a file containing a sequence of commands allowing you to restore a database to its saved state. To ensure the logical dump is complete, switch the source cluster to <q>read-only</q> mode before creating the dump.

    Use this method only if data migration via {{ data-transfer-name }} is impossible.
