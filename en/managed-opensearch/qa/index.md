---
title: "{{ mes-name }}. Questions and answers"
description: "How do I get the logs of my activity in {{ mos-full-name }}? Find the answer to this and other questions in this article."
---

# Questions and answers about {{ mes-short-name }}

## General questions {#general}

#### How are {{ ES }} clusters maintained? {#service-window}

Maintenance in {{ mes-short-name }} implies:

* Automatic installation of {{ ES }} updates and fixes for your database hosts.
* Changes to the host class and storage size.
* Other {{ mes-short-name }} maintenance activities.

For more information, see [{#T}](../concepts/maintenance.md).

#### Is cluster backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ mes-name }} clusters, a complete backup is performed every hour, and all the indexes are saved. This helps restore a cluster's state from any available backup.

Backups are kept for 7 days.

#### Which version of {{ ES }} does {{ mes-short-name }} use? {#dbms-version}

The {{ ES }} versions maintained by the vendor are available in {{ mes-short-name }}. For more information, see [{#T}](../concepts/update-policy.md).


#### What happens when a new {{ ES }} version is released? {#new-version}

When new versions include only bug fixes (such versions are called _maintenance releases_), the cluster software is automatically updated after a short testing period.

The owners of the affected DB clusters receive advanced notice of expected work times and DB availability.


#### What happens when the {{ ES }} version becomes deprecated? {#dbms-deprecated}

{{ mes-short-name }} automatically notifies cluster owners by email that their {{ ES }} version is approaching end of life.

Clusters running a deprecated version of {{ ES }} are updated according to the [version control policy](../concepts/update-policy.md).

The owners of the affected clusters receive advanced notice of expected work times and DB availability.

{% include [logs](../../_qa/logs.md) %}