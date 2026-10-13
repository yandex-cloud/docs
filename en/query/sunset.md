---
title: '{{ yq-full-name }} shutdown'
description: We are sunsetting {{ yq-full-name }}. This page outlines the decommissioning timeline and procedure, and provides migration recommendations.
---

# {{ yq-full-name }} shutdown

{% note warning %}

We are sunsetting {{ yq-full-name }}. This page outlines the decommissioning timeline and procedure, and provides migration recommendations.

{% endnote %}

## What is going on {#what-happens}

We have made the decision to discontinue {{ yq-full-name }}. We understand this may impact your workflows, and we are committed to supporting you through a smooth transition to alternative solutions.

## Key dates {#key-dates}

The discontinuation process will follow these three stages:

* **October 13, 2026**: No new copies of {{ yq-full-name }} will be sold. Customers who signed up for {{ yq-full-name }} earlier will be able to use it until November 10, 2026.

* **November 10, 2026**: {{ yq-full-name }} will go read-only. Creating new entities will no longer be available. Current users will be able to run queries, but will not be able to create and modify {{ yq-full-name }} entities.

* **December 14, 2026**: {{ yq-full-name }} will be fully discontinued. Access to the interface will be disabled for all users.

## What happens to your data {#data}

The original data will not be deleted. Since {{ yq-full-name }} reads data directly from the sources connected to it and does not store it, this data will still persist in the sources once {{ yq-full-name }} is discontinued. However, your connections, data bindings, saved queries, and query history will not be automatically migrated.

## Migration {#migration}

As an alternative, you can use {{ ydb-full-name }} or work with data directly through {{ objstorage-name }}.

[This guide](tutorials/migration.md) might help you to run this process smoothly.

## Further questions {#support}

If you have any questions regarding {{ yq-full-name }} shutdown:

* Contact [support]({{ link-console-support }}).
* Contact your account manager.

Thank you for using {{ yq-full-name }}.
