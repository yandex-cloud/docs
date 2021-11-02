---
title: "Managed Service for Elasticsearch. FAQ"
description: "How do I get the logs of my work in a managed Elasticsearch service? Answers to this and other questions in this article."
---

# Questions and answers about {{ mes-short-name }}

## General questions {#general}

#### How are {{ ES }} clusters maintained? {#service-window}

Maintenance in {{ mes-short-name }} implies:

* Automatic installation of {{ ES }} updates and fixes for your database hosts.
* Changes to the host class and storage size.
* Other {{ mes-short-name }} maintenance activities.

#### Which version of {{ ES }} does {{ mes-short-name }} use? {#dbms-version}

The {{ ES }} versions maintained by the vendor are available in {{ mes-short-name }}. To learn more, see [{#T}](../concepts/update-policy.md).

#### What happens when a new {{ ES }} version is released? {#new-version}

When new versions include only bug fixes (such versions are called _maintenance releases_), the cluster software is automatically updated after a short testing period.

The owners of the affected DB clusters receive advanced notice of expected work times and DB availability.

#### What happens when the {{ ES }} version becomes deprecated? {#dbms-deprecated}

{{ mes-short-name }} automatically notifies cluster owners by email that their {{ ES }} version is approaching end of life.

Clusters running a deprecated version of {{ ES }} are updated according to the [version control policy](../concepts/update-policy.md).

The owners of the affected clusters receive advanced notice of expected work times and DB availability.

{% include [qa-logs.md](../../_includes/qa-logs.md) %}

