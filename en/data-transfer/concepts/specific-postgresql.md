---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# PostgreSQL specifics

{% include [features](../../_includes/data-transfer/features-of-work.md) %}

1. If you use [User-defined](https://www.postgresql.org/docs/9.5/xtypes.html) types in your schemas, create a schema for the target database in advance.

    Because of the replication protocol limitations, the replication can only save data from such columns if they have the `text` type.

1. At the copying stage, make sure that the following options are disabled on the target: integrity check for foreign keys, triggers, and other `constraints`.

    This is necessary because it's not possible to check a specific insert. In this configuration, the source ensures guarantees based on foreign keys.

1. Working with [sequences](https://www.postgresql.org/docs/9.5/sql-createsequence.html).

    Replication can't guarantee that sequence values are preserved, so we recommend updating the `sequences` on the target.

1. You can't use the PostgreSQL replication protocol to get information about data schema changes.

    If you change the database schema on the source, the replication operation issues an error at the first insert to a new field or table. To change the schema at this stage, you need the administrator to intervene on the target.

