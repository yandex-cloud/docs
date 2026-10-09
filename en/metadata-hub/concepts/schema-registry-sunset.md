---
title: '{{ schema-registry-name }} shutdown'
description: We are sunsetting {{ schema-registry-name }}. This page outlines the decommissioning timeline and procedure, and provides migration recommendations.
---

# {{ schema-registry-name }} shutdown

{% note warning %}

We are sunsetting {{ schema-registry-name }}. This page outlines the decommissioning timeline and procedure, and provides migration recommendations.

{% endnote %}

## What is going on {#what-happens}

We have made the decision to discontinue {{ schema-registry-name }}. We understand this may impact your workflows, and we are committed to supporting you through a smooth transition to alternative solutions.

## Key dates {#key-dates}

The discontinuation process will follow these three stages:

* **October 13, 2026**: New users will no longer be able to access {{ schema-registry-name }} through the console. Customers who signed up for the service earlier will be able to use it until November 10, 2026.

* **November 10, 2026**: {{ schema-registry-name }} will go read-only. Creating new data schema registries will no longer be available. Remaining {{ schema-registry-name }} users will only be able to view previously created resources.

* **December 14, 2026**: {{ schema-registry-name }} will be fully discontinued. Access to the interface will be disabled for all users.

## What happens to your data {#data}

Your data, including schema registries, namespaces, schemas, and subjects, will not be lost. Instead, after discontinuation, we will retain backups of your data until January 31, 2027. To get them, you will need to contact our [support]({{ link-console-support }}).

## Further questions {#support}

If you have any questions regarding {{ schema-registry-name }} shutdown:

* Contact [support]({{ link-console-support }}).
* Contact your account manager.

Thank you for using {{ schema-registry-name }}.
