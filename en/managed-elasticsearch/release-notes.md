# {{ mes-full-name }} releases

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.07.2022 {#01.07.2022}

* Terminated `Gold` edition support. On July 6, 2022, all `Gold` edition clusters were automatically upgraded to `Platinum` at the same price through the end of 2022.
* Upgraded support for CLI user extensions: `{{ yc-mdb-es }} extension`. {{ tag-cli }}

## 01.05.2022 {#01.05.2022}

* Removed the ability to create clusters with only two hosts to ensure fault tolerance.

## 01.04.2022 {#01.04.2022}

* Added a standard mechanism for [performing a cluster backup](concepts/backup.md) and [restoring a cluster from a backup](operations/cluster-backups.md#restore). {{ tag-con }}
* Added the ability to set up the maintenance window. {{ tag-con }} {{ tag-cli }} {{ tag-tf }}
* Added the ability to pass a list of custom packages when creating a cluster. {{ tag-cli }} {{ tag-tf }}
