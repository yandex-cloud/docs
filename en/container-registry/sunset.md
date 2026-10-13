---
title: '{{ container-registry-full-name }} shutdown'
description: We are sunsetting {{ container-registry-full-name }}. This page outlines the decommissioning timeline and procedure, and provides migration recommendations.
---

# {{ container-registry-full-name }} shutdown

{% note warning %}

We are sunsetting {{ container-registry-full-name }}. This page outlines the decommissioning timeline and procedure, and provides migration recommendations.

{% endnote %}

## What is going on {#what-happens}

We have made the decision to discontinue {{ container-registry-full-name }}. We understand this may impact your workflows, and we are committed to supporting you through a smooth transition to alternative solutions.

## Key dates {#key-dates}

The discontinuation process will follow these three stages:

* **October 13, 2026**: No new copies of {{ container-registry-full-name }} will be sold. Customers who signed up for the service earlier will be able to use it until November 10, 2026.

* **November 10, 2026**: {{ container-registry-full-name }} will go read-only. Creating new registries will no longer be available. The remaining {{ container-registry-full-name }} users will only be able to view previously created registries and export data from them.

* **December 14, 2026**: {{ container-registry-full-name }} will be fully discontinued. Access to the interface will be disabled for all users.

## What happens to your data {#data}

Your data, such as registry metadata, registry access permission settings, IP address access policies, life-cycle policies, scan settings, and registry aliases, will not be lost. Instead, after discontinuation, we will retain backups of your data until June 30, 2027. To get them, you will need to contact our [support]({{ link-console-support }}).

## Migration {#migration}

As an alternative, you can migrate your registries to [{{ cloud-registry-full-name }}](../cloud-registry/).

[This guide](tutorials/container-registry-migration.md) might help you to run this process smoothly.

## Further questions {#support}

If you have any questions regarding {{ container-registry-full-name }} shutdown:

* Contact [support]({{ link-console-support }}).
* Contact your account manager.

Thank you for using {{ container-registry-full-name }}.
