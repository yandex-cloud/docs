### Storage and backups {#prices-storage}

Service | Cost of 1 GB per month, with VAT | |
----- | ----- | -----
| | **Up until April 12, 2022** | **Starting April 13, 2022** |
Data storage in storage groups of SSD drives | {{ sku|KZT|ydb.cluster.v1.ssd|month|string }} | ₸107.3
Storage of on-demand backups in {{ objstorage-full-name }} | ₸7.5660 | ₸10.05

{% note info "Minimum group size" %}

A single [storage group](../../ydb/concepts/databases.md##storage-groups) can store up to 100 GB of user data. The minimum granularity of space allocation for a DB is one storage group.

{% endnote %}

To create on-demand backups in {{ ydb-name }}, specify a bucket in {{ objstorage-name }}.
