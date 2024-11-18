---
title: '{{ mes-full-name }} release notes'
description: This section contains {{ mes-name }} release notes.
---

# {{ mes-full-name }} release notes

{% include [Elasticsearch-end-of-service](../_includes/mdb/mes/note-end-of-service.md) %}

## Q4 2022 {#q4-2022}

* Added the [Reindex remote whitelist](concepts/settings-list.md#setting-reindex-remote-whitelist) setting that enables specifying the list of addresses that can be used as a remote source for [Reindex API]({{ links.es.reindex-api }}).

## Q2 2022 {#q2-2022}

* Removed the option to create clusters with only two hosts to ensure fault tolerance.
* Discontinued `Gold` edition support. On July 6, 2022, all `Gold` clusters were automatically upgraded to `Platinum` at the same price until the end of 2022.
* Added support for the following user extensions to the CLI: `{{ yc-mdb-es }} extension`.

## Q1 2022 {#q1-2022}

* Added a native [cluster backup](concepts/backup.md) and [cluster restore](operations/cluster-backups.md#restore) tool.
* Added an option to set up the maintenance window.
* Added an option to provide a list of custom packages when creating a cluster.
