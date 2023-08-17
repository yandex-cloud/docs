# {{ mes-full-name }} releases

{% include [Elasticsearch-end-of-service](../_includes/mdb/mes/note-end-of-service.md) %}

This section covers the revision history for {{ mes-name }}.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## Q4 2022 {#q4-2022}

* Added the [Reindex remote whitelist](concepts/settings-list.md#setting-reindex-remote-whitelist) setting that allows specifying the list of addresses that can be used as a remote source for [Reindex API]({{ links.es.reindex-api }}).

## Q2 2022 {#q2-2022}

* Removed the ability to create clusters with only two hosts to ensure fault tolerance.
* Terminated `Gold` edition support. On July 6, 2022, all `Gold` edition clusters were automatically upgraded to `Platinum` at the same price through the end of 2022.
* Upgraded support for CLI user extensions: `{{ yc-mdb-es }} extension`. {{ tag-cli }}

## Q1 2022 {#q1-2022}

* Added a standard mechanism for [performing a cluster backup](concepts/backup.md) and [restoring a cluster from a backup](operations/cluster-backups.md#restore). {{ tag-con }}
* Added the ability to set up the maintenance window. {{ tag-con }} {{ tag-cli }} {{ tag-tf }}
* Added the ability to pass a list of custom packages when creating a cluster. {{ tag-cli }} {{ tag-tf }}
