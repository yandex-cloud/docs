# {{ mes-full-name }} revision history

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.05.2022 {#01.05.2022}

* Removed the ability to create clusters with only two hosts to ensure fault tolerance.

## 01.04.2022 {#01.04.2022}

* Added a standard mechanism for [performing a cluster backup](concepts/backup.md) and [restoring a cluster from a backup](operations/cluster-backups.md#restore). {{ tag-con }}
* Added the ability to set up the maintenance window. {{ tag-con }} {{ tag-cli }} {{ tag-tf }}
* Added the ability to pass a list of custom packages when creating a cluster. {{ tag-cli }} {{ tag-tf }}
