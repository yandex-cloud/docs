---
title: '{{ iot-full-name }} shutdown'
description: We are sunsetting {{ iot-full-name }}. This page outlines the decommissioning timeline and procedure, and provides migration recommendations.
---

# {{ iot-full-name }} shutdown

{% note warning %}

We are sunsetting {{ iot-full-name }}. This page outlines the decommissioning timeline and procedure, and provides migration recommendations.

{% endnote %}

## What's happening {#what-happens}

We have made the decision to discontinue {{ iot-full-name }}. We understand this may impact your workflows, and we are committed to supporting you through a smooth transition to alternative solutions.

## Key dates {#key-dates}

The decommissioning process will follow these three stages:

* **April 27, 2026**: End of sales for {{ iot-full-name }}. Customers who signed up for the service earlier will be able to use it until November 1, 2026.

* **November 1, 2026**: Transition to read-only mode. You will not be able to create new resources or write data to registries and brokers. Remaining {{ iot-full-name }} users will only be able to view previously created resources.

* **December 1, 2026**: Full decommissioning. Access to the interface will be disabled for all users.

## What happens to your data {#data}

Your data (lists of devices, device aliases, brokers, as well as device and broker certificates) will be preserved. After decommissioning, we will retain backups of your data until January 31, 2027. To get them, you will need to contact our [support]({{ link-console-support }}).

## Migration {#migration}

Alternatively, migrate your scenarios to open source tools.

We have prepared a guide to help you with migration: [{#T}](tutorials/iot-core-migration.md).

{% include [migration-note](../_includes/iot-core/migration-note.md) %}

## Further questions {#support}

If you have any questions related to service shutdown:

* Contact [support]({{ link-console-support }}).
* Contact your account manager.

Thank you for using {{ iot-full-name }}.
